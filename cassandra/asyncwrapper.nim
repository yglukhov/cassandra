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
wrapCassType(TimestampGen)
wrapCassType(RetryPolicy)

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
proc finalize(c: TimestampGen) = cass_timestamp_gen_free(c.o)
proc finalize(c: RetryPolicy) = cass_retry_policy_free(c.o)

proc newCluster*(): Cluster =
    result.new(finalize)
    result.o = cass_cluster_new()

proc newSession*(): Session =
    result.new(finalize)
    result.o = cass_session_new()

proc newResult(r: ptr CassResult): Result =
    result.new(finalize)
    result.o = r

proc newTimestampGen(r: ptr CassTimestampGen): TimestampGen =
    result.new(finalize)
    result.o = r

proc newRetryPolicy(r: ptr CassRetryPolicy): RetryPolicy =
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
        var cmsg: cstring
        var sz: csize
        cass_future_error_message(casF, cast[cstringArray](addr cmsg), addr sz)
        let msg = $cmsg
        let e = newException(CassandraException, "future exception: " & msg)
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

proc newStmt(query: string, params_count: int): Statement =
    result.new(finalize)
    result.o = cass_statement_new_n(query, query.len, csize(params_count))

proc newStatement*(query: string, params_count: int): Statement {.inline.} =
    newStmt(query, params_count)

proc newStatement*(query: static[string]): Statement {.inline.} =
    const numParams = query.count('?')
    newStmt(query, numParams)

proc newStatement*(query: string): Statement {.inline.} =
    newStmt(query, query.count('?'))

template chck(e: untyped) =
    let err = e
    if err != CASS_OK: raiseCassException(err)

proc setContactPoints*(cluster: Cluster, hosts: string) {.inline.} =
    chck cass_cluster_set_contact_points_n(cluster, hosts, hosts.len)

proc setPort*(cluster: Cluster, port: int) {.inline.} =
    chck cass_cluster_set_port(cluster, cint(port))

proc setNumThreadsIO*(cluster: Cluster, num_threads: int) {.inline.} =
    chck cass_cluster_set_num_threads_io(cluster, cuint(num_threads))

proc setQueueSizeIO*(cluster: Cluster, queue_size: int) {.inline.} =
    chck cass_cluster_set_queue_size_io(cluster, cuint(queue_size))

proc setQueueSizeEvent*(cluster: Cluster, queue_size: int) {.inline.} =
    chck cass_cluster_set_queue_size_event(cluster, cuint(queue_size))

proc setQueueSizeLog*(cluster: Cluster, queue_size: int) {.inline.} =
    chck cass_cluster_set_queue_size_log(cluster, cuint(queue_size))

proc setCoreConnectionsPerHost*(cluster: Cluster, num_connections: int) {.inline.} =
    chck cass_cluster_set_core_connections_per_host(cluster, cuint(num_connections))

proc setMaxConnectionsPerHost*(cluster: Cluster, num_connections: int) {.inline.} =
    chck cass_cluster_set_max_connections_per_host(cluster, cuint(num_connections))

proc setReconnectWaitTime*(cluster: Cluster, wait_time: int) {.inline.} =
    cass_cluster_set_reconnect_wait_time(cluster, cuint(wait_time))

proc setMaxConcurrentCreation*(cluster: Cluster, num_connections: int) {.inline.} =
    chck cass_cluster_set_max_concurrent_creation(cluster, cuint(num_connections))

proc setMaxConcurrentRequestsThreshold*(cluster: Cluster, num_requests: int) {.inline.} =
    chck cass_cluster_set_max_concurrent_requests_threshold(cluster, cuint(num_requests))

proc setMaxRequestsPerFlush*(cluster: Cluster, num_requests: int) {.inline.} =
    chck cass_cluster_set_max_requests_per_flush(cluster, cuint(num_requests))

proc setWriteBytesHighWaterMark*(cluster: Cluster, num_bytes: int) {.inline.} =
    chck cass_cluster_set_write_bytes_high_water_mark(cluster, cuint(num_bytes))

proc setWriteBytesLowWaterMark*(cluster: Cluster, num_bytes: int) {.inline.} =
    chck cass_cluster_set_write_bytes_low_water_mark(cluster, cuint(num_bytes))

proc setPendingRequestsHighWaterMark*(cluster: Cluster, num_bytes: int) {.inline.} =
    chck cass_cluster_set_pending_requests_high_water_mark(cluster, cuint(num_bytes))

proc setPendingRequestsLowWaterMark*(cluster: Cluster, num_bytes: int) {.inline.} =
    chck cass_cluster_set_pending_requests_low_water_mark(cluster, cuint(num_bytes))

proc setConnectTimeout*(cluster: Cluster, timeout_ms: int) {.inline.} =
    cass_cluster_set_connect_timeout(cluster, cuint(timeout_ms))

proc setRequestTimeout*(cluster: Cluster, timeout_ms: int) {.inline.} =
    cass_cluster_set_request_timeout(cluster, cuint(timeout_ms))

proc setResolveTimeout*(cluster: Cluster, timeout_ms: int) {.inline.} =
    cass_cluster_set_resolve_timeout(cluster, cuint(timeout_ms))

