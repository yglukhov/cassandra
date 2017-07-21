import bindings, linker_options
import os, locks, posix, asyncfile, strutils, asyncdispatch

var pipeLock: Lock
var pipeFd: cint

type GcHoldRef = ref object

template wrapCassType(typ: untyped) =
    type
        typ* = ref object
            o*: ptr `Cass typ`

    converter toGcHoldRef(r: typ): GcHoldRef = cast[GcHoldRef](r)
    converter toCassTyp(r: typ): ptr `Cass typ` = r.o

wrapCassType(Session)
wrapCassType(Cluster)
wrapCassType(Statement)
wrapCassType(Result)

type
    Row* = object
        o*: ptr CassRow
        gcHold: GcHoldRef

    Value* = object
        o*: ptr CassValue
        gcHold: GcHoldRef

proc finalize(c: Cluster) = cass_cluster_free(c.o)
proc finalize(c: Session) = cass_session_free(c.o)
proc finalize(c: Result) = cass_result_free(c.o)
proc finalize(c: Statement) = cass_statement_free(c.o)

proc newCluster*(): Cluster =
    result.new(finalize)
    result.o = cass_cluster_new()

proc newSession*(): Session =
    result.new(finalize)
    result.o = cass_session_new()

proc newResult(r: ptr CassResult): Result =
    result.new(finalize)
    result.o = r

type CasFutureData = ref object
    fut: Future[Result]
    casFut: ptr CassFuture
    next: CasFutureData
    gcHold1, gcHold2: GcHoldRef

type CassandraException* = object of Exception
    casErr*: CassError

var futDataPool: CasFutureData

proc allocateData(): CasFutureData {.inline.} =
    result = futDataPool
    if result.isNil:
        result.new()
    else:
        futDataPool = result.next
    GC_ref(result)

proc dealloc(d: CasFutureData) {.inline.} =
    GC_unref(d)
    d.fut = nil
    d.gcHold1 = nil
    d.gcHold2 = nil
    d.next = futDataPool
    futDataPool = d

proc setNonBlocking(fd: cint) {.inline.} =
  var x = fcntl(fd, F_GETFL, 0)
  if x != -1:
    var mode = x or O_NONBLOCK
    discard fcntl(fd, F_SETFL, mode)

proc dispatch_cas_future_main_thread(data: pointer) {.inline.} =
    let data = cast[CasFutureData](data)
    let f = data.fut
    let casF = data.casFut
    data.dealloc()

    let rc = cass_future_error_code(casF)
    if rc != CASS_OK:
        let e = newException(CassandraException, "future exception")
        e.casErr = rc
        cass_future_free(casF)
        f.fail(e)
    else:
        let res = newResult(cass_future_get_result(casF))
        cass_future_free(casF)
        f.complete(res)

proc runMainThreadSelector(s: AsyncFile) {.async.} =
    var p: pointer
    while true:
        discard await s.readBuffer(addr p, sizeof(p))
        dispatch_cas_future_main_thread(p)

proc initDispatch() =
    initLock(pipeLock)
    var pipeFds: array[2, cint]
    discard posix.pipe(pipeFds)
    pipeFd = pipeFds[1]
    setNonBlocking(pipeFds[0])
    let file = newAsyncFile(AsyncFD(pipeFds[0]))
    asyncCheck runMainThreadSelector(file)

{.push stackTrace: off.}
proc dispatch_cas_future(cas: ptr CassFuture, data: pointer) {.cdecl.} =
    pipeLock.acquire()
    discard posix.write(pipeFd, unsafeAddr data, sizeof(data))
    pipeLock.release()
{.pop.}

proc make(f: var Future[Result], cas: ptr CassFuture, holdRef1: GcHoldRef = nil, holdRef2: GcHoldRef = nil) =
    if pipeFd == 0:
        initDispatch()

    f = newFuture[Result]()
    let data = allocateData()
    data.fut = f
    data.casFut = cas
    data.gcHold1 = holdRef1
    data.gcHold2 = holdRef2
    discard cass_future_set_callback(cas, dispatch_cas_future, cast[pointer](data))

proc raiseCassException(err: CassError) =
    let e = newException(CassandraException, "future exception: " & $err)
    e.casErr = err
    raise e

proc newStatement*(query: cstring, params_count: int): Statement =
    result.new(finalize)
    result.o = cass_statement_new(query, csize(params_count))

proc newStatement*(query: static[string]): Statement {.inline.} =
    const numParams = query.count('?')
    result = newStatement(query, numParams)