proc setCredentials*(cluster: Cluster, username, password: string) {.inline.} =
    cass_cluster_set_credentials_n(cluster, username, username.len, password, password.len)

proc setLoadBalanceRoundRobin*(cluster: Cluster) {.inline.} =
    cass_cluster_set_load_balance_round_robin(cluster)

proc setLoadBalanceDCAware*(cluster: Cluster, local_dc: string; used_hosts_per_remote_dc: int;
        allow_remote_dcs_for_local_cl: bool) {.inline.} =
    chck cass_cluster_set_load_balance_dc_aware_n(cluster, local_dc, local_dc.len,
        cuint(used_hosts_per_remote_dc), cass_bool_t(allow_remote_dcs_for_local_cl))

proc setTokenAwareRouting*(cluster: Cluster, enabled: bool) {.inline.} =
    cass_cluster_set_token_aware_routing(cluster, cass_bool_t(enabled))

proc setLatencyAwareRouting*(cluster: Cluster, enabled: bool) {.inline.} =
    cass_cluster_set_latency_aware_routing(cluster, cass_bool_t(enabled))

proc setLatencyAwareRoutingSettings*(cluster: Cluster, exclusion_threshold: float;
        scale_ms, retry_period_ms, update_rate_ms, min_measured: uint64) {.inline.} =
    cass_cluster_set_latency_aware_routing_settings(cluster, exclusion_threshold,
        scale_ms, retry_period_ms, update_rate_ms, min_measured)

proc setWhitelistFiltering*(cluster: Cluster, hosts: string) {.inline.} =
    cass_cluster_set_whitelist_filtering_n(cluster, hosts, hosts.len)

proc setBlacklistFiltering*(cluster: Cluster, hosts: string) {.inline.} =
    cass_cluster_set_blacklist_filtering_n(cluster, hosts, hosts.len)

proc setWhitelistDCFiltering*(cluster: Cluster, dcs: string) {.inline.} =
    cass_cluster_set_whitelist_dc_filtering_n(cluster, dcs, dcs.len)

proc setBlacklistDCFiltering*(cluster: Cluster, dcs: string) {.inline.} =
    cass_cluster_set_blacklist_dc_filtering_n(cluster, dcs, dcs.len)

proc setTCPNodelay*(cluster: Cluster, enabled: bool) {.inline.} =
    cass_cluster_set_tcp_nodelay(cluster, cass_bool_t(enabled))

proc setTCPKeepalive*(cluster: Cluster, enabled: bool, delay_secs: int) {.inline.} =
    cass_cluster_set_tcp_keepalive(cluster, cass_bool_t(enabled), cuint(delay_secs))

proc setTimestampGen*(cluster: Cluster, timestamp_gen: TimestampGen) {.inline.} =
    cass_cluster_set_timestamp_gen(cluster, timestamp_gen.o)

proc setConnectionHearbeatInterval*(cluster: Cluster, interval_secs: int) {.inline.} =
    cass_cluster_set_connection_heartbeat_interval(cluster, cuint(interval_secs))

proc setConnectionIdleTimeout*(cluster: Cluster, timeout_secs: int) {.inline.} =
    cass_cluster_set_connection_idle_timeout(cluster, cuint(timeout_secs))

proc setRetryPolicy*(cluster: Cluster, policy: RetryPolicy) {.inline.} =
    cass_cluster_set_retry_policy(cluster, policy)

proc setUseSchema*(cluster: Cluster, enabled: bool) {.inline.} =
    cass_cluster_set_use_schema(cluster, cass_bool_t(enabled))

proc setUseHostnameResolution*(cluster: Cluster, enabled: bool) {.inline.} =
    chck cass_cluster_set_use_hostname_resolution(cluster, cass_bool_t(enabled))

proc setUseRandomizedContactPoints*(cluster: Cluster, enabled: bool) {.inline.} =
    chck cass_cluster_set_use_randomized_contact_points(cluster, cass_bool_t(enabled))

proc setConstantSpeculativeExecutionPolicy*(cluster: Cluster, constant_delay_ms: int64;
        max_speculative_executions: int) {.inline.} =
    chck cass_cluster_set_constant_speculative_execution_policy(cluster, constant_delay_ms,
        cint(max_speculative_executions))

proc setNoSpeculativeExecutionPolicy*(cluster: Cluster) {.inline.} =
    chck cass_cluster_set_no_speculative_execution_policy(cluster)

proc newTimestampGenServerSide*(): TimestampGen {.inline.} =
    newTimestampGen(cass_timestamp_gen_server_side_new())

proc newTimestampGenMonotonic*(): TimestampGen {.inline.} =
    newTimestampGen(cass_timestamp_gen_monotonic_new())

proc newTimestampGenMonotonic*(warning_threshold_us, warning_interval_ms: int64): TimestampGen {.inline.} =
    newTimestampGen(cass_timestamp_gen_monotonic_new_with_settings(warning_threshold_us, warning_interval_ms))

proc newRetryPolicyDefault*(): RetryPolicy {.inline.} =
    newRetryPolicy(cass_retry_policy_default_new())

proc newRetryPolicyDowngradingConsistency*(): RetryPolicy {.inline.} =
    newRetryPolicy(cass_retry_policy_downgrading_consistency_new())

proc newRetryPolicyFallthrough*(): RetryPolicy {.inline.} =
    newRetryPolicy(cass_retry_policy_fallthrough_new())

proc newRetryPolicyLogging*(child: RetryPolicy): RetryPolicy {.inline.} =
    newRetryPolicy(cass_retry_policy_logging_new(child))

proc connect*(session: Session, cluster: Cluster): Future[Result] {.inline.} =
    result.make(cass_session_connect(session, cluster), session, cluster)

proc execute*(session: Session, statement: Statement): Future[Result] {.inline.} =
    result.make(cass_session_execute(session, statement), session, statement)

proc bindParam*(statement: Statement, idx: int, v: int8) {.inline.} =
    chck cass_statement_bind_int8(statement, csize(idx), v)

proc bindParam*(statement: Statement, name: string, v: int8) {.inline.} =
    chck cass_statement_bind_int8_by_name_n(statement, name, name.len, v)

proc bindParam*(statement: Statement, idx: int, v: int16) {.inline.} =
    chck cass_statement_bind_int16(statement, csize(idx), v)

proc bindParam*(statement: Statement, name: string, v: int16) {.inline.} =
    chck cass_statement_bind_int16_by_name_n(statement, name, name.len, v)

proc bindParam*(statement: Statement, idx: int, v: int32) {.inline.} =
    chck cass_statement_bind_int32(statement, csize(idx), v)

proc bindParam*(statement: Statement, name: string, v: int32) {.inline.} =
    chck cass_statement_bind_int32_by_name_n(statement, name, name.len, v)

proc bindParam*(statement: Statement, idx: int, v: uint32) {.inline.} =
    chck cass_statement_bind_uint32(statement, csize(idx), v)

proc bindParam*(statement: Statement, name: string, v: uint32) {.inline.} =
    chck cass_statement_bind_uint32_by_name_n(statement, name, name.len, v)

proc bindParam*(statement: Statement, idx: int, v: int64) {.inline.} =
    chck cass_statement_bind_int64(statement, csize(idx), v)

proc bindParam*(statement: Statement, name: string, v: int64) {.inline.} =
    chck cass_statement_bind_int64_by_name_n(statement, name, name.len, v)

proc bindParam*(statement: Statement, idx: int, v: float32) {.inline.} =
    chck cass_statement_bind_float(statement, csize(idx), v)

proc bindParam*(statement: Statement, name: string, v: float32) {.inline.} =
    chck cass_statement_bind_float_by_name_n(statement, name, name.len, v)

proc bindParam*(statement: Statement, idx: int, v: float64) {.inline.} =
    chck cass_statement_bind_double(statement, csize(idx), v)

proc bindParam*(statement: Statement, name: string, v: float64) {.inline.} =
    chck cass_statement_bind_double_by_name_n(statement, name, name.len, v)

proc bindParam*(statement: Statement, idx: int, v: bool) {.inline.} =
    chck cass_statement_bind_bool(statement, csize(idx), cass_bool_t(v))

proc bindParam*(statement: Statement, name: string, v: bool) {.inline.} =
    chck cass_statement_bind_bool_by_name_n(statement, name, name.len, cass_bool_t(v))

proc bindParam*(statement: Statement, idx: int, v: string) {.inline.} =
    chck cass_statement_bind_string_n(statement, csize(idx), v, v.len)

proc bindParam*(statement: Statement, name, v: string) {.inline.} =
    chck cass_statement_bind_string_by_name_n(statement, name, name.len, v, v.len)

template `[]=`*[T](statement: Statement, idx: int, v: T) =
    statement.bindParam(idx, v)

template `[]=`*[T](statement: Statement, name: string, v: T) =
    statement.bindParam(name, v)

proc firstRow*(r: Result): Row {.inline.} =
    result.o = cass_result_first_row(r)
    result.gcHold = r

type ColumnsCollection = distinct Row

template columns*(r: Row): ColumnsCollection = ColumnsCollection(r)

proc `[]`*(cc: ColumnsCollection, name: string): Value {.inline.} =
    result.o = cass_row_get_column_by_name_n(Row(cc).o, name, name.len)
    result.gcHold = Row(cc).gcHold

proc `[]`*(cc: ColumnsCollection, idx: int): Value {.inline.} =
    result.o = cass_row_get_column(Row(cc).o, idx)
    result.gcHold = Row(cc).gcHold

proc kind*(v: Value): CassValueType {.inline.} = cass_value_type(v.o)

proc getMapValue*(m: Value, key: string): Value =
    let it = cass_iterator_from_map(m.o)
    while cass_iterator_next(it) != cass_false:
        let k = cass_iterator_get_map_key(it)
        var c: cstring
        var sz: csize

        if cass_value_get_string(k, cast[cstringArray](addr c), addr sz) == CASS_OK:
            if key == c:
                result.o = cass_iterator_get_map_value(it)
                result.gcHold = m.gcHold
                break
    cass_iterator_free(it)

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