proc newStatement*(query: string): Statement {.inline.} =
    result = newStatement(query, query.count('?'))

template chck(e: untyped) =
    let err = e
    if err != CASS_OK: raiseCassException(err)

proc setContactPoints*(cluster: Cluster, contact_points: cstring) {.inline.} =
    chck cass_cluster_set_contact_points(cluster, contact_points)

proc connect*(session: Session, cluster: Cluster): Future[Result] {.inline.} =
    result.make(cass_session_connect(session, cluster), session, cluster)

proc execute*(session: Session, statement: Statement): Future[Result] {.inline.} =
    result.make(cass_session_execute(session, statement), session, statement)

proc bindParam*(statement: Statement, idx: int, v: string) {.inline.} =
    chck cass_statement_bind_string(statement, csize(idx), v)

template `[]=`*[T](statement: Statement, idx: int, v: T) =
    statement.bindParam(idx, v)

proc firstRow*(r: Result): Row {.inline.} =
    result.o = cass_result_first_row(r)
    result.gcHold = r

type ColumnsCollection = distinct Row

template columns*(r: Row): ColumnsCollection = ColumnsCollection(r)

proc `[]`*(cc: ColumnsCollection, name: cstring): Value {.inline.} =
    result.o = cass_row_get_column_by_name(Row(cc).o, name)
    result.gcHold = Row(cc).gcHold

proc `[]`*(cc: ColumnsCollection, idx: int): Value {.inline.} =
    result.o = cass_row_get_column(Row(cc).o, idx)
    result.gcHold = Row(cc).gcHold

proc kind*(v: Value): CassValueType {.inline.} = cass_value_type(v.o)

converter toString*(v: Value): string =
    var c: cstring
    var sz: csize
    chck cass_value_get_string(v.o, cast[cstringArray](addr c), addr sz)
    result = newString(sz)
    if sz > 0:
        copyMem(addr result[0], c, sz)

converter toInt8*(v: Value): int8 =
    chck cass_value_get_int8(v.o, addr result)

converter toInt16*(v: Value): int16 =
    chck cass_value_get_int16(v.o, addr result)

converter toInt32*(v: Value): int32 =
    chck cass_value_get_int32(v.o, addr result)

converter toUint32*(v: Value): uint32 =
    chck cass_value_get_uint32(v.o, addr result)

converter toInt64*(v: Value): int64 =
    chck cass_value_get_int64(v.o, addr result)

converter toFloat32*(v: Value): float32 =
    chck cass_value_get_float(v.o, addr result)

converter toFloat64*(v: Value): float64 =
    chck cass_value_get_double(v.o, addr result)

converter toBool*(v: Value): bool =
    var b: cass_bool_t
    chck cass_value_get_bool(v.o, addr b)
    result = bool(b)

proc `$`*(v: Value): string =
    case v.kind
    of CASS_VALUE_TYPE_BOOLEAN: $bool(v)
    of CASS_VALUE_TYPE_COUNTER: $int64(v)
    of CASS_VALUE_TYPE_DECIMAL: "?DECIMAL?" #TODO 
    of CASS_VALUE_TYPE_DOUBLE: $float64(v)
    of CASS_VALUE_TYPE_FLOAT: $float32(v)
    of CASS_VALUE_TYPE_INT: $int32(v)
    of CASS_VALUE_TYPE_TEXT, CASS_VALUE_TYPE_VARCHAR: string(v)
    of CASS_VALUE_TYPE_TIMESTAMP: "?TIMESTAMP?"
    of CASS_VALUE_TYPE_UUID: "?UUID?"
    of CASS_VALUE_TYPE_VARINT: "?VARINT?"
    of CASS_VALUE_TYPE_TIMEUUID: "?TIMEUUID?"
    of CASS_VALUE_TYPE_INET: "?INET?"
    of CASS_VALUE_TYPE_DATE: "?DATE?"
    of CASS_VALUE_TYPE_TIME: "?TIME?"
    of CASS_VALUE_TYPE_SMALL_INT: $int16(v)
    of CASS_VALUE_TYPE_TINY_INT: $int8(v)
    of CASS_VALUE_TYPE_DURATION: "?DURATION?"
    of CASS_VALUE_TYPE_LIST: "?LIST?"
    of CASS_VALUE_TYPE_MAP: "?MAP?"
    of CASS_VALUE_TYPE_SET: "?SET?"
    of CASS_VALUE_TYPE_UDT: "?UDT?"
    of CASS_VALUE_TYPE_TUPLE: "?TUPLE?"
    else: "?"
