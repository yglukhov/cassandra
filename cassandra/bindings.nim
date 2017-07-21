## 
##   Copyright (c) 2014-2016 DataStax
## 
##   Licensed under the Apache License, Version 2.0 (the "License");
##   you may not use this file except in compliance with the License.
##   You may obtain a copy of the License at
## 
##   http://www.apache.org/licenses/LICENSE-2.0
## 
##   Unless required by applicable law or agreed to in writing, software
##   distributed under the License is distributed on an "AS IS" BASIS,
##   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##   See the License for the specific language governing permissions and
##   limitations under the License.
## 

## *
##  @file include/cassandra.h
## 
##  C/C++ driver for Apache Cassandra. Uses the Cassandra Query Language versions 3
##  over the Cassandra Binary Protocol (versions 1, 2, or 3).
## 

const
  CASS_VERSION_MAJOR* = 2
  CASS_VERSION_MINOR* = 7
  CASS_VERSION_PATCH* = 0
  CASS_VERSION_SUFFIX* = ""

type
  cass_bool_t* = enum
    cass_false = 0, cass_true = 1
  cass_float_t* = cfloat
  cass_double_t* = cdouble


## #define CASS_UINT64_MAX 18446744073709551615ULL // c2nim fails on this

type
  cass_byte_t* = uint8
  cass_duration_t* = uint64

## *
##  The size of an IPv4 address
## 

const
  CASS_INET_V4_LENGTH* = 4

## *
##  The size of an IPv6 address
## 

const
  CASS_INET_V6_LENGTH* = 16

## *
##  The size of an inet string including a null terminator.
## 

const
  CASS_INET_STRING_LENGTH* = 46

## *
##  IP address for either IPv4 or IPv6.
## 
##  @struct CassInet
## 

type
  CassInet* {.bycopy.} = object
    address*: array[CASS_INET_V6_LENGTH, uint8] ## *
                                             ##  Big-endian, binary representation of a IPv4 or IPv6 address
                                             ## 
    ## *
    ##  Number of address bytes. 4 bytes for IPv4 and 16 bytes for IPv6.
    ## 
    address_length*: uint8


## *
##  The size of a hexadecimal UUID string including a null terminator.
## 

const
  CASS_UUID_STRING_LENGTH* = 37

## *
##  Version 1 (time-based) or version 4 (random) UUID.
## 
##  @struct CassUuid
## 

type
  CassUuid* {.bycopy.} = object
    time_and_version*: uint64 ## *
                            ##  Represents the time and version part of a UUID. The most significant
                            ##  4 bits represent the version and the bottom 60 bits representing the
                            ##  time part. For version 1 the time part represents the number of
                            ##  100 nanosecond periods since 00:00:00 UTC, January 1, 1970 (the Epoch).
                            ##  For version 4 the time part is randomly generated.
                            ## 
    ## *
    ##  Represents the clock sequence and the node part of a UUID. The most
    ##  significant 16 bits represent the clock sequence (except for the most
    ##  significant bit which is always set) and the bottom 48 bits represent
    ##  the node part. For version 1 (time-based) the clock sequence part is randomly
    ##  generated and the node part can be explicitly set, otherwise, it's generated
    ##  from node unique information. For version 4 both the clock sequence and the node
    ##  parts are randomly generated.
    ## 
    clock_seq_and_node*: uint64


## *
##  A cluster object describes the configuration of the Cassandra cluster and is used
##  to construct a session instance. Unlike other DataStax drivers the cluster object
##  does not maintain the control connection.
## 
##  @struct CassCluster
## 

type
  CassCluster* = ptr int

## *
##  A session object is used to execute queries and maintains cluster state through
##  the control connection. The control connection is used to auto-discover nodes and
##  monitor cluster changes (topology and schema). Each session also maintains multiple
##  pools of connections to cluster nodes which are used to query the cluster.
## 
##  Instances of the session object are thread-safe to execute queries.
## 
##  @struct CassSession
## 

type
  CassSession* = ptr int

## *
##  A statement object is an executable query. It represents either a regular
##  (adhoc) statement or a prepared statement. It maintains the queries' parameter
##  values along with query options (consistency level, paging state, etc.)
## 
##  <b>Note:</b> Parameters for regular queries are not supported by the binary protocol
##  version 1.
## 
##  @struct CassStatement
## 

type
  CassStatement* = ptr int

## *
##  A group of statements that are executed as a single batch.
## 
##  <b>Note:</b> Batches are not supported by the binary protocol version 1.
## 
##  @cassandra{2.0+}
## 
##  @struct CassBatch
## 

type
  CassBatch* = ptr int

## *
##  The future result of an operation.
## 
##  It can represent a result if the operation completed successfully or an
##  error if the operation failed. It can be waited on, polled or a callback
##  can be attached.
## 
##  @struct CassFuture
## 

type
  CassFuture* = ptr int

## *
##  A statement that has been prepared cluster-side (It has been pre-parsed
##  and cached).
## 
##  A prepared statement is read-only and it is thread-safe to concurrently
##  bind new statements.
## 
##  @struct CassPrepared
## 

type
  CassPrepared* = ptr int

## *
##  The result of a query.
## 
##  A result object is read-only and is thread-safe to read or iterate over
##  concurrently.
## 
##  @struct CassResult
## 

type
  CassResult* = ptr int

## *
##  A error result of a request
## 
##  @struct CassErrorResult
## 

type
  CassErrorResult* = ptr int

## *
##  An object used to iterate over a group of rows, columns or collection values.
## 
##  @struct CassIterator
## 

type
  CassIterator* = ptr int

## *
##  A collection of column values.
## 
##  @struct CassRow
## 

type
  CassRow* = ptr int

## *
##  A single primitive value or a collection of values.
## 
##  @struct CassValue
## 

type
  CassValue* = ptr int

## *
##  A data type used to describe a value, collection or
##  user defined type.
## 
##  @struct CassDataType
## 

type
  CassDataType* = ptr int

## *
##  @struct CassFunctionMeta
## 
##  @cassandra{2.2+}
## 

type
  CassFunctionMeta* = ptr int

## *
##  @struct CassAggregateMeta
## 
##  @cassandra{2.2+}
## 

type
  CassAggregateMeta* = ptr int

## *
##   A collection of values.
## 
##  @struct CassCollection
## 

type
  CassCollection* = ptr int

## *
##  A tuple of values.
## 
##  @struct CassTuple
## 
##  @cassandra{2.1+}
## 

type
  CassTuple* = ptr int

## *
##  A user defined type.
## 
##  @struct CassUserType
## 
##  @cassandra{2.1+}
## 

type
  CassUserType* = ptr int

## *
##  Describes the SSL configuration of a cluster.
## 
##  @struct CassSsl
## 

type
  CassSsl* = ptr int

## *
##  Describes the version of the connected Cassandra cluster.
## 
##  @struct CassVersion
## 

type
  CassVersion* {.bycopy.} = object
    major_version*: cint
    minor_version*: cint
    patch_version*: cint


## *
##  A snapshot of the schema's metadata.
## 
##  @struct CassSchemaMeta
## 

type
  CassSchemaMeta* = ptr int

## *
##  Keyspace metadata
## 
##  @struct CassKeyspaceMeta
## 

type
  CassKeyspaceMeta* = ptr int

## *
##  Table metadata
## 
##  @struct CassTableMeta
## 

type
  CassTableMeta* = ptr int

## *
##  MaterializedView metadata
## 
##  @struct CassMaterializedViewMeta
## 
##  @cassandra{3.0+}
## 

type
  CassMaterializedViewMeta* = ptr int

## *
##  Column metadata
## 
##  @struct CassColumnMeta
## 

type
  CassColumnMeta* = ptr int

## *
##  Index metadata
## 
##  @struct CassIndexMeta
## 

type
  CassIndexMeta* = ptr int

## *
##  A UUID generator object.
## 
##  Instances of the UUID generator object are thread-safe to generate UUIDs.
## 
##  @struct CassUuidGen
## 

type
  CassUuidGen* = ptr int

## *
##  Policies that defined the behavior of a request when a server-side
##  read/write timeout or unavailable error occurs.
## 
##  Generators of client-side, microsecond-precision timestamps.
## 
##  @struct CassTimestampGen
## 
##  @cassandra{2.1+}
## 

type
  CassTimestampGen* = ptr int

## *
##  @struct CassRetryPolicy
## 

type
  CassRetryPolicy* = ptr int

## *
##  @struct CassCustomPayload
## 
##  @cassandra{2.2+}
## 

type
  CassCustomPayload* = ptr int

## *
##  A snapshot of the session's performance/diagnostic metrics.
## 
##  @struct CassMetrics
## 

type
  INNER_C_STRUCT_2153134789* {.bycopy.} = object
    min*: uint64               ## *< Minimum in microseconds
    max*: uint64               ## *< Maximum in microseconds
    mean*: uint64              ## *< Mean in microseconds
    stddev*: uint64            ## *< Standard deviation in microseconds
    median*: uint64            ## *< Median in microseconds
    percentile_75th*: uint64   ## *< 75th percentile in microseconds
    percentile_95th*: uint64   ## *< 95th percentile in microseconds
    percentile_98th*: uint64   ## *< 98th percentile in microseconds
    percentile_99th*: uint64   ## *< 99the percentile in microseconds
    percentile_999th*: uint64  ## *< 99.9th percentile in microseconds
    mean_rate*: cass_double_t  ## *<  Mean rate in requests per second
    one_minute_rate*: cass_double_t ## *< 1 minute rate in requests per second
    five_minute_rate*: cass_double_t ## *<  5 minute rate in requests per second
    fifteen_minute_rate*: cass_double_t ## *< 15 minute rate in requests per second
  
  INNER_C_STRUCT_166940482* {.bycopy.} = object
    total_connections*: uint64 ## *< The total number of connections
    available_connections*: uint64 ## *< The number of connections available to take requests
    exceeded_pending_requests_water_mark*: uint64 ## *< Occurrences when requests exceeded a pool's water mark
    exceeded_write_bytes_water_mark*: uint64 ## *< Occurrences when number of bytes exceeded a connection's water mark
  
  INNER_C_STRUCT_3259710472* {.bycopy.} = object
    connection_timeouts*: uint64 ## *< Occurrences of a connection timeout
    pending_request_timeouts*: uint64 ## * Occurrences of requests that timed out waiting for a connection
    request_timeouts*: uint64  ## * Occurrences of requests that timed out waiting for a request to finish
  
  CassMetrics* {.bycopy.} = object
    requests*: INNER_C_STRUCT_2153134789
    stats*: INNER_C_STRUCT_166940482
    errors*: INNER_C_STRUCT_3259710472

  CassConsistency* = enum
    CASS_CONSISTENCY_ANY = 0x00000000, CASS_CONSISTENCY_ONE = 0x00000001,
    CASS_CONSISTENCY_TWO = 0x00000002, CASS_CONSISTENCY_THREE = 0x00000003,
    CASS_CONSISTENCY_QUORUM = 0x00000004, CASS_CONSISTENCY_ALL = 0x00000005,
    CASS_CONSISTENCY_LOCAL_QUORUM = 0x00000006,
    CASS_CONSISTENCY_EACH_QUORUM = 0x00000007,
    CASS_CONSISTENCY_SERIAL = 0x00000008,
    CASS_CONSISTENCY_LOCAL_SERIAL = 0x00000009,
    CASS_CONSISTENCY_LOCAL_ONE = 0x0000000A, CASS_CONSISTENCY_UNKNOWN = 0x0000FFFF


##  @cond IGNORE

##  @endcond

type
  CassWriteType* = enum
    CASS_WRITE_TYPE_UKNOWN, CASS_WRITE_TYPE_SIMPLE, CASS_WRITE_TYPE_BATCH,
    CASS_WRITE_TYPE_UNLOGGED_BATCH, CASS_WRITE_TYPE_COUNTER,
    CASS_WRITE_TYPE_BATCH_LOG, CASS_WRITE_TYPE_CAS


##  @cond IGNORE

##  @endcond

type
  CassColumnType* = enum
    CASS_COLUMN_TYPE_REGULAR, CASS_COLUMN_TYPE_PARTITION_KEY,
    CASS_COLUMN_TYPE_CLUSTERING_KEY, CASS_COLUMN_TYPE_STATIC,
    CASS_COLUMN_TYPE_COMPACT_VALUE
  CassIndexType* = enum
    CASS_INDEX_TYPE_UNKNOWN, CASS_INDEX_TYPE_KEYS, CASS_INDEX_TYPE_CUSTOM,
    CASS_INDEX_TYPE_COMPOSITES



type
  CassValueType* = enum
    CASS_VALUE_TYPE_CUSTOM = 0x00000000, CASS_VALUE_TYPE_ASCII = 0x00000001,
    CASS_VALUE_TYPE_BIGINT = 0x00000002, CASS_VALUE_TYPE_BLOB = 0x00000003,
    CASS_VALUE_TYPE_BOOLEAN = 0x00000004, CASS_VALUE_TYPE_COUNTER = 0x00000005,
    CASS_VALUE_TYPE_DECIMAL = 0x00000006, CASS_VALUE_TYPE_DOUBLE = 0x00000007,
    CASS_VALUE_TYPE_FLOAT = 0x00000008, CASS_VALUE_TYPE_INT = 0x00000009,
    CASS_VALUE_TYPE_TEXT = 0x0000000A, CASS_VALUE_TYPE_TIMESTAMP = 0x0000000B,
    CASS_VALUE_TYPE_UUID = 0x0000000C, CASS_VALUE_TYPE_VARCHAR = 0x0000000D,
    CASS_VALUE_TYPE_VARINT = 0x0000000E, CASS_VALUE_TYPE_TIMEUUID = 0x0000000F,
    CASS_VALUE_TYPE_INET = 0x00000010, CASS_VALUE_TYPE_DATE = 0x00000011,
    CASS_VALUE_TYPE_TIME = 0x00000012, CASS_VALUE_TYPE_SMALL_INT = 0x00000013,
    CASS_VALUE_TYPE_TINY_INT = 0x00000014, CASS_VALUE_TYPE_DURATION = 0x00000015,
    CASS_VALUE_TYPE_LIST = 0x00000020, CASS_VALUE_TYPE_MAP = 0x00000021,
    CASS_VALUE_TYPE_SET = 0x00000022, CASS_VALUE_TYPE_UDT = 0x00000030, CASS_VALUE_TYPE_TUPLE = 0x00000031, ##  @cond IGNORE
    CASS_VALUE_TYPE_LAST_ENTRY, ##  @endcond
    CASS_VALUE_TYPE_UNKNOWN = 0x0000FFFF


## #undef XX_VALUE_TYPE // c2nim fails on this

type
  CassClusteringOrder* = enum
    CASS_CLUSTERING_ORDER_NONE, CASS_CLUSTERING_ORDER_ASC,
    CASS_CLUSTERING_ORDER_DESC
  CassCollectionType* = enum
    CASS_COLLECTION_TYPE_LIST = CASS_VALUE_TYPE_LIST,
    CASS_COLLECTION_TYPE_MAP = CASS_VALUE_TYPE_MAP,
    CASS_COLLECTION_TYPE_SET = CASS_VALUE_TYPE_SET
  CassBatchType* = enum
    CASS_BATCH_TYPE_LOGGED = 0x00000000, CASS_BATCH_TYPE_UNLOGGED = 0x00000001,
    CASS_BATCH_TYPE_COUNTER = 0x00000002
  CassIteratorType* = enum
    CASS_ITERATOR_TYPE_RESULT, CASS_ITERATOR_TYPE_ROW,
    CASS_ITERATOR_TYPE_COLLECTION, CASS_ITERATOR_TYPE_MAP,
    CASS_ITERATOR_TYPE_TUPLE, CASS_ITERATOR_TYPE_USER_TYPE_FIELD,
    CASS_ITERATOR_TYPE_META_FIELD, CASS_ITERATOR_TYPE_KEYSPACE_META,
    CASS_ITERATOR_TYPE_TABLE_META, CASS_ITERATOR_TYPE_TYPE_META,
    CASS_ITERATOR_TYPE_FUNCTION_META, CASS_ITERATOR_TYPE_AGGREGATE_META,
    CASS_ITERATOR_TYPE_COLUMN_META, CASS_ITERATOR_TYPE_INDEX_META,
    CASS_ITERATOR_TYPE_MATERIALIZED_VIEW_META





##  @cond IGNORE

##  @endcond

type
  CassLogLevel* = enum
    CASS_LOG_DISABLED, CASS_LOG_CRITICAL, CASS_LOG_ERROR, CASS_LOG_WARN,
    CASS_LOG_INFO, CASS_LOG_DEBUG, CASS_LOG_TRACE, ##  @cond IGNORE
    CASS_LOG_LAST_ENTRY       ##  @endcond


## #undef XX_LOG // c2nim fails on this

type
  CassSslVerifyFlags* = enum
    CASS_SSL_VERIFY_NONE = 0x00000000, CASS_SSL_VERIFY_PEER_CERT = 0x00000001,
    CASS_SSL_VERIFY_PEER_IDENTITY = 0x00000002,
    CASS_SSL_VERIFY_PEER_IDENTITY_DNS = 0x00000004
  CassProtocolVersion* = enum
    CASS_PROTOCOL_VERSION_V1 = 0x00000001, CASS_PROTOCOL_VERSION_V2 = 0x00000002,
    CASS_PROTOCOL_VERSION_V3 = 0x00000003, CASS_PROTOCOL_VERSION_V4 = 0x00000004
  CassErrorSource* = enum
    CASS_ERROR_SOURCE_NONE, CASS_ERROR_SOURCE_LIB, CASS_ERROR_SOURCE_SERVER,
    CASS_ERROR_SOURCE_SSL, CASS_ERROR_SOURCE_COMPRESSION




proc `shl`(e: CassErrorSource, i: int): cint =
    cint(e) shl i
##  @cond IGNORE

##  @endcond

type
  CassError* = enum
    CASS_OK = 0, CASS_ERROR_LIB_BAD_PARAMS = ((CASS_ERROR_SOURCE_LIB shl 24) or 1),
    CASS_ERROR_LIB_NO_STREAMS = ((CASS_ERROR_SOURCE_LIB shl 24) or 2),
    CASS_ERROR_LIB_UNABLE_TO_INIT = ((CASS_ERROR_SOURCE_LIB shl 24) or 3),
    CASS_ERROR_LIB_MESSAGE_ENCODE = ((CASS_ERROR_SOURCE_LIB shl 24) or 4),
    CASS_ERROR_LIB_HOST_RESOLUTION = ((CASS_ERROR_SOURCE_LIB shl 24) or 5),
    CASS_ERROR_LIB_UNEXPECTED_RESPONSE = ((CASS_ERROR_SOURCE_LIB shl 24) or 6),
    CASS_ERROR_LIB_REQUEST_QUEUE_FULL = ((CASS_ERROR_SOURCE_LIB shl 24) or 7), CASS_ERROR_LIB_NO_AVAILABLE_IO_THREAD = (
        (CASS_ERROR_SOURCE_LIB shl 24) or 8),
    CASS_ERROR_LIB_WRITE_ERROR = ((CASS_ERROR_SOURCE_LIB shl 24) or 9),
    CASS_ERROR_LIB_NO_HOSTS_AVAILABLE = ((CASS_ERROR_SOURCE_LIB shl 24) or 10), CASS_ERROR_LIB_INDEX_OUT_OF_BOUNDS = (
        (CASS_ERROR_SOURCE_LIB shl 24) or 11),
    CASS_ERROR_LIB_INVALID_ITEM_COUNT = ((CASS_ERROR_SOURCE_LIB shl 24) or 12),
    CASS_ERROR_LIB_INVALID_VALUE_TYPE = ((CASS_ERROR_SOURCE_LIB shl 24) or 13),
    CASS_ERROR_LIB_REQUEST_TIMED_OUT = ((CASS_ERROR_SOURCE_LIB shl 24) or 14), CASS_ERROR_LIB_UNABLE_TO_SET_KEYSPACE = (
        (CASS_ERROR_SOURCE_LIB shl 24) or 15), CASS_ERROR_LIB_CALLBACK_ALREADY_SET = (
        (CASS_ERROR_SOURCE_LIB shl 24) or 16), CASS_ERROR_LIB_INVALID_STATEMENT_TYPE = (
        (CASS_ERROR_SOURCE_LIB shl 24) or 17), CASS_ERROR_LIB_NAME_DOES_NOT_EXIST = (
        (CASS_ERROR_SOURCE_LIB shl 24) or 18), CASS_ERROR_LIB_UNABLE_TO_DETERMINE_PROTOCOL = (
        (CASS_ERROR_SOURCE_LIB shl 24) or 19),
    CASS_ERROR_LIB_NULL_VALUE = ((CASS_ERROR_SOURCE_LIB shl 24) or 20),
    CASS_ERROR_LIB_NOT_IMPLEMENTED = ((CASS_ERROR_SOURCE_LIB shl 24) or 21),
    CASS_ERROR_LIB_UNABLE_TO_CONNECT = ((CASS_ERROR_SOURCE_LIB shl 24) or 22),
    CASS_ERROR_LIB_UNABLE_TO_CLOSE = ((CASS_ERROR_SOURCE_LIB shl 24) or 23),
    CASS_ERROR_LIB_NO_PAGING_STATE = ((CASS_ERROR_SOURCE_LIB shl 24) or 24),
    CASS_ERROR_LIB_PARAMETER_UNSET = ((CASS_ERROR_SOURCE_LIB shl 24) or 25), CASS_ERROR_LIB_INVALID_ERROR_RESULT_TYPE = (
        (CASS_ERROR_SOURCE_LIB shl 24) or 26), CASS_ERROR_LIB_INVALID_FUTURE_TYPE = (
        (CASS_ERROR_SOURCE_LIB shl 24) or 27),
    CASS_ERROR_LIB_INTERNAL_ERROR = ((CASS_ERROR_SOURCE_LIB shl 24) or 28), CASS_ERROR_LIB_INVALID_CUSTOM_TYPE = (
        (CASS_ERROR_SOURCE_LIB shl 24) or 29),
    CASS_ERROR_LIB_INVALID_DATA = ((CASS_ERROR_SOURCE_LIB shl 24) or 30),
    CASS_ERROR_LIB_NOT_ENOUGH_DATA = ((CASS_ERROR_SOURCE_LIB shl 24) or 31),
    CASS_ERROR_LIB_INVALID_STATE = ((CASS_ERROR_SOURCE_LIB shl 24) or 32),
    CASS_ERROR_LIB_NO_CUSTOM_PAYLOAD = ((CASS_ERROR_SOURCE_LIB shl 24) or 33), CASS_ERROR_SERVER_SERVER_ERROR = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00000000), CASS_ERROR_SERVER_PROTOCOL_ERROR = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x0000000A), CASS_ERROR_SERVER_BAD_CREDENTIALS = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00000100), CASS_ERROR_SERVER_UNAVAILABLE = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00001000), CASS_ERROR_SERVER_OVERLOADED = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00001001), CASS_ERROR_SERVER_IS_BOOTSTRAPPING = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00001002), CASS_ERROR_SERVER_TRUNCATE_ERROR = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00001003), CASS_ERROR_SERVER_WRITE_TIMEOUT = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00001100), CASS_ERROR_SERVER_READ_TIMEOUT = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00001200), CASS_ERROR_SERVER_READ_FAILURE = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00001300), CASS_ERROR_SERVER_FUNCTION_FAILURE = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00001400), CASS_ERROR_SERVER_WRITE_FAILURE = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00001500), CASS_ERROR_SERVER_SYNTAX_ERROR = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00002000), CASS_ERROR_SERVER_UNAUTHORIZED = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00002100), CASS_ERROR_SERVER_INVALID_QUERY = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00002200), CASS_ERROR_SERVER_CONFIG_ERROR = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00002300), CASS_ERROR_SERVER_ALREADY_EXISTS = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00002400), CASS_ERROR_SERVER_UNPREPARED = (
        (CASS_ERROR_SOURCE_SERVER shl 24) or 0x00002500),
    CASS_ERROR_SSL_INVALID_CERT = ((CASS_ERROR_SOURCE_SSL shl 24) or 1),
    CASS_ERROR_SSL_INVALID_PRIVATE_KEY = ((CASS_ERROR_SOURCE_SSL shl 24) or 2),
    CASS_ERROR_SSL_NO_PEER_CERT = ((CASS_ERROR_SOURCE_SSL shl 24) or 3),
    CASS_ERROR_SSL_INVALID_PEER_CERT = ((CASS_ERROR_SOURCE_SSL shl 24) or 4),
    CASS_ERROR_SSL_IDENTITY_MISMATCH = ((CASS_ERROR_SOURCE_SSL shl 24) or 5), CASS_ERROR_SSL_PROTOCOL_ERROR = (
        (CASS_ERROR_SOURCE_SSL shl 24) or 6), ##  @cond IGNORE
    CASS_ERROR_LAST_ENTRY     ##  @endcond


## #undef XX_ERROR // c2nim fails on this
## *
##  A callback that's notified when the future is set.
## 
##  @param[in] message
##  @param[in] data user defined data provided when the callback
##  was registered.
## 
##  @see cass_future_set_callback()
## 

type
  CassFutureCallback* = proc (future: ptr CassFuture; data: pointer) {.cdecl.}

## *
##  Maximum size of a log message
## 

const
  CASS_LOG_MAX_MESSAGE_SIZE* = 1024

## *
##  A log message.
## 

type
  CassLogMessage* {.bycopy.} = object
    time_ms*: uint64 ## *
                   ##  The millisecond timestamp (since the Epoch) when the message was logged
                   ## 
    severity*: CassLogLevel    ## *< The severity of the log message
    file*: cstring             ## *< The file where the message was logged
    line*: cint                ## *< The line in the file where the message was logged
    function*: cstring         ## *< The function where the message was logged
    message*: array[CASS_LOG_MAX_MESSAGE_SIZE, char] ## *< The message
  

## *
##  A callback that's used to handle logging.
## 
##  @param[in] message
##  @param[in] data user defined data provided when the callback
##  was registered.
## 
##  @see cass_log_set_callback();
## 

type
  CassLogCallback* = proc (message: ptr CassLogMessage; data: pointer) {.cdecl.}

## *
##  An authenticator.
## 
##  @struct CassAuthenticator
## 

type
  CassAuthenticator* = ptr int

## *
##  A callback used to initiate an authentication exchange.
## 
##  Use cass_authenticator_set_response() to set the response token.
## 
##  Use cass_authenticator_set_error() if an error occured during initialization.
## 
##  @param[in] auth
##  @param[in] data
## 

type
  CassAuthenticatorInitialCallback* = proc (auth: ptr CassAuthenticator; data: pointer) {.cdecl.}

## *
##  A callback used when an authentication challenge initiated
##  by the server.
## 
##  Use cass_authenticator_set_response() to set the response token.
## 
##  Use cass_authenticator_set_error() if an error occured during the challenge.
## 
##  @param[in] auth
##  @param[in] data
##  @param[in] token
##  @param[in] token_size
## 

type
  CassAuthenticatorChallengeCallback* = proc (auth: ptr CassAuthenticator;
      data: pointer; token: cstring; token_size: csize) {.cdecl.}

## *
##  A callback used to indicate the success of the authentication
##  exchange.
## 
##  Use cass_authenticator_set_error() if an error occured while evaluating
##  the success token.
## 
##  @param[in] auth
##  @param[in] data
##  @param[in] token
##  @param[in] token_size
## 

type
  CassAuthenticatorSuccessCallback* = proc (auth: ptr CassAuthenticator;
      data: pointer; token: cstring; token_size: csize) {.cdecl.}

## *
##  A callback used to cleanup resources that were acquired during
##  the process of the authentication exchange. This is called after
##  the termination of the exchange regardless of the outcome.
## 
##  @param[in] auth
##  @param[in] data
## 

type
  CassAuthenticatorCleanupCallback* = proc (auth: ptr CassAuthenticator; data: pointer) {.cdecl.}

## *
##  A callback used to cleanup resources.
## 
##  @param[in] data
## 

type
  CassAuthenticatorDataCleanupCallback* = proc (data: pointer) {.cdecl.}

## *
##  Authenticator callbacks
## 

type
  CassAuthenticatorCallbacks* {.bycopy.} = object
    initial_callback*: CassAuthenticatorInitialCallback
    challenge_callback*: CassAuthenticatorChallengeCallback
    success_callback*: CassAuthenticatorSuccessCallback
    cleanup_callback*: CassAuthenticatorCleanupCallback


{.push importc.}
## **********************************************************************************
## 
##  Cluster
## 
## *********************************************************************************
## *
##  Creates a new cluster.
## 
##  @public @memberof CassCluster
## 
##  @return Returns a cluster that must be freed.
## 
##  @see cass_cluster_free()
## 

proc cass_cluster_new*(): ptr CassCluster
## *
##  Frees a cluster instance.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
## 

proc cass_cluster_free*(cluster: ptr CassCluster)
## *
##  Sets/Appends contact points. This *MUST* be set. The first call sets
##  the contact points and any subsequent calls appends additional contact
##  points. Passing an empty string will clear the contact points. White space
##  is striped from the contact points.
## 
##  Examples: "127.0.0.1" "127.0.0.1,127.0.0.2", "server1.domain.com"
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] contact_points A comma delimited list of addresses or
##  names. An empty string will clear the contact points.
##  The string is copied into the cluster configuration; the memory pointed
##  to by this parameter can be freed after this call.
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_contact_points*(cluster: ptr CassCluster;
                                     contact_points: cstring): CassError
## *
##  Same as cass_cluster_set_contact_points(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] contact_points
##  @param[in] contact_points_length
##  @return same as cass_cluster_set_contact_points()
## 
##  @see cass_cluster_set_contact_points()
## 

proc cass_cluster_set_contact_points_n*(cluster: ptr CassCluster;
                                       contact_points: cstring;
                                       contact_points_length: csize): CassError
## *
##  Sets the port.
## 
##  <b>Default:</b> 9042
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] port
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_port*(cluster: ptr CassCluster; port: cint): CassError
## *
##  Sets the SSL context and enables SSL.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] ssl
## 
##  @see cass_ssl_new()
## 

proc cass_cluster_set_ssl*(cluster: ptr CassCluster; ssl: ptr CassSsl)
## *
##  Sets custom authenticator
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] exchange_callbacks
##  @param[in] cleanup_callback
##  @param[in] data
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_authenticator_callbacks*(cluster: ptr CassCluster;
    exchange_callbacks: ptr CassAuthenticatorCallbacks;
    cleanup_callback: CassAuthenticatorDataCleanupCallback; data: pointer): CassError
## *
##  Sets the protocol version. This will automatically downgrade to the lowest
##  supported protocol version.
## 
##  <b>Default:</b> 4
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] protocol_version
##  @return CASS_OK if successful, otherwise an error occurred.
## 
##  @see cass_cluster_set_use_beta_protocol_version()
## 

proc cass_cluster_set_protocol_version*(cluster: ptr CassCluster;
                                       protocol_version: cint): CassError
## *
##  Use the newest beta protocol version. This currently enables the use of
##  protocol version 5.
## 
##  <b>Default:</b> cass_false
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] enable if false the highest non-beta protocol version will be used
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_use_beta_protocol_version*(cluster: ptr CassCluster;
    enable: cass_bool_t): CassError
## *
##  Sets the number of IO threads. This is the number of threads
##  that will handle query requests.
## 
##  <b>Default:</b> 1
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] num_threads
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_num_threads_io*(cluster: ptr CassCluster; num_threads: cuint): CassError
## *
##  Sets the size of the fixed size queue that stores
##  pending requests.
## 
##  <b>Default:</b> 8192
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] queue_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_queue_size_io*(cluster: ptr CassCluster; queue_size: cuint): CassError
## *
##  Sets the size of the fixed size queue that stores
##  events.
## 
##  <b>Default:</b> 8192
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] queue_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_queue_size_event*(cluster: ptr CassCluster; queue_size: cuint): CassError
## *
##  Sets the size of the fixed size queue that stores
##  log messages.
## 
##  <b>Default:</b> 8192
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] queue_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_queue_size_log*(cluster: ptr CassCluster; queue_size: cuint): CassError
## *
##  Sets the number of connections made to each server in each
##  IO thread.
## 
##  <b>Default:</b> 1
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] num_connections
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_core_connections_per_host*(cluster: ptr CassCluster;
    num_connections: cuint): CassError
## *
##  Sets the maximum number of connections made to each server in each
##  IO thread.
## 
##  <b>Default:</b> 2
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] num_connections
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_max_connections_per_host*(cluster: ptr CassCluster;
    num_connections: cuint): CassError
## *
##  Sets the amount of time to wait before attempting to reconnect.
## 
##  <b>Default:</b> 2000 milliseconds
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] wait_time
## 

proc cass_cluster_set_reconnect_wait_time*(cluster: ptr CassCluster;
    wait_time: cuint)
## *
##  Sets the maximum number of connections that will be created concurrently.
##  Connections are created when the current connections are unable to keep up with
##  request throughput.
## 
##  <b>Default:</b> 1
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] num_connections
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_max_concurrent_creation*(cluster: ptr CassCluster;
    num_connections: cuint): CassError
## *
##  Sets the threshold for the maximum number of concurrent requests in-flight
##  on a connection before creating a new connection. The number of new connections
##  created will not exceed max_connections_per_host.
## 
##  <b>Default:</b> 100
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] num_requests
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_max_concurrent_requests_threshold*(
    cluster: ptr CassCluster; num_requests: cuint): CassError
## *
##  Sets the maximum number of requests processed by an IO worker
##  per flush.
## 
##  <b>Default:</b> 128
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] num_requests
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_max_requests_per_flush*(cluster: ptr CassCluster;
    num_requests: cuint): CassError
## *
##  Sets the high water mark for the number of bytes outstanding
##  on a connection. Disables writes to a connection if the number
##  of bytes queued exceed this value.
## 
##  <b>Default:</b> 64 KB
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] num_bytes
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_write_bytes_high_water_mark*(cluster: ptr CassCluster;
    num_bytes: cuint): CassError
## *
##  Sets the low water mark for number of bytes outstanding on a
##  connection. After exceeding high water mark bytes, writes will
##  only resume once the number of bytes fall below this value.
## 
##  <b>Default:</b> 32 KB
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] num_bytes
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_write_bytes_low_water_mark*(cluster: ptr CassCluster;
    num_bytes: cuint): CassError
## *
##  Sets the high water mark for the number of requests queued waiting
##  for a connection in a connection pool. Disables writes to a
##  host on an IO worker if the number of requests queued exceed this
##  value.
## 
##  <b>Default:</b> 256
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] num_requests
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_pending_requests_high_water_mark*(cluster: ptr CassCluster;
    num_requests: cuint): CassError
## *
##  Sets the low water mark for the number of requests queued waiting
##  for a connection in a connection pool. After exceeding high water mark
##  requests, writes to a host will only resume once the number of requests
##  fall below this value.
## 
##  <b>Default:</b> 128
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] num_requests
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_cluster_set_pending_requests_low_water_mark*(cluster: ptr CassCluster;
    num_requests: cuint): CassError
## *
##  Sets the timeout for connecting to a node.
## 
##  <b>Default:</b> 5000 milliseconds
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] timeout_ms Connect timeout in milliseconds
## 

proc cass_cluster_set_connect_timeout*(cluster: ptr CassCluster; timeout_ms: cuint)
## *
##  Sets the timeout for waiting for a response from a node.
## 
##  <b>Default:</b> 12000 milliseconds
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] timeout_ms Request timeout in milliseconds. Use 0 for no timeout.
## 

proc cass_cluster_set_request_timeout*(cluster: ptr CassCluster; timeout_ms: cuint)
## *
##  Sets the timeout for waiting for DNS name resolution.
## 
##  <b>Default:</b> 2000 milliseconds
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] timeout_ms Request timeout in milliseconds
## 

proc cass_cluster_set_resolve_timeout*(cluster: ptr CassCluster; timeout_ms: cuint)
## *
##  Sets credentials for plain text authentication.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] username
##  @param[in] password
## 

proc cass_cluster_set_credentials*(cluster: ptr CassCluster; username: cstring;
                                  password: cstring)
## *
##  Same as cass_cluster_set_credentials(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] username
##  @param[in] username_length
##  @param[in] password
##  @param[in] password_length
##  @return same as cass_cluster_set_credentials()
## 
##  @see cass_cluster_set_credentials();
## 

proc cass_cluster_set_credentials_n*(cluster: ptr CassCluster; username: cstring;
                                    username_length: csize; password: cstring;
                                    password_length: csize)
## *
##  Configures the cluster to use round-robin load balancing.
## 
##  The driver discovers all nodes in a cluster and cycles through
##  them per request. All are considered 'local'.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
## 

proc cass_cluster_set_load_balance_round_robin*(cluster: ptr CassCluster)
## *
##  Configures the cluster to use DC-aware load balancing.
##  For each query, all live nodes in a primary 'local' DC are tried first,
##  followed by any node from other DCs.
## 
##  <b>Note:</b> This is the default, and does not need to be called unless
##  switching an existing from another policy or changing settings.
##  Without further configuration, a default local_dc is chosen from the
##  first connected contact point, and no remote hosts are considered in
##  query plans. If relying on this mechanism, be sure to use only contact
##  points from the local DC.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] local_dc The primary data center to try first
##  @param[in] used_hosts_per_remote_dc The number of host used in each remote DC if no hosts
##  are available in the local dc
##  @param[in] allow_remote_dcs_for_local_cl Allows remote hosts to be used if no local dc hosts
##  are available and the consistency level is LOCAL_ONE or LOCAL_QUORUM
##  @return CASS_OK if successful, otherwise an error occurred
## 

proc cass_cluster_set_load_balance_dc_aware*(cluster: ptr CassCluster;
    local_dc: cstring; used_hosts_per_remote_dc: cuint;
    allow_remote_dcs_for_local_cl: cass_bool_t): CassError
## *
##  Same as cass_cluster_set_load_balance_dc_aware(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] local_dc
##  @param[in] local_dc_length
##  @param[in] used_hosts_per_remote_dc
##  @param[in] allow_remote_dcs_for_local_cl
##  @return same as cass_cluster_set_load_balance_dc_aware()
## 
##  @see cass_cluster_set_load_balance_dc_aware()
## 

proc cass_cluster_set_load_balance_dc_aware_n*(cluster: ptr CassCluster;
    local_dc: cstring; local_dc_length: csize; used_hosts_per_remote_dc: cuint;
    allow_remote_dcs_for_local_cl: cass_bool_t): CassError
## *
##  Configures the cluster to use token-aware request routing or not.
## 
##  <b>Important:</b> Token-aware routing depends on keyspace metadata.
##  For this reason enabling token-aware routing will also enable retrieving
##  and updating keyspace schema metadata.
## 
##  <b>Default:</b> cass_true (enabled).
## 
##  This routing policy composes the base routing policy, routing
##  requests first to replicas on nodes considered 'local' by
##  the base load balancing policy.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] enabled
## 

proc cass_cluster_set_token_aware_routing*(cluster: ptr CassCluster;
    enabled: cass_bool_t)
## *
##  Configures the cluster to use latency-aware request routing or not.
## 
##  <b>Default:</b> cass_false (disabled).
## 
##  This routing policy is a top-level routing policy. It uses the
##  base routing policy to determine locality (dc-aware) and/or
##  placement (token-aware) before considering the latency.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] enabled
## 

proc cass_cluster_set_latency_aware_routing*(cluster: ptr CassCluster;
    enabled: cass_bool_t)
## *
##  Configures the settings for latency-aware request routing.
## 
##  <b>Defaults:</b>
## 
##  <ul>
##    <li>exclusion_threshold: 2.0</li>
##    <li>scale_ms: 100 milliseconds</li>
##    <li>retry_period_ms: 10,000 milliseconds (10 seconds)</li>
##    <li>update_rate_ms: 100 milliseconds</li>
##    <li>min_measured: 50</li>
##  </ul>
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] exclusion_threshold Controls how much worse the latency must be compared to the
##  average latency of the best performing node before it penalized.
##  @param[in] scale_ms Controls the weight given to older latencies when calculating the average
##  latency of a node. A bigger scale will give more weight to older latency measurements.
##  @param[in] retry_period_ms The amount of time a node is penalized by the policy before
##  being given a second chance when the current average latency exceeds the calculated
##  threshold (exclusion_threshold * best_average_latency).
##  @param[in] update_rate_ms The rate at  which the best average latency is recomputed.
##  @param[in] min_measured The minimum number of measurements per-host required to
##  be considered by the policy.
## 

proc cass_cluster_set_latency_aware_routing_settings*(cluster: ptr CassCluster;
    exclusion_threshold: cass_double_t; scale_ms: uint64; retry_period_ms: uint64;
    update_rate_ms: uint64; min_measured: uint64)
## *
##  Sets/Appends whitelist hosts. The first call sets the whitelist hosts and
##  any subsequent calls appends additional hosts. Passing an empty string will
##  clear and disable the whitelist. White space is striped from the hosts.
## 
##  This policy filters requests to all other policies, only allowing requests
##  to the hosts contained in the whitelist. Any host not in the whitelist will
##  be ignored and a connection will not be established. This policy is useful
##  for ensuring that the driver will only connect to a predefined set of hosts.
## 
##  Examples: "127.0.0.1" "127.0.0.1,127.0.0.2"
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] hosts A comma delimited list of addresses. An empty string will
##  clear the whitelist hosts. The string is copied into the cluster
##  configuration; the memory pointed to by this parameter can be freed after
##  this call.
## 

proc cass_cluster_set_whitelist_filtering*(cluster: ptr CassCluster; hosts: cstring)
## *
##  Same as cass_cluster_set_whitelist_filtering_hosts(), but with lengths for
##  string parameters.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] hosts
##  @param[in] hosts_length
##  @return same as cass_cluster_set_whitelist_filtering_hosts()
## 
##  @see cass_cluster_set_whitelist_filtering_hosts()
## 

proc cass_cluster_set_whitelist_filtering_n*(cluster: ptr CassCluster;
    hosts: cstring; hosts_length: csize)
## *
##  Sets/Appends blacklist hosts. The first call sets the blacklist hosts and
##  any subsequent calls appends additional hosts. Passing an empty string will
##  clear and disable the blacklist. White space is striped from the hosts.
## 
##  This policy filters requests to all other policies, only allowing requests
##  to the hosts not contained in the blacklist. Any host in the blacklist will
##  be ignored and a connection will not be established. This policy is useful
##  for ensuring that the driver will not connect to a predefined set of hosts.
## 
##  Examples: "127.0.0.1" "127.0.0.1,127.0.0.2"
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] hosts A comma delimited list of addresses. An empty string will
##  clear the blacklist hosts. The string is copied into the cluster
##  configuration; the memory pointed to by this parameter can be freed after
##  this call.
## 

proc cass_cluster_set_blacklist_filtering*(cluster: ptr CassCluster; hosts: cstring)
## *
##  Same as cass_cluster_set_blacklist_filtering_hosts(), but with lengths for
##  string parameters.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] hosts
##  @param[in] hosts_length
##  @return same as cass_cluster_set_blacklist_filtering_hosts()
## 
##  @see cass_cluster_set_blacklist_filtering_hosts()
## 

proc cass_cluster_set_blacklist_filtering_n*(cluster: ptr CassCluster;
    hosts: cstring; hosts_length: csize)
## *
##  Same as cass_cluster_set_whitelist_filtering(), but whitelist all hosts of a dc
## 
##  Examples: "dc1", "dc1,dc2"
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] dcs A comma delimited list of dcs. An empty string will clear the
##  whitelist dcs. The string is copied into the cluster configuration; the
##  memory pointed to by this parameter can be freed after this call.
## 

proc cass_cluster_set_whitelist_dc_filtering*(cluster: ptr CassCluster; dcs: cstring)
## *
##  Same as cass_cluster_set_whitelist_dc_filtering(), but with lengths for
##  string parameters.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] dcs
##  @param[in] dcs_length
##  @return same as cass_cluster_set_whitelist_dc_filtering()
## 
##  @see cass_cluster_set_whitelist_dc_filtering()
## 

proc cass_cluster_set_whitelist_dc_filtering_n*(cluster: ptr CassCluster;
    dcs: cstring; dcs_length: csize)
## *
##  Same as cass_cluster_set_blacklist_filtering(), but blacklist all hosts of a dc
## 
##  Examples: "dc1", "dc1,dc2"
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] dcs A comma delimited list of dcs. An empty string will clear the
##  blacklist dcs. The string is copied into the cluster configuration; the
##  memory pointed to by this parameter can be freed after this call.
## 

proc cass_cluster_set_blacklist_dc_filtering*(cluster: ptr CassCluster; dcs: cstring)
## *
##  Same as cass_cluster_set_blacklist_dc_filtering(), but with lengths for
##  string parameters.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] dcs
##  @param[in] dcs_length
##  @return same as cass_cluster_set_blacklist_dc_filtering()
## 
##  @see cass_cluster_set_blacklist_dc_filtering()
## 

proc cass_cluster_set_blacklist_dc_filtering_n*(cluster: ptr CassCluster;
    dcs: cstring; dcs_length: csize)
## *
##  Enable/Disable Nagle's algorithm on connections.
## 
##  <b>Default:</b> cass_true (disables Nagle's algorithm).
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] enabled
## 

proc cass_cluster_set_tcp_nodelay*(cluster: ptr CassCluster; enabled: cass_bool_t)
## *
##  Enable/Disable TCP keep-alive
## 
##  <b>Default:</b> cass_false (disabled).
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] enabled
##  @param[in] delay_secs The initial delay in seconds, ignored when
##  `enabled` is false.
## 

proc cass_cluster_set_tcp_keepalive*(cluster: ptr CassCluster; enabled: cass_bool_t;
                                    delay_secs: cuint)
## *
##  Sets the timestamp generator used to assign timestamps to all requests
##  unless overridden by setting the timestamp on a statement or a batch.
## 
##  <b>Default:</b> server-side timestamp generator.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] timestamp_gen
## 
##  @see cass_statement_set_timestamp()
##  @see cass_batch_set_timestamp()
## 

proc cass_cluster_set_timestamp_gen*(cluster: ptr CassCluster;
                                    timestamp_gen: ptr CassTimestampGen)
## *
##  Sets the amount of time between heartbeat messages and controls the amount
##  of time the connection must be idle before sending heartbeat messages. This
##  is useful for preventing intermediate network devices from dropping
##  connections.
## 
##  <b>Default:</b> 30 seconds
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] interval_secs Use 0 to disable heartbeat messages
## 

proc cass_cluster_set_connection_heartbeat_interval*(cluster: ptr CassCluster;
    interval_secs: cuint)
## *
##  Sets the amount of time a connection is allowed to be without a successful
##  heartbeat response before being terminated and scheduled for reconnection.
## 
##  <b>Default:</b> 60 seconds
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] timeout_secs
## 

proc cass_cluster_set_connection_idle_timeout*(cluster: ptr CassCluster;
    timeout_secs: cuint)
## *
##  Sets the retry policy used for all requests unless overridden by setting
##  a retry policy on a statement or a batch.
## 
##  <b>Default:</b> The same policy as would be created by the function:
##  cass_retry_policy_default_new(). This policy will retry on a read timeout
##  if there was enough replicas, but no data present, on a write timeout if a
##  logged batch request failed to write the batch log, and on a unavailable
##  error it retries using a new host. In all other cases the default policy
##  will return an error.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] retry_policy
## 
##  @see cass_retry_policy_default_new()
##  @see cass_statement_set_retry_policy()
##  @see cass_batch_set_retry_policy()
## 

proc cass_cluster_set_retry_policy*(cluster: ptr CassCluster;
                                   retry_policy: ptr CassRetryPolicy)
## *
##  Enable/Disable retrieving and updating schema metadata. If disabled
##  this is allows the driver to skip over retrieving and updating schema
##  metadata and cass_session_get_schema_meta() will always return an empty object.
##  This can be useful for reducing the startup overhead of short-lived sessions.
## 
##  <b>Default:</b> cass_true (enabled).
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] enabled
## 
##  @see cass_session_get_schema_meta()
## 

proc cass_cluster_set_use_schema*(cluster: ptr CassCluster; enabled: cass_bool_t)
## *
##  Enable/Disable retrieving hostnames for IP addresses using reverse IP lookup.
## 
##  This is useful for authentication (Kerberos) or encryption (SSL) services
##  that require a valid hostname for verification.
## 
##  <b>Default:</b> cass_false (disabled).
## 
##  <b>Important:</b> Not implemented if using libuv 0.1x or earlier
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] enabled
##  @return CASS_OK if successful, otherwise an error occurred
## 
##  @see cass_cluster_set_resolve_timeout()
## 

proc cass_cluster_set_use_hostname_resolution*(cluster: ptr CassCluster;
    enabled: cass_bool_t): CassError
## *
##  Enable/Disable the randomization of the contact points list.
## 
##  <b>Default:</b> cass_true (enabled).
## 
##  <b>Important:</b> This setting should only be disabled for debugging or
##  tests.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] enabled
##  @return CASS_OK if successful, otherwise an error occurred
## 

proc cass_cluster_set_use_randomized_contact_points*(cluster: ptr CassCluster;
    enabled: cass_bool_t): CassError
## *
##  Enable constant speculative executions with the supplied settings.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @param[in] constant_delay_ms
##  @param[in] max_speculative_executions
##  @return CASS_OK if successful, otherwise an error occurred
## 

proc cass_cluster_set_constant_speculative_execution_policy*(
    cluster: ptr CassCluster; constant_delay_ms: int64;
    max_speculative_executions: cint): CassError
## *
##  Disable speculative executions
## 
##  <b>Default:</b> This is the default speculative execution policy.
## 
##  @public @memberof CassCluster
## 
##  @param[in] cluster
##  @return CASS_OK if successful, otherwise an error occurred
## 

proc cass_cluster_set_no_speculative_execution_policy*(cluster: ptr CassCluster): CassError
## **********************************************************************************
## 
##  Session
## 
## *********************************************************************************
## *
##  Creates a new session.
## 
##  @public @memberof CassSession
## 
##  @return Returns a session that must be freed.
## 
##  @see cass_session_free()
## 

proc cass_session_new*(): ptr CassSession
## *
##  Frees a session instance. If the session is still connected it will be synchronously
##  closed before being deallocated.
## 
##  Important: Do not free a session in a future callback. Freeing a session in a future
##  callback will cause a deadlock.
## 
##  @public @memberof CassSession
## 
##  @param[in] session
## 

proc cass_session_free*(session: ptr CassSession)
## *
##  Connects a session.
## 
##  @public @memberof CassSession
## 
##  @param[in] session
##  @param[in] cluster The cluster configuration is copied into the session and
##  is immutable after connection.
##  @return A future that must be freed.
## 
##  @see cass_session_close()
## 

proc cass_session_connect*(session: ptr CassSession; cluster: ptr CassCluster): ptr CassFuture
## *
##  Connects a session and sets the keyspace.
## 
##  @public @memberof CassSession
## 
##  @param[in] session
##  @param[in] cluster The cluster configuration is copied into the session and
##  is immutable after connection.
##  @param[in] keyspace
##  @return A future that must be freed.
## 
##  @see cass_session_close()
## 

proc cass_session_connect_keyspace*(session: ptr CassSession;
                                   cluster: ptr CassCluster; keyspace: cstring): ptr CassFuture
## *
##  Same as cass_session_connect_keyspace(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassSession
## 
##  @param[in] session
##  @param[in] cluster
##  @param[in] keyspace
##  @param[in] keyspace_length
##  @return same as cass_session_connect_keyspace()
## 
##  @see cass_session_connect_keyspace()
## 

proc cass_session_connect_keyspace_n*(session: ptr CassSession;
                                     cluster: ptr CassCluster; keyspace: cstring;
                                     keyspace_length: csize): ptr CassFuture
## *
##  Closes the session instance, outputs a close future which can
##  be used to determine when the session has been terminated. This allows
##  in-flight requests to finish.
## 
##  @public @memberof CassSession
## 
##  @param[in] session
##  @return A future that must be freed.
## 

proc cass_session_close*(session: ptr CassSession): ptr CassFuture
## *
##  Create a prepared statement.
## 
##  @public @memberof CassSession
## 
##  @param[in] session
##  @param[in] query The query is copied into the statement object; the
##  memory pointed to by this parameter can be freed after this call.
##  @return A future that must be freed.
## 
##  @see cass_future_get_prepared()
## 

proc cass_session_prepare*(session: ptr CassSession; query: cstring): ptr CassFuture
## *
##  Same as cass_session_prepare(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassSession
## 
##  @param[in] session
##  @param[in] query
##  @param[in] query_length
##  @return same as cass_session_prepare()
## 
##  @see cass_session_prepare()
## 

proc cass_session_prepare_n*(session: ptr CassSession; query: cstring;
                            query_length: csize): ptr CassFuture
## *
##  Execute a query or bound statement.
## 
##  @public @memberof CassSession
## 
##  @param[in] session
##  @param[in] statement
##  @return A future that must be freed.
## 
##  @see cass_future_get_result()
## 

proc cass_session_execute*(session: ptr CassSession; statement: ptr CassStatement): ptr CassFuture
## *
##  Execute a batch statement.
## 
##  @cassandra{2.0+}
## 
##  @public @memberof CassSession
## 
##  @param[in] session
##  @param[in] batch
##  @return A future that must be freed.
## 
##  @see cass_future_get_result()
## 

proc cass_session_execute_batch*(session: ptr CassSession; batch: ptr CassBatch): ptr CassFuture
## *
##  Gets a snapshot of this session's schema metadata. The returned
##  snapshot of the schema metadata is not updated. This function
##  must be called again to retrieve any schema changes since the
##  previous call.
## 
##  @public @memberof CassSession
## 
##  @param[in] session
##  @return A schema instance that must be freed.
## 
##  @see cass_schema_meta_free()
## 

proc cass_session_get_schema_meta*(session: ptr CassSession): ptr CassSchemaMeta
## *
##  Gets a copy of this session's performance/diagnostic metrics.
## 
##  @public @memberof CassSession
## 
##  @param[in] session
##  @param[out] output
## 

proc cass_session_get_metrics*(session: ptr CassSession; output: ptr CassMetrics)
## **********************************************************************************
## 
##  Schema Metadata
## 
## *********************************************************************************
## *
##  Frees a schema metadata instance.
## 
##  @public @memberof CassSchemaMeta
## 
##  @param[in] schema_meta
## 

proc cass_schema_meta_free*(schema_meta: ptr CassSchemaMeta)
## *
##  Gets the version of the schema metadata snapshot.
## 
##  @public @memberof CassSchemaMeta
## 
##  @param[in] schema_meta
## 
##  @return The snapshot version.
## 

proc cass_schema_meta_snapshot_version*(schema_meta: ptr CassSchemaMeta): uint32
## *
##  Gets the version of the connected Cassandra cluster.
## 
##  @public @memberof CassSchemaMeta
## 
##  @param[in] schema_meta
## 
##  @return Cassandra's version
## 

proc cass_schema_meta_version*(schema_meta: ptr CassSchemaMeta): CassVersion
## *
##  Gets the keyspace metadata for the provided keyspace name.
## 
##  @public @memberof CassSchemaMeta
## 
##  @param[in] schema_meta
##  @param[in] keyspace
## 
##  @return The metadata for a keyspace. NULL if keyspace does not exist.
## 

proc cass_schema_meta_keyspace_by_name*(schema_meta: ptr CassSchemaMeta;
                                       keyspace: cstring): ptr CassKeyspaceMeta
## *
##  Same as cass_schema_meta_keyspace_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassSchemaMeta
## 
##  @param[in] schema_meta
##  @param[in] keyspace
##  @param[in] keyspace_length
##  @return same as cass_schema_meta_keyspace_by_name()
## 
##  @see cass_schema_meta_keyspace_by_name()
## 

proc cass_schema_meta_keyspace_by_name_n*(schema_meta: ptr CassSchemaMeta;
    keyspace: cstring; keyspace_length: csize): ptr CassKeyspaceMeta
## *
##  Gets the name of the keyspace.
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @param[out] name
##  @param[out] name_length
## 

proc cass_keyspace_meta_name*(keyspace_meta: ptr CassKeyspaceMeta;
                             name: cstringArray; name_length: ptr csize)
## *
##  Gets the table metadata for the provided table name.
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @param[in] table
## 
##  @return The metadata for a table. NULL if table does not exist.
## 

proc cass_keyspace_meta_table_by_name*(keyspace_meta: ptr CassKeyspaceMeta;
                                      table: cstring): ptr CassTableMeta
## *
##  Same as cass_keyspace_meta_table_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @param[in] table
##  @param[in] table_length
##  @return same as cass_keyspace_meta_table_by_name()
## 
##  @see cass_keyspace_meta_table_by_name()
## 

proc cass_keyspace_meta_table_by_name_n*(keyspace_meta: ptr CassKeyspaceMeta;
                                        table: cstring; table_length: csize): ptr CassTableMeta
## *
##  Gets the materialized view metadata for the provided view name.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @param[in] view
## 
##  @return The metadata for a view. NULL if view does not exist.
## 

proc cass_keyspace_meta_materialized_view_by_name*(
    keyspace_meta: ptr CassKeyspaceMeta; view: cstring): ptr CassMaterializedViewMeta
## *
##  Same as cass_keyspace_meta_materialized_view_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @param[in] view
##  @param[in] view_length
##  @return same as cass_keyspace_meta_materialized_view_by_name()
## 
##  @see cass_keyspace_meta_materialized_view_by_name()
## 

proc cass_keyspace_meta_materialized_view_by_name_n*(
    keyspace_meta: ptr CassKeyspaceMeta; view: cstring; view_length: csize): ptr CassMaterializedViewMeta
## *
##  Gets the data type for the provided type name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @param[in] type
## 
##  @return The data type for a user defined type. NULL if type does not exist.
## 

proc cass_keyspace_meta_user_type_by_name*(keyspace_meta: ptr CassKeyspaceMeta;
    `type`: cstring): ptr CassDataType
## *
##  Same as cass_keyspace_meta_type_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @param[in] type
##  @param[in] type_length
##  @return same as cass_keyspace_meta_type_by_name()
## 
##  @see cass_keyspace_meta_type_by_name()
## 

proc cass_keyspace_meta_user_type_by_name_n*(keyspace_meta: ptr CassKeyspaceMeta;
    `type`: cstring; type_length: csize): ptr CassDataType
## *
##  Gets the function metadata for the provided function name.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @param[in] name
##  @param[in] arguments A comma delimited list of CQL types (e.g "text,int,...")
##  describing the function's signature.
## 
##  @return The data function for a user defined function. NULL if function does not exist.
## 

proc cass_keyspace_meta_function_by_name*(keyspace_meta: ptr CassKeyspaceMeta;
    name: cstring; arguments: cstring): ptr CassFunctionMeta
## *
##  Same as cass_keyspace_meta_function_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @param[in] name
##  @param[in] name_length
##  @param[in] arguments
##  @param[in] arguments_length
##  @return same as cass_keyspace_meta_function_by_name()
## 
##  @see cass_keyspace_meta_function_by_name()
## 

proc cass_keyspace_meta_function_by_name_n*(keyspace_meta: ptr CassKeyspaceMeta;
    name: cstring; name_length: csize; arguments: cstring; arguments_length: csize): ptr CassFunctionMeta
## *
##  Gets the aggregate metadata for the provided aggregate name.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @param[in] name
##  @param[in] arguments A comma delimited list of CQL types (e.g "text,int,...")
##  describing the aggregate's signature.
## 
##  @return The data aggregate for a user defined aggregate. NULL if aggregate does not exist.
## 

proc cass_keyspace_meta_aggregate_by_name*(keyspace_meta: ptr CassKeyspaceMeta;
    name: cstring; arguments: cstring): ptr CassAggregateMeta
## *
##  Same as cass_keyspace_meta_aggregate_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @param[in] name
##  @param[in] name_length
##  @param[in] arguments
##  @param[in] arguments_length
##  @return same as cass_keyspace_meta_aggregate_by_name()
## 
##  @see cass_keyspace_meta_aggregate_by_name()
## 

proc cass_keyspace_meta_aggregate_by_name_n*(keyspace_meta: ptr CassKeyspaceMeta;
    name: cstring; name_length: csize; arguments: cstring; arguments_length: csize): ptr CassAggregateMeta
## *
##  Gets a metadata field for the provided name. Metadata fields allow direct
##  access to the column data found in the underlying "keyspaces" metadata table.
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @param[in] name
##  @return A metadata field value. NULL if the field does not exist.
## 

proc cass_keyspace_meta_field_by_name*(keyspace_meta: ptr CassKeyspaceMeta;
                                      name: cstring): ptr CassValue
## *
##  Same as cass_keyspace_meta_field_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @param[in] name
##  @param[in] name_length
##  @return same as cass_keyspace_meta_field_by_name()
## 
##  @see cass_keyspace_meta_field_by_name()
## 

proc cass_keyspace_meta_field_by_name_n*(keyspace_meta: ptr CassKeyspaceMeta;
                                        name: cstring; name_length: csize): ptr CassValue
## *
##  Gets the name of the table.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[out] name
##  @param[out] name_length
## 

proc cass_table_meta_name*(table_meta: ptr CassTableMeta; name: cstringArray;
                          name_length: ptr csize)
## *
##  Gets the column metadata for the provided column name.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[in] column
## 
##  @return The metadata for a column. NULL if column does not exist.
## 

proc cass_table_meta_column_by_name*(table_meta: ptr CassTableMeta; column: cstring): ptr CassColumnMeta
## *
##  Same as cass_table_meta_column_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[in] column
##  @param[in] column_length
##  @return same as cass_table_meta_column_by_name()
## 
##  @see cass_table_meta_column_by_name()
## 

proc cass_table_meta_column_by_name_n*(table_meta: ptr CassTableMeta;
                                      column: cstring; column_length: csize): ptr CassColumnMeta
## *
##  Gets the total number of columns for the table.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @return The total column count.
## 

proc cass_table_meta_column_count*(table_meta: ptr CassTableMeta): csize
## *
##  Gets the column metadata for the provided index.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[in] index
##  @return The metadata for a column. NULL returned if the index is out of range.
## 

proc cass_table_meta_column*(table_meta: ptr CassTableMeta; index: csize): ptr CassColumnMeta
## *
##  Gets the index metadata for the provided index name.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[in] index
## 
##  @return The metadata for a index. NULL if index does not exist.
## 

proc cass_table_meta_index_by_name*(table_meta: ptr CassTableMeta; index: cstring): ptr CassIndexMeta
## *
##  Same as cass_table_meta_index_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[in] index
##  @param[in] index_length
##  @return same as cass_table_meta_index_by_name()
## 
##  @see cass_table_meta_index_by_name()
## 

proc cass_table_meta_index_by_name_n*(table_meta: ptr CassTableMeta; index: cstring;
                                     index_length: csize): ptr CassIndexMeta
## *
##  Gets the total number of indexes for the table.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @return The total index count.
## 

proc cass_table_meta_index_count*(table_meta: ptr CassTableMeta): csize
## *
##  Gets the index metadata for the provided index.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[in] index
##  @return The metadata for a index. NULL returned if the index is out of range.
## 

proc cass_table_meta_index*(table_meta: ptr CassTableMeta; index: csize): ptr CassIndexMeta
## *
##  Gets the materialized view metadata for the provided view name.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[in] view
## 
##  @return The metadata for a view. NULL if view does not exist.
## 

proc cass_table_meta_materialized_view_by_name*(table_meta: ptr CassTableMeta;
    view: cstring): ptr CassMaterializedViewMeta
## *
##  Same as cass_table_meta_materialized_view_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[in] view
##  @param[in] view_length
##  @return same as cass_table_meta_materialized_view_by_name()
## 
##  @see cass_table_meta_materialized_view_by_name()
## 

proc cass_table_meta_materialized_view_by_name_n*(table_meta: ptr CassTableMeta;
    view: cstring; view_length: csize): ptr CassMaterializedViewMeta
## *
##  Gets the total number of views for the table.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @return The total view count.
## 

proc cass_table_meta_materialized_view_count*(table_meta: ptr CassTableMeta): csize
## *
##  Gets the materialized view metadata for the provided index.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[in] index
##  @return The metadata for a view. NULL returned if the index is out of range.
## 

proc cass_table_meta_materialized_view*(table_meta: ptr CassTableMeta; index: csize): ptr CassMaterializedViewMeta
## *
##  Gets the number of columns for the table's partition key.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @return The count for the number of columns in the partition key.
## 

proc cass_table_meta_partition_key_count*(table_meta: ptr CassTableMeta): csize
## *
##  Gets the partition key column metadata for the provided index.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[in] index
##  @return The metadata for a column. NULL returned if the index is out of range.
## 
##  @see cass_table_meta_partition_key_count()
## 

proc cass_table_meta_partition_key*(table_meta: ptr CassTableMeta; index: csize): ptr CassColumnMeta
## *
##  Gets the number of columns for the table's clustering key.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @return The count for the number of columns in the clustering key.
## 

proc cass_table_meta_clustering_key_count*(table_meta: ptr CassTableMeta): csize
## *
##  Gets the clustering key column metadata for the provided index.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[in] index
##  @return The metadata for a column. NULL returned if the index is out of range.
## 
##  @see cass_table_meta_clustering_key_count()
## 

proc cass_table_meta_clustering_key*(table_meta: ptr CassTableMeta; index: csize): ptr CassColumnMeta
## *
##  Gets the clustering order column metadata for the provided index.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[in] index
##  @return The clustering order for a column.
##  CASS_CLUSTERING_ORDER_NONE returned if the index is out of range.
## 
##  @see cass_table_meta_clustering_key_count()
## 

proc cass_table_meta_clustering_key_order*(table_meta: ptr CassTableMeta;
    index: csize): CassClusteringOrder
## *
##  Gets a metadata field for the provided name. Metadata fields allow direct
##  access to the column data found in the underlying "tables" metadata table.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[in] name
##  @return A metadata field value. NULL if the field does not exist.
## 

proc cass_table_meta_field_by_name*(table_meta: ptr CassTableMeta; name: cstring): ptr CassValue
## *
##  Same as cass_table_meta_field_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @param[in] name
##  @param[in] name_length
##  @return same as cass_table_meta_field_by_name()
## 
##  @see cass_table_meta_field_by_name()
## 

proc cass_table_meta_field_by_name_n*(table_meta: ptr CassTableMeta; name: cstring;
                                     name_length: csize): ptr CassValue
## *
##  Gets the column metadata for the provided column name.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
##  @param[in] column
## 
##  @return The metadata for a column. NULL if column does not exist.
## 

proc cass_materialized_view_meta_column_by_name*(
    view_meta: ptr CassMaterializedViewMeta; column: cstring): ptr CassColumnMeta
## *
##  Same as cass_materialized_view_meta_column_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
##  @param[in] column
##  @param[in] column_length
##  @return same as cass_materialized_view_meta_column_by_name()
## 
##  @see cass_materialized_view_meta_column_by_name()
## 

proc cass_materialized_view_meta_column_by_name_n*(
    view_meta: ptr CassMaterializedViewMeta; column: cstring; column_length: csize): ptr CassColumnMeta
## *
##  Gets the name of the view.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
##  @param[out] name
##  @param[out] name_length
## 

proc cass_materialized_view_meta_name*(view_meta: ptr CassMaterializedViewMeta;
                                      name: cstringArray; name_length: ptr csize)
## *
##  Gets the base table of the view.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
## 
##  @return The base table for the view.
## 

proc cass_materialized_view_meta_base_table*(
    view_meta: ptr CassMaterializedViewMeta): ptr CassTableMeta
## *
##  Gets the total number of columns for the view.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
##  @return The total column count.
## 

proc cass_materialized_view_meta_column_count*(
    view_meta: ptr CassMaterializedViewMeta): csize
## *
##  Gets the column metadata for the provided index.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
##  @param[in] index
##  @return The metadata for a column. NULL returned if the index is out of range.
## 

proc cass_materialized_view_meta_column*(view_meta: ptr CassMaterializedViewMeta;
                                        index: csize): ptr CassColumnMeta
## *
##  Gets the number of columns for the view's partition key.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
##  @return The count for the number of columns in the partition key.
## 

proc cass_materialized_view_meta_partition_key_count*(
    view_meta: ptr CassMaterializedViewMeta): csize
## *
##  Gets the partition key column metadata for the provided index.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
##  @param[in] index
##  @return The metadata for a column. NULL returned if the index is out of range.
## 

proc cass_materialized_view_meta_partition_key*(
    view_meta: ptr CassMaterializedViewMeta; index: csize): ptr CassColumnMeta
## *
##  Gets the number of columns for the view's clustering key.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
##  @return The count for the number of columns in the clustering key.
## 

proc cass_materialized_view_meta_clustering_key_count*(
    view_meta: ptr CassMaterializedViewMeta): csize
## *
##  Gets the clustering key column metadata for the provided index.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
##  @param[in] index
##  @return The metadata for a column. NULL returned if the index is out of range.
## 

proc cass_materialized_view_meta_clustering_key*(
    view_meta: ptr CassMaterializedViewMeta; index: csize): ptr CassColumnMeta
## *
##  Gets the clustering order column metadata for the provided index.
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
##  @param[in] index
##  @return The clustering order for a column.
##  CASS_CLUSTERING_ORDER_NONE returned if the index is out of range.
## 
##  @see cass_materialized_view_meta_clustering_key_count()
## 

proc cass_materialized_view_meta_clustering_key_order*(
    view_meta: ptr CassMaterializedViewMeta; index: csize): CassClusteringOrder
## *
##  Gets a metadata field for the provided name. Metadata fields allow direct
##  access to the column data found in the underlying "views" metadata view.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
##  @param[in] name
##  @return A metadata field value. NULL if the field does not exist.
## 

proc cass_materialized_view_meta_field_by_name*(
    view_meta: ptr CassMaterializedViewMeta; name: cstring): ptr CassValue
## *
##  Same as cass_materialized_view_meta_field_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
##  @param[in] name
##  @param[in] name_length
##  @return same as cass_materialized_view_meta_field_by_name()
## 
##  @see cass_materialized_view_meta_field_by_name()
## 

proc cass_materialized_view_meta_field_by_name_n*(
    view_meta: ptr CassMaterializedViewMeta; name: cstring; name_length: csize): ptr CassValue
## *
##  Gets the name of the column.
## 
##  @public @memberof CassColumnMeta
## 
##  @param[in] column_meta
##  @param[out] name
##  @param[out] name_length
## 

proc cass_column_meta_name*(column_meta: ptr CassColumnMeta; name: cstringArray;
                           name_length: ptr csize)
## *
##  Gets the type of the column.
## 
##  @public @memberof CassColumnMeta
## 
##  @param[in] column_meta
##  @return The column's type.
## 

proc cass_column_meta_type*(column_meta: ptr CassColumnMeta): CassColumnType
## *
##  Gets the data type of the column.
## 
##  @public @memberof CassColumnMeta
## 
##  @param[in] column_meta
##  @return The column's data type.
## 

proc cass_column_meta_data_type*(column_meta: ptr CassColumnMeta): ptr CassDataType
## *
##  Gets a metadata field for the provided name. Metadata fields allow direct
##  access to the column data found in the underlying "columns" metadata table.
## 
##  @public @memberof CassColumnMeta
## 
##  @param[in] column_meta
##  @param[in] name
##  @return A metadata field value. NULL if the field does not exist.
## 

proc cass_column_meta_field_by_name*(column_meta: ptr CassColumnMeta; name: cstring): ptr CassValue
## *
##  Same as cass_column_meta_field_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassColumnMeta
## 
##  @param[in] column_meta
##  @param[in] name
##  @param[in] name_length
##  @return same as cass_column_meta_field_by_name()
## 
##  @see cass_column_meta_field_by_name()
## 

proc cass_column_meta_field_by_name_n*(column_meta: ptr CassColumnMeta;
                                      name: cstring; name_length: csize): ptr CassValue
## *
##  Gets the name of the index.
## 
##  @public @memberof CassIndexMeta
## 
##  @param[in] index_meta
##  @param[out] name
##  @param[out] name_length
## 

proc cass_index_meta_name*(index_meta: ptr CassIndexMeta; name: cstringArray;
                          name_length: ptr csize)
## *
##  Gets the type of the index.
## 
##  @public @memberof CassIndexMeta
## 
##  @param[in] index_meta
##  @return The index's type.
## 

proc cass_index_meta_type*(index_meta: ptr CassIndexMeta): CassIndexType
## *
##  Gets the target of the index.
## 
##  @public @memberof CassIndexMeta
## 
##  @param[in] index_meta
##  @param[out] target
##  @param[out] target_length
## 

proc cass_index_meta_target*(index_meta: ptr CassIndexMeta; target: cstringArray;
                            target_length: ptr csize)
## *
##  Gets the options of the index.
## 
##  @public @memberof CassIndexMeta
## 
##  @param[in] index_meta
##  @return The index's options.
## 

proc cass_index_meta_options*(index_meta: ptr CassIndexMeta): ptr CassValue
## *
##  Gets a metadata field for the provided name. Metadata fields allow direct
##  access to the index data found in the underlying "indexes" metadata table.
## 
##  @public @memberof CassIndexMeta
## 
##  @param[in] index_meta
##  @param[in] name
##  @return A metadata field value. NULL if the field does not exist.
## 

proc cass_index_meta_field_by_name*(index_meta: ptr CassIndexMeta; name: cstring): ptr CassValue
## *
##  Same as cass_index_meta_field_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassIndexMeta
## 
##  @param[in] index_meta
##  @param[in] name
##  @param[in] name_length
##  @return same as cass_index_meta_field_by_name()
## 
##  @see cass_index_meta_field_by_name()
## 

proc cass_index_meta_field_by_name_n*(index_meta: ptr CassIndexMeta; name: cstring;
                                     name_length: csize): ptr CassValue
## *
##  Gets the name of the function.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFunctionMeta
## 
##  @param[in] function_meta
##  @param[out] name
##  @param[out] name_length
## 

proc cass_function_meta_name*(function_meta: ptr CassFunctionMeta;
                             name: cstringArray; name_length: ptr csize)
## *
##  Gets the full name of the function. The full name includes the
##  function's name and the function's signature:
##  "name(type1 type2.. typeN)".
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFunctionMeta
## 
##  @param[in] function_meta
##  @param[out] full_name
##  @param[out] full_name_length
## 

proc cass_function_meta_full_name*(function_meta: ptr CassFunctionMeta;
                                  full_name: cstringArray;
                                  full_name_length: ptr csize)
## *
##  Gets the body of the function.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFunctionMeta
## 
##  @param[in] function_meta
##  @param[out] body
##  @param[out] body_length
## 

proc cass_function_meta_body*(function_meta: ptr CassFunctionMeta;
                             body: cstringArray; body_length: ptr csize)
## *
##  Gets the language of the function.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFunctionMeta
## 
##  @param[in] function_meta
##  @param[out] language
##  @param[out] language_length
## 

proc cass_function_meta_language*(function_meta: ptr CassFunctionMeta;
                                 language: cstringArray;
                                 language_length: ptr csize)
## *
##  Gets whether a function is called on "null".
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFunctionMeta
## 
##  @param[in] function_meta
##  @return cass_true if a function is called on null, otherwise cass_false.
## 

proc cass_function_meta_called_on_null_input*(function_meta: ptr CassFunctionMeta): cass_bool_t
## *
##  Gets the number of arguments this function takes.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFunctionMeta
## 
##  @param[in] function_meta
##  @return The number of arguments.
## 

proc cass_function_meta_argument_count*(function_meta: ptr CassFunctionMeta): csize
## *
##  Gets the function's argument name and type for the provided index.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFunctionMeta
## 
##  @param[in] function_meta
##  @param[in] index
##  @param[out] name
##  @param[out] name_length
##  @param[out] type
##  @return CASS_OK if successful, otherwise an error occurred
## 

proc cass_function_meta_argument*(function_meta: ptr CassFunctionMeta; index: csize;
                                 name: cstringArray; name_length: ptr csize;
                                 `type`: ptr ptr CassDataType): CassError
## *
##  Gets the function's argument and type for the provided name.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFunctionMeta
## 
##  @param[in] function_meta
##  @param[in] name
##  @return A data type. NULL if the argument does not exist.
## 

proc cass_function_meta_argument_type_by_name*(
    function_meta: ptr CassFunctionMeta; name: cstring): ptr CassDataType
## *
##  Same as cass_function_meta_argument_type_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFunctionMeta
## 
##  @param[in] function_meta
##  @param[in] name
##  @param[in] name_length
##  @return same as cass_function_meta_argument_type_by_name()
## 
##  @see cass_function_meta_argument_type_by_name()
## 

proc cass_function_meta_argument_type_by_name_n*(
    function_meta: ptr CassFunctionMeta; name: cstring; name_length: csize): ptr CassDataType
## *
##  Gets the return type of the function.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFunctionMeta
## 
##  @param[in] function_meta
##  @return The data type returned by the function.
## 

proc cass_function_meta_return_type*(function_meta: ptr CassFunctionMeta): ptr CassDataType
## *
##  Gets a metadata field for the provided name. Metadata fields allow direct
##  access to the column data found in the underlying "functions" metadata table.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFunctionMeta
## 
##  @param[in] function_meta
##  @param[in] name
##  @return A metadata field value. NULL if the field does not exist.
## 

proc cass_function_meta_field_by_name*(function_meta: ptr CassFunctionMeta;
                                      name: cstring): ptr CassValue
## *
##  Same as cass_function_meta_field_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFunctionMeta
## 
##  @param[in] function_meta
##  @param[in] name
##  @param[in] name_length
##  @return same as cass_function_meta_field_by_name()
## 
##  @see cass_function_meta_field_by_name()
## 

proc cass_function_meta_field_by_name_n*(function_meta: ptr CassFunctionMeta;
                                        name: cstring; name_length: csize): ptr CassValue
## *
##  Gets the name of the aggregate.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassAggregateMeta
## 
##  @param[in] aggregate_meta
##  @param[out] name
##  @param[out] name_length
## 

proc cass_aggregate_meta_name*(aggregate_meta: ptr CassAggregateMeta;
                              name: cstringArray; name_length: ptr csize)
## *
##  Gets the full name of the aggregate. The full name includes the
##  aggregate's name and the aggregate's signature:
##  "name(type1 type2.. typeN)".
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassAggregateMeta
## 
##  @param[in] aggregate_meta
##  @param[out] full_name
##  @param[out] full_name_length
## 

proc cass_aggregate_meta_full_name*(aggregate_meta: ptr CassAggregateMeta;
                                   full_name: cstringArray;
                                   full_name_length: ptr csize)
## *
##  Gets the number of arguments this aggregate takes.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassAggregateMeta
## 
##  @param[in] aggregate_meta
##  @return The number of arguments.
## 

proc cass_aggregate_meta_argument_count*(aggregate_meta: ptr CassAggregateMeta): csize
## *
##  Gets the aggregate's argument type for the provided index.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassAggregateMeta
## 
##  @param[in] aggregate_meta
##  @param[in] index
##  @return The data type for argument. NULL returned if the index is out of range.
## 

proc cass_aggregate_meta_argument_type*(aggregate_meta: ptr CassAggregateMeta;
                                       index: csize): ptr CassDataType
## *
##  Gets the return type of the aggregate.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassAggregateMeta
## 
##  @param[in] aggregate_meta
##  @return The data type returned by the aggregate.
## 

proc cass_aggregate_meta_return_type*(aggregate_meta: ptr CassAggregateMeta): ptr CassDataType
## *
##  Gets the state type of the aggregate.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassAggregateMeta
## 
##  @param[in] aggregate_meta
##  @return The data type of the aggregate's state.
## 

proc cass_aggregate_meta_state_type*(aggregate_meta: ptr CassAggregateMeta): ptr CassDataType
## *
##  Gets the function metadata for the aggregate's state function.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassAggregateMeta
## 
##  @param[in] aggregate_meta
##  @return The function metadata for the state function.
## 

proc cass_aggregate_meta_state_func*(aggregate_meta: ptr CassAggregateMeta): ptr CassFunctionMeta
## *
##  Gets the function metadata for the aggregates's final function.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassAggregateMeta
## 
##  @param[in] aggregate_meta
##  @return The function metadata for the final function.
## 

proc cass_aggregate_meta_final_func*(aggregate_meta: ptr CassAggregateMeta): ptr CassFunctionMeta
## *
##  Gets the initial condition value for the aggregate.
## 
##  @cassandra{2.2+}
## 
##  <b>Note:</b> The value of the initial condition will always be
##  a "varchar" type for Cassandra 3.0+.
## 
##  @public @memberof CassAggregateMeta
## 
##  @param[in] aggregate_meta
##  @return The value of the initial condition.
## 

proc cass_aggregate_meta_init_cond*(aggregate_meta: ptr CassAggregateMeta): ptr CassValue
## *
##  Gets a metadata field for the provided name. Metadata fields allow direct
##  access to the column data found in the underlying "aggregates" metadata table.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassAggregateMeta
## 
##  @param[in] aggregate_meta
##  @param[in] name
##  @return A metadata field value. NULL if the field does not exist.
## 

proc cass_aggregate_meta_field_by_name*(aggregate_meta: ptr CassAggregateMeta;
                                       name: cstring): ptr CassValue
## *
##  Same as cass_aggregate_meta_field_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassAggregateMeta
## 
##  @param[in] aggregate_meta
##  @param[in] name
##  @param[in] name_length
##  @return same as cass_aggregate_meta_field_by_name()
## 
##  @see cass_aggregate_meta_field_by_name()
## 

proc cass_aggregate_meta_field_by_name_n*(aggregate_meta: ptr CassAggregateMeta;
    name: cstring; name_length: csize): ptr CassValue
## **********************************************************************************
## 
##  SSL
## 
## **********************************************************************************
## *
##  Creates a new SSL context.
## 
##  @public @memberof CassSsl
## 
##  @return Returns a SSL context that must be freed.
## 
##  @see cass_ssl_free()
## 

proc cass_ssl_new*(): ptr CassSsl
## *
##  Creates a new SSL context <b>without</b> initializing the underlying library
##  implementation. The integrating application is responsible for
##  initializing the underlying SSL implementation. The driver uses the SSL
##  implmentation from several threads concurrently so it's important that it's
##  properly setup for multithreaded use e.g. lock callbacks for OpenSSL.
## 
##  <b>Important:</b> The SSL library must be initialized before calling this
##  function.
## 
##  When using OpenSSL the following components need to be initialized:
## 
##  SSL_library_init();
##  SSL_load_error_strings();
##  OpenSSL_add_all_algorithms();
## 
##  The following thread-safety callbacks also need to be set:
## 
##  CRYPTO_set_locking_callback(...);
##  CRYPTO_set_id_callback(...);
## 
##  @public @memberof CassSsl
## 
##  @return Returns a SSL context that must be freed.
## 
##  @see cass_ssl_new()
##  @see cass_ssl_free()
## 

proc cass_ssl_new_no_lib_init*(): ptr CassSsl
## *
##  Frees a SSL context instance.
## 
##  @public @memberof CassSsl
## 
##  @param[in] ssl
## 

proc cass_ssl_free*(ssl: ptr CassSsl)
## *
##  Adds a trusted certificate. This is used to verify
##  the peer's certificate.
## 
##  @public @memberof CassSsl
## 
##  @param[in] ssl
##  @param[in] cert PEM formatted certificate string
##  @return CASS_OK if successful, otherwise an error occurred
## 

proc cass_ssl_add_trusted_cert*(ssl: ptr CassSsl; cert: cstring): CassError
## *
##  Same as cass_ssl_add_trusted_cert(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassSsl
## 
##  @param[in] ssl
##  @param[in] cert
##  @param[in] cert_length
##  @return same as cass_ssl_add_trusted_cert()
## 
##  @see cass_ssl_add_trusted_cert()
## 

proc cass_ssl_add_trusted_cert_n*(ssl: ptr CassSsl; cert: cstring; cert_length: csize): CassError
## *
##  Sets verification performed on the peer's certificate.
## 
##  CASS_SSL_VERIFY_NONE - No verification is performed
##  CASS_SSL_VERIFY_PEER_CERT - Certificate is present and valid
##  CASS_SSL_VERIFY_PEER_IDENTITY - IP address matches the certificate's
##  common name or one of its subject alternative names. This implies the
##  certificate is also present.
##  CASS_SSL_VERIFY_PEER_IDENTITY_DNS - Hostname matches the certificate's
##  common name or one of its subject alternative names. This implies the
##  certificate is also present. Hostname resolution must also be enabled.
## 
##  <b>Default:</b> CASS_SSL_VERIFY_PEER_CERT
## 
##  @public @memberof CassSsl
## 
##  @param[in] ssl
##  @param[in] flags
##  @return CASS_OK if successful, otherwise an error occurred
## 
##  @see cass_cluster_set_use_hostname_resolution()
## 

proc cass_ssl_set_verify_flags*(ssl: ptr CassSsl; flags: cint)
## *
##  Set client-side certificate chain. This is used to authenticate
##  the client on the server-side. This should contain the entire
##  Certificate chain starting with the certificate itself.
## 
##  @public @memberof CassSsl
## 
##  @param[in] ssl
##  @param[in] cert PEM formatted certificate string
##  @return CASS_OK if successful, otherwise an error occurred
## 

proc cass_ssl_set_cert*(ssl: ptr CassSsl; cert: cstring): CassError
## *
##  Same as cass_ssl_set_cert(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassSsl
## 
##  @param[in] ssl
##  @param[in] cert
##  @param[in] cert_length
##  @return same as cass_ssl_set_cert()
## 
##  @see cass_ssl_set_cert()
## 

proc cass_ssl_set_cert_n*(ssl: ptr CassSsl; cert: cstring; cert_length: csize): CassError
## *
##  Set client-side private key. This is used to authenticate
##  the client on the server-side.
## 
##  @public @memberof CassSsl
## 
##  @param[in] ssl
##  @param[in] key PEM formatted key string
##  @param[in] password used to decrypt key
##  @return CASS_OK if successful, otherwise an error occurred
## 

proc cass_ssl_set_private_key*(ssl: ptr CassSsl; key: cstring; password: cstring): CassError
## *
##  Same as cass_ssl_set_private_key(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassSsl
## 
##  @param[in] ssl
##  @param[in] key
##  @param[in] key_length
##  @param[in] password
##  @param[in] password_length
##  @return same as cass_ssl_set_private_key()
## 
##  @see cass_ssl_set_private_key()
## 

proc cass_ssl_set_private_key_n*(ssl: ptr CassSsl; key: cstring; key_length: csize;
                                password: cstring; password_length: csize): CassError
## **********************************************************************************
## 
##  Authenticator
## 
## **********************************************************************************
## *
##  Gets the IP address of the host being authenticated.
## 
##  @param[in] auth
##  @param[out] address
## 
##  @public @memberof CassAuthenticator
## 

proc cass_authenticator_address*(auth: ptr CassAuthenticator; address: ptr CassInet)
## *
##  Gets the hostname of the host being authenticated.
## 
##  @public @memberof CassAuthenticator
## 
##  @param[in] auth
##  @param[out] length
##  @return A null-terminated string.
## 

proc cass_authenticator_hostname*(auth: ptr CassAuthenticator; length: ptr csize): cstring
## *
##  Gets the class name for the server-side IAuthentication implementation.
## 
##  @public @memberof CassAuthenticator
## 
##  @param[in] auth
##  @param[out] length
##  @return A null-terminated string.
## 

proc cass_authenticator_class_name*(auth: ptr CassAuthenticator; length: ptr csize): cstring
## *
##  Gets the user data created during the authenticator exchange. This
##  is set using cass_authenticator_set_exchange_data().
## 
##  @public @memberof CassAuthenticator
## 
##  @param[in] auth
##  @return User specified exchange data previously set by
##  cass_authenticator_set_exchange_data().
## 
##  @see cass_authenticator_set_exchange_data()
## 

proc cass_authenticator_exchange_data*(auth: ptr CassAuthenticator): pointer
## *
##  Sets the user data to be used during the authenticator exchange.
## 
##  @public @memberof CassAuthenticator
## 
##  @param[in] auth
##  @param[in] exchange_data
## 
##  @see cass_authenticator_exchange_data()
## 

proc cass_authenticator_set_exchange_data*(auth: ptr CassAuthenticator;
    exchange_data: pointer)
## *
##  Gets a response token buffer of the provided size.
## 
##  @public @memberof CassAuthenticator
## 
##  @param[in] auth
##  @param[in] size
##  @return A buffer to copy the response token.
## 

proc cass_authenticator_response*(auth: ptr CassAuthenticator; size: csize): cstring
## *
##  Sets the response token.
## 
##  @public @memberof CassAuthenticator
## 
##  @param[in] auth
##  @param[in] response
##  @param[in] response_size
## 

proc cass_authenticator_set_response*(auth: ptr CassAuthenticator;
                                     response: cstring; response_size: csize)
## *
##  Sets an error for the authenticator exchange.
## 
##  @public @memberof CassAuthenticator
## 
##  @param[in] auth
##  @param[in] message
## 

proc cass_authenticator_set_error*(auth: ptr CassAuthenticator; message: cstring)
## *
##  Same as cass_authenticator_set_error_n(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassAuthenticator
## 
##  @param[in] auth
##  @param[in] message
##  @param[in] message_length
## 
##  @see cass_authenticator_set_error()
## 

proc cass_authenticator_set_error_n*(auth: ptr CassAuthenticator; message: cstring;
                                    message_length: csize)
## **********************************************************************************
## 
##  Future
## 
## *********************************************************************************
## *
##  Frees a future instance. A future can be freed anytime.
## 
##  @public @memberof CassFuture
## 

proc cass_future_free*(future: ptr CassFuture)
## *
##  Sets a callback that is called when a future is set
## 
##  @public @memberof CassFuture
## 
##  @param[in] future
##  @param[in] callback
##  @param[in] data
##  @return CASS_OK if successful, otherwise an error occurred
## 

proc cass_future_set_callback*(future: ptr CassFuture; callback: CassFutureCallback;
                              data: pointer): CassError
## *
##  Gets the set status of the future.
## 
##  @public @memberof CassFuture
## 
##  @param[in] future
##  @return true if set
## 

proc cass_future_ready*(future: ptr CassFuture): cass_bool_t
## *
##  Wait for the future to be set with either a result or error.
## 
##  <b>Important:</b> Do not wait in a future callback. Waiting in a future
##  callback will cause a deadlock.
## 
##  @public @memberof CassFuture
## 
##  @param[in] future
## 

proc cass_future_wait*(future: ptr CassFuture)
## *
##  Wait for the future to be set or timeout.
## 
##  @public @memberof CassFuture
## 
##  @param[in] future
##  @param[in] timeout_us wait time in microseconds
##  @return false if returned due to timeout
## 

proc cass_future_wait_timed*(future: ptr CassFuture; timeout_us: cass_duration_t): cass_bool_t
## *
##  Gets the result of a successful future. If the future is not ready this method will
##  wait for the future to be set.
## 
##  @public @memberof CassFuture
## 
##  @param[in] future
##  @return CassResult instance if successful, otherwise NULL for error. The return instance
##  must be freed using cass_result_free().
## 
##  @see cass_session_execute() and cass_session_execute_batch()
## 

proc cass_future_get_result*(future: ptr CassFuture): ptr CassResult
## *
##  Gets the error result from a future that failed as a result of a server error. If the
##  future is not ready this method will wait for the future to be set.
## 
##  @public @memberof CassFuture
## 
##  @param[in] future
##  @return CassErrorResult instance if the request failed with a server error,
##  otherwise NULL if the request was successful or the failure was not caused by
##  a server error. The return instance must be freed using cass_error_result_free().
## 
##  @see cass_session_execute() and cass_session_execute_batch()
## 

proc cass_future_get_error_result*(future: ptr CassFuture): ptr CassErrorResult
## *
##  Gets the result of a successful future. If the future is not ready this method will
##  wait for the future to be set. The first successful call consumes the future, all
##  subsequent calls will return NULL.
## 
##  @public @memberof CassFuture
## 
##  @param[in] future
##  @return CassPrepared instance if successful, otherwise NULL for error. The return instance
##  must be freed using cass_prepared_free().
## 
##  @see cass_session_prepare()
## 

proc cass_future_get_prepared*(future: ptr CassFuture): ptr CassPrepared
## *
##  Gets the error code from future. If the future is not ready this method will
##  wait for the future to be set.
## 
##  @public @memberof CassFuture
## 
##  @param[in] future
##  @return CASS_OK if successful, otherwise an error occurred.
## 
##  @see cass_error_desc()
## 

proc cass_future_error_code*(future: ptr CassFuture): CassError
## *
##  Gets the error message from future. If the future is not ready this method will
##  wait for the future to be set.
## 
##  @public @memberof CassFuture
## 
##  @param[in] future
##  @param[out] message Empty string returned if successful, otherwise
##  a message describing the error is returned.
##  @param[out] message_length
## 

proc cass_future_error_message*(future: ptr CassFuture; message: cstringArray;
                               message_length: ptr csize)
## *
##  Gets a the number of custom payload items from a response future. If the future is not
##  ready this method will wait for the future to be set.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFuture
## 
##  @param[in] future
##  @return the number of custom payload items.
## 

proc cass_future_custom_payload_item_count*(future: ptr CassFuture): csize
## *
##  Gets a custom payload item from a response future at the specified index. If the future is not
##  ready this method will wait for the future to be set.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFuture
## 
##  @param[in] future
##  @param[in] index
##  @param[out] name
##  @param[out] name_length
##  @param[out] value
##  @param[out] value_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_future_custom_payload_item*(future: ptr CassFuture; index: csize;
                                     name: cstringArray; name_length: ptr csize;
                                     value: ptr ptr cass_byte_t;
                                     value_size: ptr csize): CassError
## **********************************************************************************
## 
##  Statement
## 
## *********************************************************************************
## *
##  Creates a new query statement.
## 
##  @public @memberof CassStatement
## 
##  @param[in] query The query is copied into the statement object; the
##  memory pointed to by this parameter can be freed after this call.
##  @param[in] parameter_count The number of bound parameters.
##  @return Returns a statement that must be freed.
## 
##  @see cass_statement_free()
## 

proc cass_statement_new*(query: cstring; parameter_count: csize): ptr CassStatement
## *
##  Same as cass_statement_new(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] query
##  @param[in] query_length
##  @param[in] parameter_count
##  @return same as cass_statement_new()
## 
##  @see cass_statement_new()
## 

proc cass_statement_new_n*(query: cstring; query_length: csize;
                          parameter_count: csize): ptr CassStatement
## *
##  Clear and/or resize the statement's parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] count
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_reset_parameters*(statement: ptr CassStatement; count: csize): CassError
## *
##  Frees a statement instance. Statements can be immediately freed after
##  being prepared, executed or added to a batch.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
## 

proc cass_statement_free*(statement: ptr CassStatement)
## *
##  Adds a key index specifier to this a statement.
##  When using token-aware routing, this can be used to tell the driver which
##  parameters within a non-prepared, parameterized statement are part of
##  the partition key.
## 
##  Use consecutive calls for composite partition keys.
## 
##  This is not necessary for prepared statements, as the key
##  parameters are determined in the metadata processed in the prepare phase.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_add_key_index*(statement: ptr CassStatement; index: csize): CassError
## *
##  Sets the statement's keyspace for use with token-aware routing.
## 
##  This is not necessary for prepared statements, as the keyspace
##  is determined in the metadata processed in the prepare phase.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] keyspace
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_set_keyspace*(statement: ptr CassStatement; keyspace: cstring): CassError
## *
##  Same as cass_statement_set_keyspace(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] keyspace
##  @param[in] keyspace_length
##  @return same as cass_statement_set_keyspace()
## 
##  @see cass_statement_set_keyspace()
## 

proc cass_statement_set_keyspace_n*(statement: ptr CassStatement; keyspace: cstring;
                                   keyspace_length: csize): CassError
## *
##  Sets the statement's consistency level.
## 
##  <b>Default:</b> CASS_CONSISTENCY_LOCAL_ONE
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] consistency
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_set_consistency*(statement: ptr CassStatement;
                                    consistency: CassConsistency): CassError
## *
##  Sets the statement's serial consistency level.
## 
##  @cassandra{2.0+}
## 
##  <b>Default:</b> Not set
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] serial_consistency
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_set_serial_consistency*(statement: ptr CassStatement;
    serial_consistency: CassConsistency): CassError
## *
##  Sets the statement's page size.
## 
##  @cassandra{2.0+}
## 
##  <b>Default:</b> -1 (Disabled)
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] page_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_set_paging_size*(statement: ptr CassStatement; page_size: cint): CassError
## *
##  Sets the statement's paging state. This can be used to get the next page of
##  data in a multi-page query.
## 
##  @cassandra{2.0+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] result
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_set_paging_state*(statement: ptr CassStatement;
                                     result: ptr CassResult): CassError
## *
##  Sets the statement's paging state. This can be used to get the next page of
##  data in a multi-page query.
## 
##  @cassandra{2.0+}
## 
##  <b>Warning:</b> The paging state should not be exposed to or come from
##  untrusted environments. The paging state could be spoofed and potentially
##  used to gain access to other data.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] paging_state
##  @param[in] paging_state_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 
##  @see cass_result_paging_state_token()
## 

proc cass_statement_set_paging_state_token*(statement: ptr CassStatement;
    paging_state: cstring; paging_state_size: csize): CassError
## *
##  Sets the statement's timestamp.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] timestamp
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_set_timestamp*(statement: ptr CassStatement; timestamp: int64): CassError
## *
##  Sets the statement's timeout for waiting for a response from a node.
## 
##  <b>Default:</b> Disabled (use the cluster-level request timeout)
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] timeout_ms Request timeout in milliseconds. Use 0 for no timeout
##  or CASS_UINT64_MAX to disable (to use the cluster-level request timeout).
##  @return CASS_OK if successful, otherwise an error occurred.
## 
##  @see cass_cluster_set_request_timeout()
## 

proc cass_statement_set_request_timeout*(statement: ptr CassStatement;
                                        timeout_ms: uint64): CassError
## *
##  Sets whether the statement is idempotent. Idempotent statements are able to be
##  automatically retried after timeouts/errors and can be speculatively executed.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] is_idempotent
##  @return CASS_OK if successful, otherwise an error occurred.
## 
##  @see cass_cluster_set_constant_speculative_execution_policy()
## 

proc cass_statement_set_is_idempotent*(statement: ptr CassStatement;
                                      is_idempotent: cass_bool_t): CassError
## *
##  Sets the statement's retry policy.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] retry_policy
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_set_retry_policy*(statement: ptr CassStatement;
                                     retry_policy: ptr CassRetryPolicy): CassError
## *
##  Sets the statement's custom payload.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] payload
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_set_custom_payload*(statement: ptr CassStatement;
                                       payload: ptr CassCustomPayload): CassError
## *
##  Binds null to a query or bound statement at the specified index.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_null*(statement: ptr CassStatement; index: csize): CassError
## *
##  Binds a null to all the values with the specified name.
## 
##  This can only be used with statements created by
##  cass_prepared_bind() when using Cassandra 2.0 or earlier.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_null_by_name*(statement: ptr CassStatement; name: cstring): CassError
## *
##  Same as cass_statement_bind_null_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @return same as cass_statement_bind_null_by_name()
## 
##  @see cass_statement_bind_null_by_name()
## 

proc cass_statement_bind_null_by_name_n*(statement: ptr CassStatement;
                                        name: cstring; name_length: csize): CassError
## *
##  Binds a "tinyint" to a query or bound statement at the specified index.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_int8*(statement: ptr CassStatement; index: csize; value: int8): CassError
## *
##  Binds a "tinyint" to all the values with the specified name.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_int8_by_name*(statement: ptr CassStatement; name: cstring;
                                      value: int8): CassError
## *
##  Same as cass_statement_bind_int8_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_statement_bind_int8_by_name()
## 
##  @see cass_statement_bind_int8_by_name()
## 

proc cass_statement_bind_int8_by_name_n*(statement: ptr CassStatement;
                                        name: cstring; name_length: csize;
                                        value: int8): CassError
## *
##  Binds an "smallint" to a query or bound statement at the specified index.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_int16*(statement: ptr CassStatement; index: csize;
                               value: int16): CassError
## *
##  Binds an "smallint" to all the values with the specified name.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_int16_by_name*(statement: ptr CassStatement; name: cstring;
                                       value: int16): CassError
## *
##  Same as cass_statement_bind_int16_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_statement_bind_int16_by_name()
## 
##  @see cass_statement_bind_int16_by_name()
## 

proc cass_statement_bind_int16_by_name_n*(statement: ptr CassStatement;
    name: cstring; name_length: csize; value: int16): CassError
## *
##  Binds an "int" to a query or bound statement at the specified index.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_int32*(statement: ptr CassStatement; index: csize;
                               value: int32): CassError
## *
##  Binds an "int" to all the values with the specified name.
## 
##  This can only be used with statements created by
##  cass_prepared_bind() when using Cassandra 2.0 or earlier.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_int32_by_name*(statement: ptr CassStatement; name: cstring;
                                       value: int32): CassError
## *
##  Same as cass_statement_bind_int32_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_statement_bind_int32_by_name()
## 
##  @see cass_statement_bind_int32_by_name()
## 

proc cass_statement_bind_int32_by_name_n*(statement: ptr CassStatement;
    name: cstring; name_length: csize; value: int32): CassError
## *
##  Binds a "date" to a query or bound statement at the specified index.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_uint32*(statement: ptr CassStatement; index: csize;
                                value: uint32): CassError
## *
##  Binds a "date" to all the values with the specified name.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_uint32_by_name*(statement: ptr CassStatement;
                                        name: cstring; value: uint32): CassError
## *
##  Same as cass_statement_bind_uint32_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_statement_bind_uint32_by_name()
## 
##  @see cass_statement_bind_uint32_by_name()
## 

proc cass_statement_bind_uint32_by_name_n*(statement: ptr CassStatement;
    name: cstring; name_length: csize; value: uint32): CassError
## *
##  Binds a "bigint", "counter", "timestamp" or "time" to a query or
##  bound statement at the specified index.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_int64*(statement: ptr CassStatement; index: csize;
                               value: int64): CassError
## *
##  Binds a "bigint", "counter", "timestamp" or "time" to all values
##  with the specified name.
## 
##  This can only be used with statements created by
##  cass_prepared_bind() when using Cassandra 2.0 or earlier.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_int64_by_name*(statement: ptr CassStatement; name: cstring;
                                       value: int64): CassError
## *
##  Same as cass_statement_bind_int64_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_statement_bind_int64_by_name(0
## 
##  @see cass_statement_bind_int64_by_name()
## 

proc cass_statement_bind_int64_by_name_n*(statement: ptr CassStatement;
    name: cstring; name_length: csize; value: int64): CassError
## *
##  Binds a "float" to a query or bound statement at the specified index.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_float*(statement: ptr CassStatement; index: csize;
                               value: cass_float_t): CassError
## *
##  Binds a "float" to all the values with the specified name.
## 
##  This can only be used with statements created by
##  cass_prepared_bind() when using Cassandra 2.0 or earlier.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_float_by_name*(statement: ptr CassStatement; name: cstring;
                                       value: cass_float_t): CassError
## *
##  Same as cass_statement_bind_float_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_statement_bind_float_by_name()
## 
##  @see cass_statement_bind_float_by_name()
## 

proc cass_statement_bind_float_by_name_n*(statement: ptr CassStatement;
    name: cstring; name_length: csize; value: cass_float_t): CassError
## *
##  Binds a "double" to a query or bound statement at the specified index.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_double*(statement: ptr CassStatement; index: csize;
                                value: cass_double_t): CassError
## *
##  Binds a "double" to all the values with the specified name.
## 
##  This can only be used with statements created by
##  cass_prepared_bind() when using Cassandra 2.0 or earlier.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_double_by_name*(statement: ptr CassStatement;
                                        name: cstring; value: cass_double_t): CassError
## *
##  Same as cass_statement_bind_double_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_statement_bind_double_by_name()
## 
##  @see cass_statement_bind_double_by_name()
## 

proc cass_statement_bind_double_by_name_n*(statement: ptr CassStatement;
    name: cstring; name_length: csize; value: cass_double_t): CassError
## *
##  Binds a "boolean" to a query or bound statement at the specified index.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_bool*(statement: ptr CassStatement; index: csize;
                              value: cass_bool_t): CassError
## *
##  Binds a "boolean" to all the values with the specified name.
## 
##  This can only be used with statements created by
##  cass_prepared_bind() when using Cassandra 2.0 or earlier.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_bool_by_name*(statement: ptr CassStatement; name: cstring;
                                      value: cass_bool_t): CassError
## *
##  Same as cass_statement_bind_bool_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_statement_bind_bool_by_name()
## 
##  @see cass_statement_bind_bool_by_name()
## 

proc cass_statement_bind_bool_by_name_n*(statement: ptr CassStatement;
                                        name: cstring; name_length: csize;
                                        value: cass_bool_t): CassError
## *
##  Binds an "ascii", "text" or "varchar" to a query or bound statement
##  at the specified index.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] value The value is copied into the statement object; the
##  memory pointed to by this parameter can be freed after this call.
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_string*(statement: ptr CassStatement; index: csize;
                                value: cstring): CassError
## *
##  Same as cass_statement_bind_string(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] value
##  @param[in] value_length
##  @return same as cass_statement_bind_string()
## 
##  @see cass_statement_bind_string()
## 

proc cass_statement_bind_string_n*(statement: ptr CassStatement; index: csize;
                                  value: cstring; value_length: csize): CassError
## *
##  Binds an "ascii", "text" or "varchar" to all the values
##  with the specified name.
## 
##  This can only be used with statements created by
##  cass_prepared_bind() when using Cassandra 2.0 or earlier.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] value The value is copied into the statement object; the
##  memory pointed to by this parameter can be freed after this call.
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_string_by_name*(statement: ptr CassStatement;
                                        name: cstring; value: cstring): CassError
## *
##  Same as cass_statement_bind_string_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @param[in] value_length
##  @return same as cass_statement_bind_string_by_name()
## 
##  @see cass_statement_bind_string_by_name()
## 

proc cass_statement_bind_string_by_name_n*(statement: ptr CassStatement;
    name: cstring; name_length: csize; value: cstring; value_length: csize): CassError
## *
##  Binds a "blob", "varint" or "custom" to a query or bound statement at the specified index.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] value The value is copied into the statement object; the
##  memory pointed to by this parameter can be freed after this call.
##  @param[in] value_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_bytes*(statement: ptr CassStatement; index: csize;
                               value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Binds a "blob", "varint" or "custom" to all the values with the
##  specified name.
## 
##  This can only be used with statements created by
##  cass_prepared_bind() when using Cassandra 2.0 or earlier.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] value The value is copied into the statement object; the
##  memory pointed to by this parameter can be freed after this call.
##  @param[in] value_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_bytes_by_name*(statement: ptr CassStatement; name: cstring;
                                       value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Same as cass_statement_bind_bytes_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @param[in] value_size
##  @return same as cass_statement_bind_bytes_by_name()
## 
##  @see cass_statement_bind_bytes_by_name()
## 

proc cass_statement_bind_bytes_by_name_n*(statement: ptr CassStatement;
    name: cstring; name_length: csize; value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Binds a "custom" to a query or bound statement at the specified index.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] class_name
##  @param[in] value The value is copied into the statement object; the
##  memory pointed to by this parameter can be freed after this call.
##  @param[in] value_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_custom*(statement: ptr CassStatement; index: csize;
                                class_name: cstring; value: ptr cass_byte_t;
                                value_size: csize): CassError
## *
##  Same as cass_statement_bind_custom(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] class_name
##  @param[in] class_name_length
##  @param[in] value The value is copied into the statement object; the
##  memory pointed to by this parameter can be freed after this call.
##  @param[in] value_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_custom_n*(statement: ptr CassStatement; index: csize;
                                  class_name: cstring; class_name_length: csize;
                                  value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Binds a "custom" to all the values with the specified name.
## 
##  This can only be used with statements created by
##  cass_prepared_bind() when using Cassandra 2.0 or earlier.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] class_name
##  @param[in] value The value is copied into the statement object; the
##  memory pointed to by this parameter can be freed after this call.
##  @param[in] value_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_custom_by_name*(statement: ptr CassStatement;
                                        name: cstring; class_name: cstring;
                                        value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Same as cass_statement_bind_custom_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] class_name
##  @param[in] class_name_length
##  @param[in] value
##  @param[in] value_size
##  @return same as cass_statement_bind_custom_by_name()
## 
##  @see cass_statement_bind_custom_by_name()
## 

proc cass_statement_bind_custom_by_name_n*(statement: ptr CassStatement;
    name: cstring; name_length: csize; class_name: cstring; class_name_length: csize;
    value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Binds a "uuid" or "timeuuid" to a query or bound statement at the specified index.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_uuid*(statement: ptr CassStatement; index: csize;
                              value: CassUuid): CassError
## *
##  Binds a "uuid" or "timeuuid" to all the values
##  with the specified name.
## 
##  This can only be used with statements created by
##  cass_prepared_bind() when using Cassandra 2.0 or earlier.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_uuid_by_name*(statement: ptr CassStatement; name: cstring;
                                      value: CassUuid): CassError
## *
##  Same as cass_statement_bind_uuid_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_statement_bind_uuid_by_name()
## 
##  @see cass_statement_bind_uuid_by_name()
## 

proc cass_statement_bind_uuid_by_name_n*(statement: ptr CassStatement;
                                        name: cstring; name_length: csize;
                                        value: CassUuid): CassError
## *
##  Binds an "inet" to a query or bound statement at the specified index.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_inet*(statement: ptr CassStatement; index: csize;
                              value: CassInet): CassError
## *
##  Binds an "inet" to all the values with the specified name.
## 
##  This can only be used with statements created by
##  cass_prepared_bind() when using Cassandra 2.0 or earlier.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_inet_by_name*(statement: ptr CassStatement; name: cstring;
                                      value: CassInet): CassError
## *
##  Same as cass_statement_bind_inet_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_statement_bind_inet_by_name()
## 
##  @see cass_statement_bind_inet_by_name()
## 

proc cass_statement_bind_inet_by_name_n*(statement: ptr CassStatement;
                                        name: cstring; name_length: csize;
                                        value: CassInet): CassError
## *
##  Bind a "decimal" to a query or bound statement at the specified index.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] varint The value is copied into the statement object; the
##  memory pointed to by this parameter can be freed after this call.
##  @param[in] varint_size
##  @param[in] scale
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_decimal*(statement: ptr CassStatement; index: csize;
                                 varint: ptr cass_byte_t; varint_size: csize;
                                 scale: int32): CassError
## *
##  Binds a "decimal" to all the values with the specified name.
## 
##  This can only be used with statements created by
##  cass_prepared_bind() when using Cassandra 2.0 or earlier.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] varint The value is copied into the statement object; the
##  memory pointed to by this parameter can be freed after this call.
##  @param[in] varint_size
##  @param[in] scale
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_decimal_by_name*(statement: ptr CassStatement;
    name: cstring; varint: ptr cass_byte_t; varint_size: csize; scale: int32): CassError
## *
##  Same as cass_statement_bind_decimal_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] varint
##  @param[in] varint_size
##  @param[in] scale
##  @return same as cass_statement_bind_decimal_by_name()
## 
##  @see cass_statement_bind_decimal_by_name()
## 

proc cass_statement_bind_decimal_by_name_n*(statement: ptr CassStatement;
    name: cstring; name_length: csize; varint: ptr cass_byte_t; varint_size: csize;
    scale: int32): CassError
## *
##  Binds a "duration" to a query or bound statement at the specified index.
## 
##  @cassandra{3.10+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] months
##  @param[in] days
##  @param[in] nanos
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_duration*(statement: ptr CassStatement; index: csize;
                                  months: int32; days: int32; nanos: int64): CassError
## *
##  Binds a "duration" to all the values with the specified name.
## 
##  @cassandra{3.10+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] months
##  @param[in] days
##  @param[in] nanos
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_duration_by_name*(statement: ptr CassStatement;
    name: cstring; months: int32; days: int32; nanos: int64): CassError
## *
##  Same as cass_statement_bind_duration_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{3.10+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] months
##  @param[in] days
##  @param[in] nanos
##  @return same as cass_statement_bind_duration_by_name()
## 
##  @see cass_statement_bind_duration_by_name()
## 

proc cass_statement_bind_duration_by_name_n*(statement: ptr CassStatement;
    name: cstring; name_length: csize; months: int32; days: int32; nanos: int64): CassError
## *
##  Bind a "list", "map" or "set" to a query or bound statement at the
##  specified index.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] collection The collection can be freed after this call.
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_collection*(statement: ptr CassStatement; index: csize;
                                    collection: ptr CassCollection): CassError
## *
##  Bind a "list", "map" or "set" to all the values with the
##  specified name.
## 
##  This can only be used with statements created by
##  cass_prepared_bind() when using Cassandra 2.0 or earlier.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] collection The collection can be freed after this call.
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_collection_by_name*(statement: ptr CassStatement;
    name: cstring; collection: ptr CassCollection): CassError
## *
##  Same as cass_statement_bind_collection_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] collection
##  @return same as cass_statement_bind_collection_by_name()
## 
##  @see cass_statement_bind_collection_by_name()
## 

proc cass_statement_bind_collection_by_name_n*(statement: ptr CassStatement;
    name: cstring; name_length: csize; collection: ptr CassCollection): CassError
## *
##  Bind a "tuple" to a query or bound statement at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] tuple The tuple can be freed after this call.
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_tuple*(statement: ptr CassStatement; index: csize;
                               `tuple`: ptr CassTuple): CassError
## *
##  Bind a "tuple" to all the values with the specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] tuple The tuple can be freed after this call.
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_tuple_by_name*(statement: ptr CassStatement; name: cstring;
                                       `tuple`: ptr CassTuple): CassError
## *
##  Same as cass_statement_bind_tuple_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] tuple
##  @return same as cass_statement_bind_tuple_by_name()
## 
##  @see cass_statement_bind_tuple_by_name()
## 

proc cass_statement_bind_tuple_by_name_n*(statement: ptr CassStatement;
    name: cstring; name_length: csize; `tuple`: ptr CassTuple): CassError
## *
##  Bind a user defined type to a query or bound statement at the
##  specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] index
##  @param[in] user_type The user type can be freed after this call.
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_user_type*(statement: ptr CassStatement; index: csize;
                                   user_type: ptr CassUserType): CassError
## *
##  Bind a user defined type to a query or bound statement with the
##  specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] user_type The user type can be freed after this call.
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_statement_bind_user_type_by_name*(statement: ptr CassStatement;
    name: cstring; user_type: ptr CassUserType): CassError
## *
##  Same as cass_statement_bind_user_type_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassStatement
## 
##  @param[in] statement
##  @param[in] name
##  @param[in] name_length
##  @param[in] user_type
##  @return same as cass_statement_bind_user_type_by_name()
## 
##  @see cass_statement_bind_collection_by_name()
## 

proc cass_statement_bind_user_type_by_name_n*(statement: ptr CassStatement;
    name: cstring; name_length: csize; user_type: ptr CassUserType): CassError
## **********************************************************************************
## 
##  Prepared
## 
## *********************************************************************************
## *
##  Frees a prepared instance.
## 
##  @public @memberof CassPrepared
## 
##  @param[in] prepared
## 

proc cass_prepared_free*(prepared: ptr CassPrepared)
## *
##  Creates a bound statement from a pre-prepared statement.
## 
##  @public @memberof CassPrepared
## 
##  @param[in] prepared
##  @return Returns a bound statement that must be freed.
## 
##  @see cass_statement_free()
## 

proc cass_prepared_bind*(prepared: ptr CassPrepared): ptr CassStatement
## *
##  Gets the name of a parameter at the specified index.
## 
##  @public @memberof CassPrepared
## 
##  @param[in] prepared
##  @param[in] index
##  @param[out] name
##  @param[out] name_length
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_prepared_parameter_name*(prepared: ptr CassPrepared; index: csize;
                                  name: cstringArray; name_length: ptr csize): CassError
## *
##  Gets the data type of a parameter at the specified index.
## 
##  @public @memberof CassPrepared
## 
##  @param[in] prepared
##  @param[in] index
##  @return Returns a reference to the data type of the parameter. Do not free
##  this reference as it is bound to the lifetime of the prepared.
## 

proc cass_prepared_parameter_data_type*(prepared: ptr CassPrepared; index: csize): ptr CassDataType
## *
##  Gets the data type of a parameter for the specified name.
## 
##  @public @memberof CassPrepared
## 
##  @param[in] prepared
##  @param[in] name
##  @return Returns a reference to the data type of the parameter. Do not free
##  this reference as it is bound to the lifetime of the prepared.
## 

proc cass_prepared_parameter_data_type_by_name*(prepared: ptr CassPrepared;
    name: cstring): ptr CassDataType
## *
##  Same as cass_prepared_parameter_data_type_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassPrepared
## 
##  @param[in] prepared
##  @param[in] name
##  @param[in] name_length
##  @return Returns a reference to the data type of the parameter. Do not free
##  this reference as it is bound to the lifetime of the prepared.
## 
##  @see cass_prepared_parameter_data_type_by_name()
## 

proc cass_prepared_parameter_data_type_by_name_n*(prepared: ptr CassPrepared;
    name: cstring; name_length: csize): ptr CassDataType
## **********************************************************************************
## 
##  Batch
## 
## *********************************************************************************
## *
##  Creates a new batch statement with batch type.
## 
##  @cassandra{2.0+}
## 
##  @public @memberof CassBatch
## 
##  @param[in] type
##  @return Returns a batch statement that must be freed.
## 
##  @see cass_batch_free()
## 

proc cass_batch_new*(`type`: CassBatchType): ptr CassBatch
## *
##  Frees a batch instance. Batches can be immediately freed after being
##  executed.
## 
##  @cassandra{2.0+}
## 
##  @public @memberof CassBatch
## 
##  @param[in] batch
## 

proc cass_batch_free*(batch: ptr CassBatch)
## *
##  Sets the batch's consistency level
## 
##  @cassandra{2.0+}
## 
##  @public @memberof CassBatch
## 
##  @param[in] batch
##  @param[in] consistency The batch's write consistency.
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_batch_set_consistency*(batch: ptr CassBatch; consistency: CassConsistency): CassError
## *
##  Sets the batch's serial consistency level.
## 
##  @cassandra{2.0+}
## 
##  <b>Default:</b> Not set
## 
##  @public @memberof CassBatch
## 
##  @param[in] batch
##  @param[in] serial_consistency
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_batch_set_serial_consistency*(batch: ptr CassBatch;
                                       serial_consistency: CassConsistency): CassError
## *
##  Sets the batch's timestamp.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassBatch
## 
##  @param[in] batch
##  @param[in] timestamp
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_batch_set_timestamp*(batch: ptr CassBatch; timestamp: int64): CassError
## *
##  Sets the batch's timeout for waiting for a response from a node.
## 
##  <b>Default:</b> Disabled (use the cluster-level request timeout)
## 
##  @public @memberof CassBatch
## 
##  @param[in] batch
##  @param[in] timeout_ms Request timeout in milliseconds. Use 0 for no timeout
##  or CASS_UINT64_MAX to disable (to use the cluster-level request timeout).
##  @return CASS_OK if successful, otherwise an error occurred.
## 
##  @see cass_cluster_set_request_timeout()
## 

proc cass_batch_set_request_timeout*(batch: ptr CassBatch; timeout_ms: uint64): CassError
## *
##  Sets whether the statements in a batch are idempotent. Idempotent batches
##  are able to be automatically retried after timeouts/errors and can be
##  speculatively executed.
## 
##  @public @memberof CassBatch
## 
##  @param[in] batch
##  @param[in] is_idempotent
##  @return CASS_OK if successful, otherwise an error occurred.
## 
##  @see cass_cluster_set_constant_speculative_execution_policy()
## 

proc cass_batch_set_is_idempotent*(batch: ptr CassBatch; is_idempotent: cass_bool_t): CassError
## *
##  Sets the batch's retry policy.
## 
##  @cassandra{2.0+}
## 
##  @public @memberof CassBatch
## 
##  @param[in] batch
##  @param[in] retry_policy
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_batch_set_retry_policy*(batch: ptr CassBatch;
                                 retry_policy: ptr CassRetryPolicy): CassError
## *
##  Sets the batch's custom payload.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassBatch
## 
##  @param[in] batch
##  @param[in] payload
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_batch_set_custom_payload*(batch: ptr CassBatch;
                                   payload: ptr CassCustomPayload): CassError
## *
##  Adds a statement to a batch.
## 
##  @cassandra{2.0+}
## 
##  @public @memberof CassBatch
## 
##  @param[in] batch
##  @param[in] statement
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_batch_add_statement*(batch: ptr CassBatch; statement: ptr CassStatement): CassError
## **********************************************************************************
## 
##  Data type
## 
## *********************************************************************************
## *
##  Creates a new data type with value type.
## 
##  @public @memberof CassDataType
## 
##  @param[in] type
##  @return Returns a data type that must be freed.
## 
##  @see cass_data_type_free()
## 

proc cass_data_type_new*(`type`: CassValueType): ptr CassDataType
## *
##  Creates a new data type from an existing data type.
## 
##  @public @memberof CassDataType
## 
##  @param[in] data_type
##  @return Returns a data type that must be freed.
## 
##  @see cass_data_type_free()
## 

proc cass_data_type_new_from_existing*(data_type: ptr CassDataType): ptr CassDataType
## *
##  Creates a new tuple data type.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassDataType
## 
##  @param[in] item_count The number of items in the tuple
##  @return Returns a data type that must be freed.
## 
##  @see cass_data_type_free()
## 

proc cass_data_type_new_tuple*(item_count: csize): ptr CassDataType
## *
##  Creates a new UDT (user defined type) data type.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassDataType
## 
##  @param[in] field_count The number of fields in the UDT
##  @return Returns a data type that must be freed.
## 
##  @see cass_data_type_free()
## 

proc cass_data_type_new_udt*(field_count: csize): ptr CassDataType
## *
##  Frees a data type instance.
## 
##  @public @memberof CassDataType
## 
##  @param[in] data_type
## 

proc cass_data_type_free*(data_type: ptr CassDataType)
## *
##  Gets the value type of the specified data type.
## 
##  @param[in] data_type
##  @return The value type
## 

proc cass_data_type_type*(data_type: ptr CassDataType): CassValueType
## *
##  Gets whether a data type is frozen.
## 
##  @cassandra{2.1+}
## 
##  @param[in] data_type
##  @return cass_true if the data type is frozen, otherwise cass_false.
## 

proc cass_data_type_is_frozen*(data_type: ptr CassDataType): cass_bool_t
## *
##  Gets the type name of a UDT data type.
## 
##  <b>Note:</b> Only valid for UDT data types.
## 
##  @param[in] data_type
##  @param[out] type_name
##  @param[out] type_name_length
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_data_type_type_name*(data_type: ptr CassDataType; type_name: cstringArray;
                              type_name_length: ptr csize): CassError
## *
##  Sets the type name of a UDT data type.
## 
##  <b>Note:</b> Only valid for UDT data types.
## 
##  @param[in] data_type
##  @param[in] type_name
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_data_type_set_type_name*(data_type: ptr CassDataType; type_name: cstring): CassError
## *
##  Same as cass_data_type_set_type_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassDataType
## 
##  @param[in] data_type
##  @param[in] type_name
##  @param[in] type_name_length
##  @return Returns a data type that must be freed.
## 

proc cass_data_type_set_type_name_n*(data_type: ptr CassDataType;
                                    type_name: cstring; type_name_length: csize): CassError
## *
##  Gets the type name of a UDT data type.
## 
##  <b>Note:</b> Only valid for UDT data types.
## 
##  @cassandra{2.1+}
## 
##  @param[in] data_type
##  @param[out] keyspace
##  @param[out] keyspace_length
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_data_type_keyspace*(data_type: ptr CassDataType; keyspace: cstringArray;
                             keyspace_length: ptr csize): CassError
## *
##  Sets the keyspace of a UDT data type.
## 
##  <b>Note:</b> Only valid for UDT data types.
## 
##  @cassandra{2.1+}
## 
##  @param[in] data_type
##  @param[in] keyspace
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_data_type_set_keyspace*(data_type: ptr CassDataType; keyspace: cstring): CassError
## *
##  Same as cass_data_type_set_keyspace(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassDataType
## 
##  @param[in] data_type
##  @param[in] keyspace
##  @param[in] keyspace_length
##  @return Returns a data type that must be freed.
## 

proc cass_data_type_set_keyspace_n*(data_type: ptr CassDataType; keyspace: cstring;
                                   keyspace_length: csize): CassError
## *
##  Gets the class name of a custom data type.
## 
##  <b>Note:</b> Only valid for custom data types.
## 
##  @param[in] data_type
##  @param[out] class_name
##  @param[out] class_name_length
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_data_type_class_name*(data_type: ptr CassDataType;
                               class_name: cstringArray;
                               class_name_length: ptr csize): CassError
## *
##  Sets the class name of a custom data type.
## 
##  <b>Note:</b> Only valid for custom data types.
## 
##  @param[in] data_type
##  @param[in] class_name
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_data_type_set_class_name*(data_type: ptr CassDataType; class_name: cstring): CassError
## *
##  Same as cass_data_type_set_class_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassDataType
## 
##  @param[in] data_type
##  @param[in] class_name
##  @param[in] class_name_length
##  @return Returns a data type that must be freed.
## 

proc cass_data_type_set_class_name_n*(data_type: ptr CassDataType;
                                     class_name: cstring; class_name_length: csize): CassError
## *
##  Gets the sub-data type count of a UDT (user defined type), tuple
##  or collection.
## 
##  <b>Note:</b> Only valid for UDT, tuple and collection data types.
## 
##  @param[in] data_type
##  @return Returns the number of sub-data types
## 

proc cass_data_type_sub_type_count*(data_type: ptr CassDataType): csize
## *
##  @deprecated Use cass_data_type_sub_type_count()
## 

proc cass_data_sub_type_count*(data_type: ptr CassDataType): csize
## *
##  Gets the sub-data type count of a UDT (user defined type), tuple
##  or collection.
## 
##  <b>Note:</b> Only valid for UDT, tuple and collection data types.
## 
##  @param[in] data_type
##  @return Returns the number of sub-data types
## 
## *
##  Gets the sub-data type of a UDT (user defined type), tuple or collection at
##  the specified index.
## 
##  <b>Note:</b> Only valid for UDT, tuple and collection data types.
## 
##  @param[in] data_type
##  @param[in] index
##  @return Returns a reference to a child data type. Do not free this
##  reference as it is bound to the lifetime of the parent data type. NULL
##  is returned if the index is out of range.
## 

proc cass_data_type_sub_data_type*(data_type: ptr CassDataType; index: csize): ptr CassDataType
## *
##  Gets the sub-data type of a UDT (user defined type) at the specified index.
## 
##  <b>Note:</b> Only valid for UDT data types.
## 
##  @cassandra{2.1+}
## 
##  @param[in] data_type
##  @param[in] name
##  @return Returns a reference to a child data type. Do not free this
##  reference as it is bound to the lifetime of the parent data type. NULL
##  is returned if the name doesn't exist.
## 

proc cass_data_type_sub_data_type_by_name*(data_type: ptr CassDataType;
    name: cstring): ptr CassDataType
## *
##  Same as cass_data_type_sub_data_type_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassDataType
## 
##  @param[in] data_type
##  @param[in] name
##  @param[in] name_length
##  @return Returns a reference to a child data type. Do not free this
##  reference as it is bound to the lifetime of the parent data type. NULL
##  is returned if the name doesn't exist.
## 

proc cass_data_type_sub_data_type_by_name_n*(data_type: ptr CassDataType;
    name: cstring; name_length: csize): ptr CassDataType
## *
##  Gets the sub-type name of a UDT (user defined type) at the specified index.
## 
##  @cassandra{2.1+}
## 
##  <b>Note:</b> Only valid for UDT data types.
## 
##  @param[in] data_type
##  @param[in] index
##  @param[out] name
##  @param[out] name_length
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_data_type_sub_type_name*(data_type: ptr CassDataType; index: csize;
                                  name: cstringArray; name_length: ptr csize): CassError
## *
##  Adds a sub-data type to a tuple or collection.
## 
##  <b>Note:</b> Only valid for tuple and collection data types.
## 
##  @param[in] data_type
##  @param[in] sub_data_type
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_data_type_add_sub_type*(data_type: ptr CassDataType;
                                 sub_data_type: ptr CassDataType): CassError
## *
##  Adds a sub-data type to a UDT (user defined type).
## 
##  <b>Note:</b> Only valid for UDT data types.
## 
##  @cassandra{2.1+}
## 
##  @param[in] data_type
##  @param[in] name
##  @param[in] sub_data_type
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_data_type_add_sub_type_by_name*(data_type: ptr CassDataType;
    name: cstring; sub_data_type: ptr CassDataType): CassError
## *
##  Same as cass_data_type_add_sub_type_by_name(), but with lengths for string
##  parameters.
## 
##  <b>Note:</b> Only valid for UDT data types.
## 
##  @cassandra{2.1+}
## 
##  @param[in] data_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] sub_data_type
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_data_type_add_sub_type_by_name_n*(data_type: ptr CassDataType;
    name: cstring; name_length: csize; sub_data_type: ptr CassDataType): CassError
## *
##  Adds a sub-data type to a tuple or collection using a value type.
## 
##  <b>Note:</b> Only valid for tuple and collection data types.
## 
##  @param[in] data_type
##  @param[in] sub_value_type
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_data_type_add_sub_value_type*(data_type: ptr CassDataType;
                                       sub_value_type: CassValueType): CassError
## *
##  Adds a sub-data type to a UDT (user defined type) using a value type.
## 
##  <b>Note:</b> Only valid for UDT data types.
## 
##  @cassandra{2.1+}
## 
##  @param[in] data_type
##  @param[in] name
##  @param[in] sub_value_type
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_data_type_add_sub_value_type_by_name*(data_type: ptr CassDataType;
    name: cstring; sub_value_type: CassValueType): CassError
## *
##  Same as cass_data_type_add_sub_value_type_by_name(), but with lengths for string
##  parameters.
## 
##  <b>Note:</b> Only valid for UDT data types.
## 
##  @cassandra{2.1+}
## 
##  @param[in] data_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] sub_value_type
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_data_type_add_sub_value_type_by_name_n*(data_type: ptr CassDataType;
    name: cstring; name_length: csize; sub_value_type: CassValueType): CassError
## **********************************************************************************
## 
##  Collection
## 
## *********************************************************************************
## *
##  Creates a new collection.
## 
##  @public @memberof CassCollection
## 
##  @param[in] type
##  @param[in] item_count The approximate number of items in the collection.
##  @return Returns a collection that must be freed.
## 
##  @see cass_collection_free()
## 

proc cass_collection_new*(`type`: CassCollectionType; item_count: csize): ptr CassCollection
## *
##  Creates a new collection from an existing data type.
## 
##  @public @memberof CassCollection
## 
##  @param[in] data_type
##  @param[in] item_count The approximate number of items in the collection.
##  @return Returns a collection that must be freed.
## 
##  @see cass_collection_free();
## 

proc cass_collection_new_from_data_type*(data_type: ptr CassDataType;
                                        item_count: csize): ptr CassCollection
## *
##  Frees a collection instance.
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
## 

proc cass_collection_free*(collection: ptr CassCollection)
## *
##  Gets the data type of a collection.
## 
##  @param[in] collection
##  @return Returns a reference to the data type of the collection. Do not free
##  this reference as it is bound to the lifetime of the collection.
## 

proc cass_collection_data_type*(collection: ptr CassCollection): ptr CassDataType
## *
##  Appends a "tinyint" to the collection.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_int8*(collection: ptr CassCollection; value: int8): CassError
## *
##  Appends an "smallint" to the collection.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_int16*(collection: ptr CassCollection; value: int16): CassError
## *
##  Appends an "int" to the collection.
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_int32*(collection: ptr CassCollection; value: int32): CassError
## *
##  Appends a "date" to the collection.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_uint32*(collection: ptr CassCollection; value: uint32): CassError
## *
##  Appends a "bigint", "counter", "timestamp" or "time" to the
##  collection.
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_int64*(collection: ptr CassCollection; value: int64): CassError
## *
##  Appends a "float" to the collection.
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_float*(collection: ptr CassCollection;
                                  value: cass_float_t): CassError
## *
##  Appends a "double" to the collection.
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_double*(collection: ptr CassCollection;
                                   value: cass_double_t): CassError
## *
##  Appends a "boolean" to the collection.
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_bool*(collection: ptr CassCollection; value: cass_bool_t): CassError
## *
##  Appends an "ascii", "text" or "varchar" to the collection.
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value The value is copied into the collection object; the
##  memory pointed to by this parameter can be freed after this call.
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_string*(collection: ptr CassCollection; value: cstring): CassError
## *
##  Same as cass_collection_append_string(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value
##  @param[in] value_length
##  @return same as cass_collection_append_string()
## 
##  @see cass_collection_append_string();
## 

proc cass_collection_append_string_n*(collection: ptr CassCollection;
                                     value: cstring; value_length: csize): CassError
## *
##  Appends a "blob", "varint" or "custom" to the collection.
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value The value is copied into the collection object; the
##  memory pointed to by this parameter can be freed after this call.
##  @param[in] value_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_bytes*(collection: ptr CassCollection;
                                  value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Appends a "custom" to the collection.
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] class_name
##  @param[in] value The value is copied into the collection object; the
##  memory pointed to by this parameter can be freed after this call.
##  @param[in] value_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_custom*(collection: ptr CassCollection;
                                   class_name: cstring; value: ptr cass_byte_t;
                                   value_size: csize): CassError
## *
##  Same as cass_collection_append_custom(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] class_name
##  @param[in] class_name_length
##  @param[in] value
##  @param[in] value_size
##  @return same as cass_collection_append_custom()
## 
##  @see cass_collection_append_custom()
## 

proc cass_collection_append_custom_n*(collection: ptr CassCollection;
                                     class_name: cstring;
                                     class_name_length: csize;
                                     value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Appends a "uuid" or "timeuuid"  to the collection.
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_uuid*(collection: ptr CassCollection; value: CassUuid): CassError
## *
##  Appends an "inet" to the collection.
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_inet*(collection: ptr CassCollection; value: CassInet): CassError
## *
##  Appends a "decimal" to the collection.
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] varint The value is copied into the collection object; the
##  memory pointed to by this parameter can be freed after this call.
##  @param[in] varint_size
##  @param[in] scale
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_decimal*(collection: ptr CassCollection;
                                    varint: ptr cass_byte_t; varint_size: csize;
                                    scale: int32): CassError
## *
##  Appends a "duration" to the collection.
## 
##  @cassandra{3.10+}
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] months
##  @param[in] days
##  @param[in] nanos
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_duration*(collection: ptr CassCollection; months: int32;
                                     days: int32; nanos: int64): CassError
## *
##  Appends a "list", "map" or "set" to the collection.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_collection*(collection: ptr CassCollection;
                                       value: ptr CassCollection): CassError
## *
##  Appends a "tuple" to the collection.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_tuple*(collection: ptr CassCollection;
                                  value: ptr CassTuple): CassError
## *
##  Appends a "udt" to the collection.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassCollection
## 
##  @param[in] collection
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_collection_append_user_type*(collection: ptr CassCollection;
                                      value: ptr CassUserType): CassError
## **********************************************************************************
## 
##  Tuple
## 
## *********************************************************************************
## *
##  Creates a new tuple.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] item_count The number of items in the tuple.
##  @return Returns a tuple that must be freed.
## 
##  @see cass_tuple_free()
## 

proc cass_tuple_new*(item_count: csize): ptr CassTuple
## *
##  Creates a new tuple from an existing data type.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] data_type
##  @return Returns a tuple that must be freed.
## 
##  @see cass_tuple_free();
## 

proc cass_tuple_new_from_data_type*(data_type: ptr CassDataType): ptr CassTuple
## *
##  Frees a tuple instance.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
## 

proc cass_tuple_free*(`tuple`: ptr CassTuple)
## *
##  Gets the data type of a tuple.
## 
##  @cassandra{2.1+}
## 
##  @param[in] tuple
##  @return Returns a reference to the data type of the tuple. Do not free
##  this reference as it is bound to the lifetime of the tuple.
## 

proc cass_tuple_data_type*(`tuple`: ptr CassTuple): ptr CassDataType
## *
##  Sets an null in a tuple at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_null*(`tuple`: ptr CassTuple; index: csize): CassError
## *
##  Sets a "tinyint" in a tuple at the specified index.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_int8*(`tuple`: ptr CassTuple; index: csize; value: int8): CassError
## *
##  Sets an "smallint" in a tuple at the specified index.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_int16*(`tuple`: ptr CassTuple; index: csize; value: int16): CassError
## *
##  Sets an "int" in a tuple at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_int32*(`tuple`: ptr CassTuple; index: csize; value: int32): CassError
## *
##  Sets a "date" in a tuple at the specified index.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_uint32*(`tuple`: ptr CassTuple; index: csize; value: uint32): CassError
## *
##  Sets a "bigint", "counter", "timestamp" or "time" in a tuple at the
##  specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_int64*(`tuple`: ptr CassTuple; index: csize; value: int64): CassError
## *
##  Sets a "float" in a tuple at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_float*(`tuple`: ptr CassTuple; index: csize; value: cass_float_t): CassError
## *
##  Sets a "double" in a tuple at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_double*(`tuple`: ptr CassTuple; index: csize; value: cass_double_t): CassError
## *
##  Sets a "boolean" in a tuple at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_bool*(`tuple`: ptr CassTuple; index: csize; value: cass_bool_t): CassError
## *
##  Sets an "ascii", "text" or "varchar" in a tuple at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value The value is copied into the tuple object; the
##  memory pointed to by this parameter can be freed after this call.
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_string*(`tuple`: ptr CassTuple; index: csize; value: cstring): CassError
## *
##  Same as cass_tuple_set_string(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value
##  @param[in] value_length
##  @return same as cass_tuple_set_string()
## 
##  @see cass_tuple_set_string();
## 

proc cass_tuple_set_string_n*(`tuple`: ptr CassTuple; index: csize; value: cstring;
                             value_length: csize): CassError
## *
##  Sets a "blob", "varint" or "custom" in a tuple at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value The value is copied into the tuple object; the
##  memory pointed to by this parameter can be freed after this call.
##  @param[in] value_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_bytes*(`tuple`: ptr CassTuple; index: csize;
                          value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Sets a "custom" in a tuple at the specified index.
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] class_name
##  @param[in] value The value is copied into the tuple object; the
##  memory pointed to by this parameter can be freed after this call.
##  @param[in] value_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_custom*(`tuple`: ptr CassTuple; index: csize; class_name: cstring;
                           value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Same as cass_tuple_set_custom(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] class_name
##  @param[in] class_name_length
##  @param[in] value
##  @param[in] value_size
##  @return same as cass_tuple_set_custom()
## 
##  @see cass_tuple_set_custom()
## 

proc cass_tuple_set_custom_n*(`tuple`: ptr CassTuple; index: csize;
                             class_name: cstring; class_name_length: csize;
                             value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Sets a "uuid" or "timeuuid" in a tuple at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_uuid*(`tuple`: ptr CassTuple; index: csize; value: CassUuid): CassError
## *
##  Sets an "inet" in a tuple at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_inet*(`tuple`: ptr CassTuple; index: csize; value: CassInet): CassError
## *
##  Sets a "decimal" in a tuple at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] varint The value is copied into the tuple object; the
##  memory pointed to by this parameter can be freed after this call.
##  @param[in] varint_size
##  @param[in] scale
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_decimal*(`tuple`: ptr CassTuple; index: csize;
                            varint: ptr cass_byte_t; varint_size: csize; scale: int32): CassError
## *
##  Sets a "duration" in a tuple at the specified index.
## 
##  @cassandra{3.10+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] months
##  @param[in] days
##  @param[in] nanos
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_duration*(`tuple`: ptr CassTuple; index: csize; months: int32;
                             days: int32; nanos: int64): CassError
## *
##  Sets a "list", "map" or "set" in a tuple at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_collection*(`tuple`: ptr CassTuple; index: csize;
                               value: ptr CassCollection): CassError
## *
##  Sets a "tuple" in a tuple at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_tuple*(`tuple`: ptr CassTuple; index: csize; value: ptr CassTuple): CassError
## *
##  Sets a "udt" in a tuple at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTuple
## 
##  @param[in] tuple
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_tuple_set_user_type*(`tuple`: ptr CassTuple; index: csize;
                              value: ptr CassUserType): CassError
## **********************************************************************************
## 
##  User defined type
## 
## *********************************************************************************
## *
##  Creates a new user defined type from existing data type;
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] data_type
##  @return Returns a user defined type that must be freed. NULL is returned if
##  the data type is not a user defined type.
## 
##  @see cass_user_type_free()
## 

proc cass_user_type_new_from_data_type*(data_type: ptr CassDataType): ptr CassUserType
## *
##  Frees a user defined type instance.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
## 

proc cass_user_type_free*(user_type: ptr CassUserType)
## *
##  Gets the data type of a user defined type.
## 
##  @cassandra{2.1+}
## 
##  @param[in] user_type
##  @return Returns a reference to the data type of the user defined type.
##  Do not free this reference as it is bound to the lifetime of the
##  user defined type.
## 

proc cass_user_type_data_type*(user_type: ptr CassUserType): ptr CassDataType
## *
##  Sets a null in a user defined type at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_null*(user_type: ptr CassUserType; index: csize): CassError
## *
##  Sets a null in a user defined type at the specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_null_by_name*(user_type: ptr CassUserType; name: cstring): CassError
## *
##  Same as cass_user_type_set_null_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @return same as cass_user_type_set_null_by_name()
## 
##  @see cass_user_type_set_null_by_name()
## 

proc cass_user_type_set_null_by_name_n*(user_type: ptr CassUserType; name: cstring;
                                       name_length: csize): CassError
## *
##  Sets a "tinyint" in a user defined type at the specified index.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_int8*(user_type: ptr CassUserType; index: csize; value: int8): CassError
## *
##  Sets a "tinyint" in a user defined type at the specified name.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_int8_by_name*(user_type: ptr CassUserType; name: cstring;
                                     value: int8): CassError
## *
##  Same as cass_user_type_set_int8_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_user_type_set_int8_by_name()
## 
##  @see cass_user_type_set_int8_by_name()
## 

proc cass_user_type_set_int8_by_name_n*(user_type: ptr CassUserType; name: cstring;
                                       name_length: csize; value: int8): CassError
## *
##  Sets an "smallint" in a user defined type at the specified index.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_int16*(user_type: ptr CassUserType; index: csize; value: int16): CassError
## *
##  Sets an "smallint" in a user defined type at the specified name.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_int16_by_name*(user_type: ptr CassUserType; name: cstring;
                                      value: int16): CassError
## *
##  Same as cass_user_type_set_int16_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_user_type_set_int16_by_name()
## 
##  @see cass_user_type_set_int16_by_name()
## 

proc cass_user_type_set_int16_by_name_n*(user_type: ptr CassUserType; name: cstring;
                                        name_length: csize; value: int16): CassError
## *
##  Sets an "int" in a user defined type at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_int32*(user_type: ptr CassUserType; index: csize; value: int32): CassError
## *
##  Sets an "int" in a user defined type at the specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_int32_by_name*(user_type: ptr CassUserType; name: cstring;
                                      value: int32): CassError
## *
##  Same as cass_user_type_set_int32_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_user_type_set_int32_by_name()
## 
##  @see cass_user_type_set_int32_by_name()
## 

proc cass_user_type_set_int32_by_name_n*(user_type: ptr CassUserType; name: cstring;
                                        name_length: csize; value: int32): CassError
## *
##  Sets a "date" in a user defined type at the specified index.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_uint32*(user_type: ptr CassUserType; index: csize;
                               value: uint32): CassError
## *
##  Sets a "date" in a user defined type at the specified name.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_uint32_by_name*(user_type: ptr CassUserType; name: cstring;
                                       value: uint32): CassError
## *
##  Same as cass_user_type_set_uint32_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_user_type_set_uint32_by_name()
## 
##  @see cass_user_type_set_uint32_by_name()
## 

proc cass_user_type_set_uint32_by_name_n*(user_type: ptr CassUserType;
    name: cstring; name_length: csize; value: uint32): CassError
## *
##  Sets an "bigint", "counter", "timestamp" or "time" in a
##  user defined type at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_int64*(user_type: ptr CassUserType; index: csize; value: int64): CassError
## *
##  Sets an "bigint", "counter", "timestamp" or "time" in a
##  user defined type at the specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_int64_by_name*(user_type: ptr CassUserType; name: cstring;
                                      value: int64): CassError
## *
##  Same as cass_user_type_set_int64_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_user_type_set_int64_by_name()
## 
##  @see cass_user_type_set_int64_by_name()
## 

proc cass_user_type_set_int64_by_name_n*(user_type: ptr CassUserType; name: cstring;
                                        name_length: csize; value: int64): CassError
## *
##  Sets a "float" in a user defined type at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_float*(user_type: ptr CassUserType; index: csize;
                              value: cass_float_t): CassError
## *
##  Sets a "float" in a user defined type at the specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_float_by_name*(user_type: ptr CassUserType; name: cstring;
                                      value: cass_float_t): CassError
## *
##  Same as cass_user_type_set_float_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_user_type_set_float_by_name()
## 
##  @see cass_user_type_set_float_by_name()
## 

proc cass_user_type_set_float_by_name_n*(user_type: ptr CassUserType; name: cstring;
                                        name_length: csize; value: cass_float_t): CassError
## *
##  Sets an "double" in a user defined type at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_double*(user_type: ptr CassUserType; index: csize;
                               value: cass_double_t): CassError
## *
##  Sets an "double" in a user defined type at the specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_double_by_name*(user_type: ptr CassUserType; name: cstring;
                                       value: cass_double_t): CassError
## *
##  Same as cass_user_type_set_double_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_user_type_set_double_by_name()
## 
##  @see cass_user_type_set_double_by_name()
## 

proc cass_user_type_set_double_by_name_n*(user_type: ptr CassUserType;
    name: cstring; name_length: csize; value: cass_double_t): CassError
## *
##  Sets a "boolean" in a user defined type at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_bool*(user_type: ptr CassUserType; index: csize;
                             value: cass_bool_t): CassError
## *
##  Sets a "boolean" in a user defined type at the specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_bool_by_name*(user_type: ptr CassUserType; name: cstring;
                                     value: cass_bool_t): CassError
## *
##  Same as cass_user_type_set_double_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_user_type_set_double_by_name()
## 
##  @see cass_user_type_set_double_by_name()
## 

proc cass_user_type_set_bool_by_name_n*(user_type: ptr CassUserType; name: cstring;
                                       name_length: csize; value: cass_bool_t): CassError
## *
##  Sets an "ascii", "text" or "varchar" in a user defined type at the
##  specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_string*(user_type: ptr CassUserType; index: csize;
                               value: cstring): CassError
## *
##  Same as cass_user_type_set_string(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @param[in] value_length
##  @return same as cass_user_type_set_string()
## 
##  @see cass_user_type_set_string()
## 

proc cass_user_type_set_string_n*(user_type: ptr CassUserType; index: csize;
                                 value: cstring; value_length: csize): CassError
## *
##  Sets an "ascii", "text" or "varchar" in a user defined type at the
##  specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_string_by_name*(user_type: ptr CassUserType; name: cstring;
                                       value: cstring): CassError
## *
##  Same as cass_user_type_set_string_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @param[in] value_length
##  @return same as cass_user_type_set_string_by_name()
## 
##  @see cass_user_type_set_string_by_name()
## 

proc cass_user_type_set_string_by_name_n*(user_type: ptr CassUserType;
    name: cstring; name_length: csize; value: cstring; value_length: csize): CassError
## *
##  Sets a "blob" "varint" or "custom" in a user defined type at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @param[in] value_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_bytes*(user_type: ptr CassUserType; index: csize;
                              value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Sets a "blob", "varint" or "custom" in a user defined type at the specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @param[in] value_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_bytes_by_name*(user_type: ptr CassUserType; name: cstring;
                                      value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Same as cass_user_type_set_bytes_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @param[in] value_size
##  @return same as cass_user_type_set_bytes_by_name()
## 
##  @see cass_user_type_set_bytes_by_name()
## 

proc cass_user_type_set_bytes_by_name_n*(user_type: ptr CassUserType; name: cstring;
                                        name_length: csize;
                                        value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Sets a "custom" in a user defined type at the specified index.
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] class_name
##  @param[in] value
##  @param[in] value_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_custom*(user_type: ptr CassUserType; index: csize;
                               class_name: cstring; value: ptr cass_byte_t;
                               value_size: csize): CassError
## *
##  Same as cass_user_type_set_custom(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] class_name
##  @param[in] class_name_length
##  @param[in] value
##  @param[in] value_size
##  @return same as cass_user_type_set_custom()
## 
##  @see cass_user_type_set_custom()
## 

proc cass_user_type_set_custom_n*(user_type: ptr CassUserType; index: csize;
                                 class_name: cstring; class_name_length: csize;
                                 value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Sets a "custom" in a user defined type at the specified name.
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] class_name
##  @param[in] value
##  @param[in] value_size
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_custom_by_name*(user_type: ptr CassUserType; name: cstring;
                                       class_name: cstring;
                                       value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Same as cass_user_type_set_custom_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] class_name
##  @param[in] class_name_length
##  @param[in] value
##  @param[in] value_size
##  @return same as cass_user_type_set_custom_by_name()
## 
##  @see cass_user_type_set_custom_by_name()
## 

proc cass_user_type_set_custom_by_name_n*(user_type: ptr CassUserType;
    name: cstring; name_length: csize; class_name: cstring; class_name_length: csize;
    value: ptr cass_byte_t; value_size: csize): CassError
## *
##  Sets a "uuid" or "timeuuid" in a user defined type at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_uuid*(user_type: ptr CassUserType; index: csize;
                             value: CassUuid): CassError
## *
##  Sets a "uuid" or "timeuuid" in a user defined type at the specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_uuid_by_name*(user_type: ptr CassUserType; name: cstring;
                                     value: CassUuid): CassError
## *
##  Same as cass_user_type_set_uuid_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_user_type_set_uuid_by_name()
## 
##  @see cass_user_type_set_uuid_by_name()
## 

proc cass_user_type_set_uuid_by_name_n*(user_type: ptr CassUserType; name: cstring;
                                       name_length: csize; value: CassUuid): CassError
## *
##  Sets a "inet" in a user defined type at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_inet*(user_type: ptr CassUserType; index: csize;
                             value: CassInet): CassError
## *
##  Sets a "inet" in a user defined type at the specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_inet_by_name*(user_type: ptr CassUserType; name: cstring;
                                     value: CassInet): CassError
## *
##  Same as cass_user_type_set_inet_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_user_type_set_inet_by_name()
## 
##  @see cass_user_type_set_inet_by_name()
## 

proc cass_user_type_set_inet_by_name_n*(user_type: ptr CassUserType; name: cstring;
                                       name_length: csize; value: CassInet): CassError
## *
##  Sets an "decimal" in a user defined type at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] varint
##  @param[in] varint_size
##  @param[in] scale
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_decimal*(user_type: ptr CassUserType; index: csize;
                                varint: ptr cass_byte_t; varint_size: csize;
                                scale: cint): CassError
## *
##  Sets "decimal" in a user defined type at the specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] varint
##  @param[in] varint_size
##  @param[in] scale
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_decimal_by_name*(user_type: ptr CassUserType; name: cstring;
                                        varint: ptr cass_byte_t;
                                        varint_size: csize; scale: cint): CassError
## *
##  Same as cass_user_type_set_decimal_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] varint
##  @param[in] varint_size
##  @param[in] scale
##  @return same as cass_user_type_set_decimal_by_name()
## 
##  @see cass_user_type_set_decimal_by_name()
## 

proc cass_user_type_set_decimal_by_name_n*(user_type: ptr CassUserType;
    name: cstring; name_length: csize; varint: ptr cass_byte_t; varint_size: csize;
    scale: cint): CassError
## *
##  Sets a "duration" in a user defined type at the specified index.
## 
##  @cassandra{3.10+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] months
##  @param[in] days
##  @param[in] nanos
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_duration*(user_type: ptr CassUserType; index: csize;
                                 months: int32; days: int32; nanos: int64): CassError
## *
##  Sets "duration" in a user defined type at the specified name.
## 
##  @cassandra{3.10+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] months
##  @param[in] days
##  @param[in] nanos
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_duration_by_name*(user_type: ptr CassUserType;
    name: cstring; months: int32; days: int32; nanos: int64): CassError
## *
##  Same as cass_user_type_set_duration_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{3.10+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] months
##  @param[in] days
##  @param[in] nanos
##  @return same as cass_user_type_set_duration_by_name()
## 
##  @see cass_user_type_set_duration_by_name()
## 

proc cass_user_type_set_duration_by_name_n*(user_type: ptr CassUserType;
    name: cstring; name_length: csize; months: int32; days: int32; nanos: int64): CassError
## *
##  Sets a "list", "map" or "set" in a user defined type at the
##  specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_collection*(user_type: ptr CassUserType; index: csize;
                                   value: ptr CassCollection): CassError
## *
##  Sets a "list", "map" or "set" in a user defined type at the
##  specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_collection_by_name*(user_type: ptr CassUserType;
    name: cstring; value: ptr CassCollection): CassError
## *
##  Same as cass_user_type_set_collection_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_user_type_set_collection_by_name()
## 
##  @see cass_user_type_set_collection_by_name()
## 

proc cass_user_type_set_collection_by_name_n*(user_type: ptr CassUserType;
    name: cstring; name_length: csize; value: ptr CassCollection): CassError
## *
##  Sets a "tuple" in a user defined type at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_tuple*(user_type: ptr CassUserType; index: csize;
                              value: ptr CassTuple): CassError
## *
##  Sets a "tuple" in a user defined type at the specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_tuple_by_name*(user_type: ptr CassUserType; name: cstring;
                                      value: ptr CassTuple): CassError
## *
##  Same as cass_user_type_set_tuple_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_user_type_set_tuple_by_name()
## 
##  @see cass_user_type_set_tuple_by_name()
## 

proc cass_user_type_set_tuple_by_name_n*(user_type: ptr CassUserType; name: cstring;
                                        name_length: csize; value: ptr CassTuple): CassError
## *
##  Sets a user defined type in a user defined type at the specified index.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] index
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_user_type*(user_type: ptr CassUserType; index: csize;
                                  value: ptr CassUserType): CassError
## *
##  Sets a user defined type in a user defined type at the specified name.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] value
##  @return CASS_OK if successful, otherwise an error occurred.
## 

proc cass_user_type_set_user_type_by_name*(user_type: ptr CassUserType;
    name: cstring; value: ptr CassUserType): CassError
## *
##  Same as cass_user_type_set_user_type_by_name(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassUserType
## 
##  @param[in] user_type
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @return same as cass_user_type_set_user_type_by_name()
## 
##  @see cass_user_type_set_user_type_by_name()
## 

proc cass_user_type_set_user_type_by_name_n*(user_type: ptr CassUserType;
    name: cstring; name_length: csize; value: ptr CassUserType): CassError
## **********************************************************************************
## 
##  Result
## 
## *********************************************************************************
## *
##  Frees a result instance.
## 
##  This method invalidates all values, rows, and
##  iterators that were derived from this result.
## 
##  @public @memberof CassResult
## 
##  @param[in] result
## 

proc cass_result_free*(result: ptr CassResult)
## *
##  Gets the number of rows for the specified result.
## 
##  @public @memberof CassResult
## 
##  @param[in] result
##  @return The number of rows in the result.
## 

proc cass_result_row_count*(result: ptr CassResult): csize
## *
##  Gets the number of columns per row for the specified result.
## 
##  @public @memberof CassResult
## 
##  @param[in] result
##  @return The number of columns per row in the result.
## 

proc cass_result_column_count*(result: ptr CassResult): csize
## *
##  Gets the column name at index for the specified result.
## 
##  @public @memberof CassResult
## 
##  @param[in] result
##  @param[in] index
##  @param[out] name The column name at the specified index.
##  @param[out] name_length
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_result_column_name*(result: ptr CassResult; index: csize;
                             name: cstringArray; name_length: ptr csize): CassError
## *
##  Gets the column type at index for the specified result.
## 
##  @public @memberof CassResult
## 
##  @param[in] result
##  @param[in] index
##  @return The column type at the specified index. CASS_VALUE_TYPE_UNKNOWN
##  is returned if the index is out of bounds.
## 

proc cass_result_column_type*(result: ptr CassResult; index: csize): CassValueType
## *
##  Gets the column data type at index for the specified result.
## 
##  @public @memberof CassResult
## 
##  @param[in] result
##  @param[in] index
##  @return The column type at the specified index. NULL is returned if the
##  index is out of bounds.
## 

proc cass_result_column_data_type*(result: ptr CassResult; index: csize): ptr CassDataType
## *
##  Gets the first row of the result.
## 
##  @public @memberof CassResult
## 
##  @param[in] result
##  @return The first row of the result. NULL if there are no rows.
## 

proc cass_result_first_row*(result: ptr CassResult): ptr CassRow
## *
##  Returns true if there are more pages.
## 
##  @cassandra{2.0+}
## 
##  @public @memberof CassResult
## 
##  @param[in] result
##  @return cass_true if there are more pages
## 

proc cass_result_has_more_pages*(result: ptr CassResult): cass_bool_t
## *
##  Gets the raw paging state from the result. The paging state is bound to the
##  lifetime of the result object. If paging state needs to live beyond the
##  lifetime of the result object it must be copied.
## 
##  <b>Warning:</b> The paging state should not be exposed to or come from
##  untrusted environments. The paging state could be spoofed and potentially
##  used to gain access to other data.
## 
##  @cassandra{2.0+}
## 
##  @public @memberof CassResult
## 
##  @param[in] result
##  @param[out] paging_state
##  @param[out] paging_state_size
##  @return CASS_OK if successful, otherwise error occurred
## 
##  @see cass_statement_set_paging_state_token()
## 

proc cass_result_paging_state_token*(result: ptr CassResult;
                                    paging_state: cstringArray;
                                    paging_state_size: ptr csize): CassError
## **********************************************************************************
## 
##  Error result
## 
## *********************************************************************************
## *
##  Frees an error result instance.
## 
##  @public @memberof CassErrorResult
## 
##  @param[in] error_result
## 

proc cass_error_result_free*(error_result: ptr CassErrorResult)
## *
##  Gets error code for the error result. This error code will always
##  have an server error source.
## 
##  @public @memberof CassErrorResult
## 
##  @param[in] error_result
##  @return The server error code
## 

proc cass_error_result_code*(error_result: ptr CassErrorResult): CassError
## *
##  Gets consistency that triggered the error result of the
##  following types:
## 
##  <ul>
##    <li>CASS_ERROR_SERVER_READ_TIMEOUT</li>
##    <li>CASS_ERROR_SERVER_WRITE_TIMEOUT</li>
##    <li>CASS_ERROR_SERVER_READ_FAILURE</li>
##    <li>CASS_ERROR_SERVER_WRITE_FAILURE</li>
##    <li>CASS_ERROR_SERVER_UNAVAILABLE</li>
##  </ul>
## 
##  @public @memberof CassErrorResult
## 
##  @param[in] error_result
##  @return The consistency that triggered the error for a read timeout,
##  write timeout or an unavailable error result. Undefined for other
##  error result types.
## 

proc cass_error_result_consistency*(error_result: ptr CassErrorResult): CassConsistency
## *
##  Gets the actual number of received responses, received acknowledgments
##  or alive nodes for following error result types, respectively:
## 
##  <ul>
##    <li>CASS_ERROR_SERVER_READ_TIMEOUT</li>
##    <li>CASS_ERROR_SERVER_WRITE_TIMEOUT</li>
##    <li>CASS_ERROR_SERVER_READ_FAILURE</li>
##    <li>CASS_ERROR_SERVER_WRITE_FAILURE</li>
##    <li>CASS_ERROR_SERVER_UNAVAILABLE</li>
##  </ul>
## 
##  @public @memberof CassErrorResult
## 
##  @param[in] error_result
##  @return The actual received responses for a read timeout, actual received
##  acknowledgments for a write timeout or actual alive nodes for a unavailable
##  error. Undefined for other error result types.
## 

proc cass_error_result_responses_received*(error_result: ptr CassErrorResult): int32
## *
##  Gets required responses, required acknowledgments or required alive nodes
##  needed to successfully complete the request for following error result types,
##  respectively:
## 
##  <ul>
##    <li>CASS_ERROR_SERVER_READ_TIMEOUT</li>
##    <li>CASS_ERROR_SERVER_WRITE_TIMEOUT</li>
##    <li>CASS_ERROR_SERVER_READ_FAILURE</li>
##    <li>CASS_ERROR_SERVER_WRITE_FAILURE</li>
##    <li>CASS_ERROR_SERVER_UNAVAILABLE</li>
##  </ul>
## 
##  @public @memberof CassErrorResult
## 
##  @param[in] error_result
##  @return The required responses for a read time, required acknowledgments
##  for a write timeout or required alive nodes for an unavailable error result.
##  Undefined for other error result types.
## 

proc cass_error_result_responses_required*(error_result: ptr CassErrorResult): int32
## *
##  Gets the number of nodes that experienced failures for the following error types:
## 
##  <ul>
##    <li>CASS_ERROR_SERVER_READ_FAILURE</li>
##    <li>CASS_ERROR_SERVER_WRITE_FAILURE</li>
##  </ul>
## 
##  @public @memberof CassErrorResult
## 
##  @param[in] error_result
##  @return The number of nodes that failed during a read or write request.
## 

proc cass_error_result_num_failures*(error_result: ptr CassErrorResult): int32
## *
##  Determines whether the actual data was present in the responses from the
##  replicas for the following error result types:
## 
##  <ul>
##    <li>CASS_ERROR_SERVER_READ_TIMEOUT</li>
##    <li>CASS_ERROR_SERVER_READ_FAILURE</li>
##  </ul>
## 
##  @public @memberof CassErrorResult
## 
##  @param[in] error_result
##  @return cass_true if the data was present in the received responses when the
##  read timeout occurred. Undefined for other error result types.
## 

proc cass_error_result_data_present*(error_result: ptr CassErrorResult): cass_bool_t
## *
##  Gets the write type of a request for the following error result types:
## 
##  <ul>
##    <li>CASS_ERROR_SERVER_WRITE_TIMEOUT</li>
##    <li>CASS_ERROR_SERVER_WRITE_FAILURE</li>
##  </ul>
## 
##  @public @memberof CassErrorResult
## 
##  @param[in] error_result
##  @return The type of the write that timed out. Undefined for
##  other error result types.
## 

proc cass_error_result_write_type*(error_result: ptr CassErrorResult): CassWriteType
## *
##  Gets the affected keyspace for the following error result types:
## 
##  <ul>
##    <li>CASS_ERROR_SERVER_ALREADY_EXISTS</li>
##    <li>CASS_ERROR_SERVER_FUNCTION_FAILURE</li>
##  </ul>
## 
##  @public @memberof CassErrorResult
## 
##  @param[in] error_result
##  @param[out] keyspace
##  @param[out] keyspace_length
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_error_result_keyspace*(error_result: ptr CassErrorResult;
                                keyspace: cstringArray; keyspace_length: ptr csize): CassError
## *
##  Gets the affected table for the already exists error
##  (CASS_ERROR_SERVER_ALREADY_EXISTS) result type.
## 
##  @public @memberof CassErrorResult
## 
##  @param[in] error_result
##  @param[out] table
##  @param[out] table_length
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_error_result_table*(error_result: ptr CassErrorResult;
                             table: cstringArray; table_length: ptr csize): CassError
## *
##  Gets the affected function for the function failure error
##  (CASS_ERROR_SERVER_FUNCTION_FAILURE) result type.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassErrorResult
## 
##  @param[in] error_result
##  @param[out] function
##  @param[out] function_length
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_error_result_function*(error_result: ptr CassErrorResult;
                                function: cstringArray; function_length: ptr csize): CassError
## *
##  Gets the number of argument types for the function failure error
##  (CASS_ERROR_SERVER_FUNCTION_FAILURE) result type.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassErrorResult
## 
##  @param[in] error_result
##  @return The number of arguments for the affected function.
## 

proc cass_error_num_arg_types*(error_result: ptr CassErrorResult): csize
## *
##  Gets the argument type at the specified index for the function failure
##  error (CASS_ERROR_SERVER_FUNCTION_FAILURE) result type.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassErrorResult
## 
##  @param[in] error_result
##  @param[in] index
##  @param[out] arg_type
##  @param[out] arg_type_length
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_error_result_arg_type*(error_result: ptr CassErrorResult; index: csize;
                                arg_type: cstringArray; arg_type_length: ptr csize): CassError
## **********************************************************************************
## 
##  Iterator
## 
## *********************************************************************************
## *
##  Frees an iterator instance.
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
## 

proc cass_iterator_free*(`iterator`: ptr CassIterator)
## *
##  Gets the type of the specified iterator.
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return The type of the iterator.
## 

proc cass_iterator_type*(`iterator`: ptr CassIterator): CassIteratorType
## *
##  Creates a new iterator for the specified result. This can be
##  used to iterate over rows in the result.
## 
##  @public @memberof CassResult
## 
##  @param[in] result
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_free()
## 

proc cass_iterator_from_result*(result: ptr CassResult): ptr CassIterator
## *
##  Creates a new iterator for the specified row. This can be
##  used to iterate over columns in a row.
## 
##  @public @memberof CassRow
## 
##  @param[in] row
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_free()
## 

proc cass_iterator_from_row*(row: ptr CassRow): ptr CassIterator
## *
##  Creates a new iterator for the specified collection. This can be
##  used to iterate over values in a collection.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @return A new iterator that must be freed. NULL returned if the
##  value is not a collection.
## 
##  @see cass_iterator_free()
## 

proc cass_iterator_from_collection*(value: ptr CassValue): ptr CassIterator
## *
##  Creates a new iterator for the specified map. This can be
##  used to iterate over key/value pairs in a map.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @return A new iterator that must be freed. NULL returned if the
##  value is not a map.
## 
##  @see cass_iterator_free()
## 

proc cass_iterator_from_map*(value: ptr CassValue): ptr CassIterator
## *
##  Creates a new iterator for the specified tuple. This can be
##  used to iterate over values in a tuple.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @return A new iterator that must be freed. NULL returned if the
##  value is not a tuple.
## 
##  @see cass_iterator_free()
## 

proc cass_iterator_from_tuple*(value: ptr CassValue): ptr CassIterator
## *
##  Creates a new iterator for the specified user defined type. This can be
##  used to iterate over fields in a user defined type.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @return A new iterator that must be freed. NULL returned if the
##  value is not a user defined type.
## 
##  @see cass_iterator_free()
## 

proc cass_iterator_fields_from_user_type*(value: ptr CassValue): ptr CassIterator
## *
##  Creates a new iterator for the specified schema metadata.
##  This can be used to iterate over keyspace.
## 
##  @public @memberof CassSchemaMeta
## 
##  @param[in] schema_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_keyspace_meta()
##  @see cass_iterator_free()
## 

proc cass_iterator_keyspaces_from_schema_meta*(schema_meta: ptr CassSchemaMeta): ptr CassIterator
## *
##  Creates a new iterator for the specified keyspace metadata.
##  This can be used to iterate over tables.
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_table_meta()
##  @see cass_iterator_free()
## 

proc cass_iterator_tables_from_keyspace_meta*(keyspace_meta: ptr CassKeyspaceMeta): ptr CassIterator
## *
##  Creates a new iterator for the specified keyspace metadata.
##  This can be used to iterate over views.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_materialized_view_meta()
##  @see cass_iterator_free()
## 

proc cass_iterator_materialized_views_from_keyspace_meta*(
    keyspace_meta: ptr CassKeyspaceMeta): ptr CassIterator
## *
##  Creates a new iterator for the specified keyspace metadata.
##  This can be used to iterate over types.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_user_type()
##  @see cass_iterator_free()
## 

proc cass_iterator_user_types_from_keyspace_meta*(
    keyspace_meta: ptr CassKeyspaceMeta): ptr CassIterator
## *
##  Creates a new iterator for the specified keyspace metadata.
##  This can be used to iterate over functions.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_function_meta()
##  @see cass_iterator_free()
## 

proc cass_iterator_functions_from_keyspace_meta*(
    keyspace_meta: ptr CassKeyspaceMeta): ptr CassIterator
## *
##  Creates a new iterator for the specified keyspace metadata.
##  This can be used to iterate over aggregates.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_aggregate_meta()
##  @see cass_iterator_free()
## 

proc cass_iterator_aggregates_from_keyspace_meta*(
    keyspace_meta: ptr CassKeyspaceMeta): ptr CassIterator
## *
##  Creates a new fields iterator for the specified keyspace metadata. Metadata
##  fields allow direct access to the column data found in the underlying
##  "keyspaces" metadata table. This can be used to iterate those metadata
##  field entries.
## 
##  @public @memberof CassKeyspaceMeta
## 
##  @param[in] keyspace_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_meta_field_name()
##  @see cass_iterator_get_meta_field_value()
##  @see cass_iterator_free()
## 

proc cass_iterator_fields_from_keyspace_meta*(keyspace_meta: ptr CassKeyspaceMeta): ptr CassIterator
## *
##  Creates a new iterator for the specified table metadata.
##  This can be used to iterate over columns.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_column_meta()
##  @see cass_iterator_free()
## 

proc cass_iterator_columns_from_table_meta*(table_meta: ptr CassTableMeta): ptr CassIterator
## *
##  Creates a new iterator for the specified table metadata.
##  This can be used to iterate over indexes.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_index_meta()
##  @see cass_iterator_free()
## 

proc cass_iterator_indexes_from_table_meta*(table_meta: ptr CassTableMeta): ptr CassIterator
## *
##  Creates a new iterator for the specified materialized view metadata.
##  This can be used to iterate over columns.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_materialized_view_meta()
##  @see cass_iterator_free()
## 

proc cass_iterator_materialized_views_from_table_meta*(
    table_meta: ptr CassTableMeta): ptr CassIterator
## *
##  Creates a new fields iterator for the specified table metadata. Metadata
##  fields allow direct access to the column data found in the underlying
##  "tables" metadata table. This can be used to iterate those metadata
##  field entries.
## 
##  @public @memberof CassTableMeta
## 
##  @param[in] table_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_meta_field_name()
##  @see cass_iterator_get_meta_field_value()
##  @see cass_iterator_free()
## 

proc cass_iterator_fields_from_table_meta*(table_meta: ptr CassTableMeta): ptr CassIterator
## *
##  Creates a new iterator for the specified materialized view metadata.
##  This can be used to iterate over columns.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_column_meta()
##  @see cass_iterator_free()
## 

proc cass_iterator_columns_from_materialized_view_meta*(
    view_meta: ptr CassMaterializedViewMeta): ptr CassIterator
## *
##  Creates a new fields iterator for the specified materialized view metadata.
##  Metadata fields allow direct access to the column data found in the
##  underlying "views" metadata view. This can be used to iterate those metadata
##  field entries.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassMaterializedViewMeta
## 
##  @param[in] view_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_meta_field_name()
##  @see cass_iterator_get_meta_field_value()
##  @see cass_iterator_free()
## 

proc cass_iterator_fields_from_materialized_view_meta*(
    view_meta: ptr CassMaterializedViewMeta): ptr CassIterator
## *
##  Creates a new fields iterator for the specified column metadata. Metadata
##  fields allow direct access to the column data found in the underlying
##  "columns" metadata table. This can be used to iterate those metadata
##  field entries.
## 
##  @public @memberof CassColumnMeta
## 
##  @param[in] column_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_meta_field_name()
##  @see cass_iterator_get_meta_field_value()
##  @see cass_iterator_free()
## 

proc cass_iterator_fields_from_column_meta*(column_meta: ptr CassColumnMeta): ptr CassIterator
## *
##  Creates a new fields iterator for the specified index metadata. Metadata
##  fields allow direct access to the index data found in the underlying
##  "indexes" metadata table. This can be used to iterate those metadata
##  field entries.
## 
##  @public @memberof CassIndexMeta
## 
##  @param[in] index_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_meta_field_name()
##  @see cass_iterator_get_meta_field_value()
##  @see cass_iterator_free()
## 

proc cass_iterator_fields_from_index_meta*(index_meta: ptr CassIndexMeta): ptr CassIterator
## *
##  Creates a new fields iterator for the specified function metadata. Metadata
##  fields allow direct access to the column data found in the underlying
##  "functions" metadata table. This can be used to iterate those metadata
##  field entries.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassFunctionMeta
## 
##  @param[in] function_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_meta_field()
##  @see cass_iterator_free()
## 

proc cass_iterator_fields_from_function_meta*(function_meta: ptr CassFunctionMeta): ptr CassIterator
## *
##  Creates a new fields iterator for the specified aggregate metadata. Metadata
##  fields allow direct access to the column data found in the underlying
##  "aggregates" metadata table. This can be used to iterate those metadata
##  field entries.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassAggregateMeta
## 
##  @param[in] aggregate_meta
##  @return A new iterator that must be freed.
## 
##  @see cass_iterator_get_meta_field()
##  @see cass_iterator_free()
## 

proc cass_iterator_fields_from_aggregate_meta*(
    aggregate_meta: ptr CassAggregateMeta): ptr CassIterator
## *
##  Advance the iterator to the next row, column or collection item.
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return false if no more rows, columns or items, otherwise true
## 

proc cass_iterator_next*(`iterator`: ptr CassIterator): cass_bool_t
## *
##  Gets the row at the result iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  row returned by this method.
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A row
## 

proc cass_iterator_get_row*(`iterator`: ptr CassIterator): ptr CassRow
## *
##  Gets the column value at the row iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  column returned by this method.
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A value
## 

proc cass_iterator_get_column*(`iterator`: ptr CassIterator): ptr CassValue
## *
##  Gets the value at a collection or tuple iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  value returned by this method.
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A value
## 

proc cass_iterator_get_value*(`iterator`: ptr CassIterator): ptr CassValue
## *
##  Gets the key at the map iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  value returned by this method.
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A value
## 

proc cass_iterator_get_map_key*(`iterator`: ptr CassIterator): ptr CassValue
## *
##  Gets the value at the map iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  value returned by this method.
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A value
## 

proc cass_iterator_get_map_value*(`iterator`: ptr CassIterator): ptr CassValue
## *
##  Gets the field name at the user type defined iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  name returned by this method.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @param[out] name
##  @param[out] name_length
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_iterator_get_user_type_field_name*(`iterator`: ptr CassIterator;
    name: cstringArray; name_length: ptr csize): CassError
## *
##  Gets the field value at the user type defined iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  value returned by this method.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A value
## 

proc cass_iterator_get_user_type_field_value*(`iterator`: ptr CassIterator): ptr CassValue
## *
##  Gets the keyspace metadata entry at the iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  value returned by this method.
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A keyspace metadata entry
## 

proc cass_iterator_get_keyspace_meta*(`iterator`: ptr CassIterator): ptr CassKeyspaceMeta
## *
##  Gets the table metadata entry at the iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  value returned by this method.
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A table metadata entry
## 

proc cass_iterator_get_table_meta*(`iterator`: ptr CassIterator): ptr CassTableMeta
## *
##  Gets the materialized view metadata entry at the iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  value returned by this method.
## 
##  @cassandra{3.0+}
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A materialized view metadata entry
## 

proc cass_iterator_get_materialized_view_meta*(`iterator`: ptr CassIterator): ptr CassMaterializedViewMeta
## *
##  Gets the type metadata entry at the iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  value returned by this method.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A type metadata entry
## 

proc cass_iterator_get_user_type*(`iterator`: ptr CassIterator): ptr CassDataType
## *
##  Gets the function metadata entry at the iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  value returned by this method.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A function metadata entry
## 

proc cass_iterator_get_function_meta*(`iterator`: ptr CassIterator): ptr CassFunctionMeta
## *
##  Gets the aggregate metadata entry at the iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  value returned by this method.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A aggregate metadata entry
## 

proc cass_iterator_get_aggregate_meta*(`iterator`: ptr CassIterator): ptr CassAggregateMeta
## *
##  Gets the column metadata entry at the iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  value returned by this method.
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A column metadata entry
## 

proc cass_iterator_get_column_meta*(`iterator`: ptr CassIterator): ptr CassColumnMeta
## *
##  Gets the index metadata entry at the iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  value returned by this method.
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A index metadata entry
## 

proc cass_iterator_get_index_meta*(`iterator`: ptr CassIterator): ptr CassIndexMeta
## *
##  Gets the metadata field name at the iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  value returned by this method.
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @param[out] name
##  @param[out] name_length
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_iterator_get_meta_field_name*(`iterator`: ptr CassIterator;
                                       name: cstringArray; name_length: ptr csize): CassError
## *
##  Gets the metadata field value at the iterator's current position.
## 
##  Calling cass_iterator_next() will invalidate the previous
##  value returned by this method.
## 
##  @public @memberof CassIterator
## 
##  @param[in] iterator
##  @return A metadata field value
## 

proc cass_iterator_get_meta_field_value*(`iterator`: ptr CassIterator): ptr CassValue
## **********************************************************************************
## 
##  Row
## 
## *********************************************************************************
## *
##  Get the column value at index for the specified row.
## 
##  @public @memberof CassRow
## 
##  @param[in] row
##  @param[in] index
##  @return The column value at the specified index. NULL is
##  returned if the index is out of bounds.
## 

proc cass_row_get_column*(row: ptr CassRow; index: csize): ptr CassValue
## *
##  Get the column value by name for the specified row.
## 
##  @public @memberof CassRow
## 
##  @param[in] row
##  @param[in] name
##  @return The column value for the specified name. NULL is
##  returned if the column does not exist.
## 

proc cass_row_get_column_by_name*(row: ptr CassRow; name: cstring): ptr CassValue
## *
##  Same as cass_row_get_column_by_name(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassRow
## 
##  @param[in] row
##  @param[in] name
##  @param[in] name_length
##  @return same as cass_row_get_column_by_name()
## 
##  @see cass_row_get_column_by_name()
## 

proc cass_row_get_column_by_name_n*(row: ptr CassRow; name: cstring;
                                   name_length: csize): ptr CassValue
## **********************************************************************************
## 
##  Value
## 
## *********************************************************************************
## *
##  Gets the data type of a value.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @return Returns a reference to the data type of the value.
##  Do not free this reference as it is bound to the lifetime of the value.
## 

proc cass_value_data_type*(value: ptr CassValue): ptr CassDataType
## *
##  Gets an int8 for the specified value.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @param[out] output
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_value_get_int8*(value: ptr CassValue; output: ptr int8): CassError
## *
##  Gets an int16 for the specified value.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @param[out] output
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_value_get_int16*(value: ptr CassValue; output: ptr int16): CassError
## *
##  Gets an int32 for the specified value.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @param[out] output
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_value_get_int32*(value: ptr CassValue; output: ptr int32): CassError
## *
##  Gets an uint32 for the specified value.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @param[out] output
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_value_get_uint32*(value: ptr CassValue; output: ptr uint32): CassError
## *
##  Gets an int64 for the specified value.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @param[out] output
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_value_get_int64*(value: ptr CassValue; output: ptr int64): CassError
## *
##  Gets a float for the specified value.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @param[out] output
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_value_get_float*(value: ptr CassValue; output: ptr cass_float_t): CassError
## *
##  Gets a double for the specified value.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @param[out] output
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_value_get_double*(value: ptr CassValue; output: ptr cass_double_t): CassError
## *
##  Gets a bool for the specified value.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @param[out] output
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_value_get_bool*(value: ptr CassValue; output: ptr cass_bool_t): CassError
## *
##  Gets a UUID for the specified value.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @param[out] output
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_value_get_uuid*(value: ptr CassValue; output: ptr CassUuid): CassError
## *
##  Gets an INET for the specified value.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @param[out] output
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_value_get_inet*(value: ptr CassValue; output: ptr CassInet): CassError
## *
##  Gets a string for the specified value.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @param[out] output
##  @param[out] output_size
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_value_get_string*(value: ptr CassValue; output: cstringArray;
                           output_size: ptr csize): CassError
## *
##  Gets the bytes of the specified value.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @param[out] output
##  @param[out] output_size
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_value_get_bytes*(value: ptr CassValue; output: ptr ptr cass_byte_t;
                          output_size: ptr csize): CassError
## *
##  Gets a decimal for the specified value.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @param[out] varint
##  @param[out] varint_size
##  @param[out] scale
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_value_get_decimal*(value: ptr CassValue; varint: ptr ptr cass_byte_t;
                            varint_size: ptr csize; scale: ptr int32): CassError
## *
##  Gets a duration for the specified value.
## 
##  @cassandra{3.10+}
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @param[out] months
##  @param[out] days
##  @param[out] nanos
##  @return CASS_OK if successful, otherwise error occurred
## 

proc cass_value_get_duration*(value: ptr CassValue; months: ptr int32; days: ptr int32;
                             nanos: ptr int64): CassError
## *
##  Gets the type of the specified value.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @return The type of the specified value.
## 

proc cass_value_type*(value: ptr CassValue): CassValueType
## *
##  Returns true if a specified value is null.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @return true if the value is null, otherwise false.
## 

proc cass_value_is_null*(value: ptr CassValue): cass_bool_t
## *
##  Returns true if a specified value is a collection.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @return true if the value is a collection, otherwise false.
## 

proc cass_value_is_collection*(value: ptr CassValue): cass_bool_t
## *
##  Returns true if a specified value is a duration.
## 
##  @public @memberof CassValue
## 
##  @param[in] value
##  @return true if the value is a duration, otherwise false.
## 

proc cass_value_is_duration*(value: ptr CassValue): cass_bool_t
## *
##  Get the number of items in a collection. Works for all collection types.
## 
##  @public @memberof CassValue
## 
##  @param[in] collection
##  @return Count of items in a collection. 0 if not a collection.
## 

proc cass_value_item_count*(collection: ptr CassValue): csize
## *
##  Get the primary sub-type for a collection. This returns the sub-type for a
##  list or set and the key type for a map.
## 
##  @public @memberof CassValue
## 
##  @param[in] collection
##  @return The type of the primary sub-type. CASS_VALUE_TYPE_UNKNOWN
##  returned if not a collection.
## 

proc cass_value_primary_sub_type*(collection: ptr CassValue): CassValueType
## *
##  Get the secondary sub-type for a collection. This returns the value type for a
##  map.
## 
##  @public @memberof CassValue
## 
##  @param[in] collection
##  @return The type of the primary sub-type. CASS_VALUE_TYPE_UNKNOWN
##  returned if not a collection or not a map.
## 

proc cass_value_secondary_sub_type*(collection: ptr CassValue): CassValueType
## **********************************************************************************
## 
##  UUID
## 
## **********************************************************************************
## *
##  Creates a new UUID generator.
## 
##  <b>Note:</b> This object is thread-safe. It is best practice to create and reuse
##  a single object per application.
## 
##  <b>Note:</b> If unique node information (IP address) is unable to be determined
##  then random node information will be generated.
## 
##  @public @memberof CassUuidGen
## 
##  @return Returns a UUID generator that must be freed.
## 
##  @see cass_uuid_gen_free()
##  @see cass_uuid_gen_new_with_node()
## 

proc cass_uuid_gen_new*(): ptr CassUuidGen
## *
##  Creates a new UUID generator with custom node information.
## 
##  <b>Note:</b> This object is thread-safe. It is best practice to create and reuse
##  a single object per application.
## 
##  @public @memberof CassUuidGen
## 
##  @return Returns a UUID generator that must be freed.
## 
##  @see cass_uuid_gen_free()
## 

proc cass_uuid_gen_new_with_node*(node: uint64): ptr CassUuidGen
## *
##  Frees a UUID generator instance.
## 
##  @public @memberof CassUuidGen
## 
##  @param[in] uuid_gen
## 

proc cass_uuid_gen_free*(uuid_gen: ptr CassUuidGen)
## *
##  Generates a V1 (time) UUID.
## 
##  <b>Note:</b> This method is thread-safe
## 
##  @public @memberof CassUuidGen
## 
##  @param[in] uuid_gen
##  @param[out] output A V1 UUID for the current time.
## 

proc cass_uuid_gen_time*(uuid_gen: ptr CassUuidGen; output: ptr CassUuid)
## *
##  Generates a new V4 (random) UUID
## 
##  <b>Note:</b>: This method is thread-safe
## 
##  @public @memberof CassUuidGen
## 
##  @param[in] uuid_gen
##  @param output A randomly generated V4 UUID.
## 

proc cass_uuid_gen_random*(uuid_gen: ptr CassUuidGen; output: ptr CassUuid)
## *
##  Generates a V1 (time) UUID for the specified time.
## 
##  <b>Note:</b>: This method is thread-safe
## 
##  @public @memberof CassUuidGen
## 
##  @param[in] uuid_gen
##  @param[in] timestamp
##  @param[out] output A V1 UUID for the specified time.
## 

proc cass_uuid_gen_from_time*(uuid_gen: ptr CassUuidGen; timestamp: uint64;
                             output: ptr CassUuid)
## *
##  Sets the UUID to the minimum V1 (time) value for the specified time.
## 
##  @public @memberof CassUuid
## 
##  @param[in] time
##  @param[out] output A minimum V1 UUID for the specified time.
## 

proc cass_uuid_min_from_time*(time: uint64; output: ptr CassUuid)
## *
##  Sets the UUID to the maximum V1 (time) value for the specified time.
## 
##  @public @memberof CassUuid
## 
##  @param[in] time
##  @param[out] output A maximum V1 UUID for the specified time.
## 

proc cass_uuid_max_from_time*(time: uint64; output: ptr CassUuid)
## *
##  Gets the timestamp for a V1 UUID
## 
##  @public @memberof CassUuid
## 
##  @param[in] uuid
##  @return The timestamp in milliseconds since the Epoch
##  (00:00:00 UTC on 1 January 1970). 0 returned if the UUID
##  is not V1.
## 

proc cass_uuid_timestamp*(uuid: CassUuid): uint64
## *
##  Gets the version for a UUID
## 
##  @public @memberof CassUuid
## 
##  @param[in] uuid
##  @return The version of the UUID (1 or 4)
## 

proc cass_uuid_version*(uuid: CassUuid): uint8
## *
##  Returns a null-terminated string for the specified UUID.
## 
##  @public @memberof CassUuid
## 
##  @param[in] uuid
##  @param[out] output A null-terminated string of length CASS_UUID_STRING_LENGTH.
## 

proc cass_uuid_string*(uuid: CassUuid; output: cstring)
## *
##  Returns a UUID for the specified string.
## 
##  Example: "550e8400-e29b-41d4-a716-446655440000"
## 
##  @public @memberof CassUuid
## 
##  @param[in] str
##  @param[out] output
## 

proc cass_uuid_from_string*(str: cstring; output: ptr CassUuid): CassError
## *
##  Same as cass_uuid_from_string(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassUuid
## 
##  @param[in] str
##  @param[in] str_length
##  @param[out] output
##  @return same as cass_uuid_from_string()
## 
##  @see cass_uuid_from_string()
## 

proc cass_uuid_from_string_n*(str: cstring; str_length: csize; output: ptr CassUuid): CassError
## **********************************************************************************
## 
##  Timestamp generators
## 
## *********************************************************************************
## *
##  Creates a new server-side timestamp generator. This generator allows Cassandra
##  to assign timestamps server-side.
## 
##  <b>Note:</b> This is the default timestamp generator.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTimestampGen
## 
##  @return Returns a timestamp generator that must be freed.
## 
##  @see cass_timestamp_gen_free()
## 

proc cass_timestamp_gen_server_side_new*(): ptr CassTimestampGen
## *
##  Creates a new monotonically increasing timestamp generator with microsecond
##  precision.
## 
##  This implementation guarantees a monotonically increasing timestamp. If the
##  timestamp generation rate exceeds one per microsecond or if the clock skews
##  into the past the generator will artificially increment the previously
##  generated timestamp until the request rate decreases or the clock skew
##  is corrected.
## 
##  By default, this timestamp generator will generate warnings if more than
##  1 second of clock skew is detected. It will print an error every second until
##  the clock skew is resolved. These settings can be changed by using
##  `cass_timestamp_gen_monotonic_new_with_settings()` to create the generator
##  instance.
## 
##  <b>Note:</b> This generator is thread-safe and can be shared by multiple
##  sessions.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTimestampGen
## 
##  @return Returns a timestamp generator that must be freed.
## 
##  @see cass_timestamp_gen_monotonic_new_with_settings();
##  @see cass_timestamp_gen_free()
## 

proc cass_timestamp_gen_monotonic_new*(): ptr CassTimestampGen
## *
##  Same as cass_timestamp_gen_monotonic_new(), but with settings for controlling
##  warnings about clock skew.
## 
##  @param warning_threshold_us The amount of clock skew, in microseconds, that
##  must be detected before a warning is triggered. A threshold less than 0 can
##  be used to disable warnings.
##  @param warning_interval_ms The amount of time, in milliseonds, to wait before
##  warning again about clock skew. An interval value less than or equal to 0 allows
##  the warning to be triggered every millisecond.
##  @return Returns a timestamp generator that must be freed.
## 

proc cass_timestamp_gen_monotonic_new_with_settings*(warning_threshold_us: int64;
    warning_interval_ms: int64): ptr CassTimestampGen
## *
##  Frees a timestamp generator instance.
## 
##  @cassandra{2.1+}
## 
##  @public @memberof CassTimestampGen
## 
##  @param[in] timestamp_gen
## 

proc cass_timestamp_gen_free*(timestamp_gen: ptr CassTimestampGen)
## **********************************************************************************
## 
##  Retry policies
## 
## *********************************************************************************
## *
##  Creates a new default retry policy.
## 
##  This policy retries queries in the following cases:
##  <ul>
##    <li>On a read timeout, if enough replicas replied but data was not received.</li>
##    <li>On a write timeout, if a timeout occurs while writing the distributed batch log</li>
##    <li>On unavailable, it will move to the next host</li>
##  </ul>
## 
##  In all other cases the error will be returned.
## 
##  This policy always uses the query's original consistency level.
## 
##  @public @memberof CassRetryPolicy
## 
##  @return Returns a retry policy that must be freed.
## 
##  @see cass_retry_policy_free()
## 

proc cass_retry_policy_default_new*(): ptr CassRetryPolicy
## *
##  Creates a new downgrading consistency retry policy.
## 
##  <b>Important:</b> This policy may attempt to retry requests with a lower
##  consistency level. Using this policy can break consistency guarantees.
## 
##  This policy will retry in the same scenarios as the default policy, but
##  it will also retry in the following cases:
##  <ul>
##    <li>On a read timeout, if some replicas responded but is lower than
##    required by the current consistency level then retry with a lower
##    consistency level.</li>
##    <li>On a write timeout, Retry unlogged batches at a lower consistency level
##    if at least one replica responded. For single queries and batch if any
##     replicas responded then consider the request successful and swallow the
##     error.</li>
##    <li>On unavailable, retry at a lower consistency if at lease one replica
##    responded.</li>
##  </ul>
## 
##  This goal of this policy is to attempt to save a request if there's any
##  chance of success. A writes succeeds as long as there's a single copy
##  persisted and a read will succeed if there's some data available even
##  if it increases the risk of reading stale data.
## 
##  @public @memberof CassRetryPolicy
## 
##  @return Returns a retry policy that must be freed.
## 
##  @see cass_retry_policy_free()
## 

proc cass_retry_policy_downgrading_consistency_new*(): ptr CassRetryPolicy
## *
##  Creates a new fallthrough retry policy.
## 
##  This policy never retries or ignores a server-side failure. The error
##  is always returned.
## 
##  @public @memberof CassRetryPolicy
## 
##  @return Returns a retry policy that must be freed.
## 
##  @see cass_retry_policy_free()
## 

proc cass_retry_policy_fallthrough_new*(): ptr CassRetryPolicy
## *
##  Creates a new logging retry policy.
## 
##  This policy logs the retry decision of its child policy. Logging is
##  done using CASS_LOG_INFO.
## 
##  @public @memberof CassRetryPolicy
## 
##  @param[in] child_retry_policy
##  @return Returns a retry policy that must be freed. NULL is returned if
##  the child_policy is a logging retry policy.
## 
##  @see cass_retry_policy_free()
## 

proc cass_retry_policy_logging_new*(child_retry_policy: ptr CassRetryPolicy): ptr CassRetryPolicy
## *
##  Frees a retry policy instance.
## 
##  @public @memberof CassRetryPolicy
## 
##  @param[in] policy
## 

proc cass_retry_policy_free*(policy: ptr CassRetryPolicy)
## **********************************************************************************
## 
##  Custom payload
## 
## *********************************************************************************
## *
##  Creates a new custom payload.
## 
##  @public @memberof CassCustomPayload
## 
##  @cassandra{2.2+}
## 
##  @return Returns a custom payload that must be freed.
## 
##  @see cass_custom_payload_free()
## 

proc cass_custom_payload_new*(): ptr CassCustomPayload
## *
##  Frees a custom payload instance.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassCustomPayload
## 
##  @param[in] payload
## 

proc cass_custom_payload_free*(payload: ptr CassCustomPayload)
## *
##  Sets an item to the custom payload.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassCustomPayload
## 
##  @param[in] payload
##  @param[in] name
##  @param[in] value
##  @param[in] value_size
## 

proc cass_custom_payload_set*(payload: ptr CassCustomPayload; name: cstring;
                             value: ptr cass_byte_t; value_size: csize)
## *
##  Same as cass_custom_payload_set(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassCustomPayload
## 
##  @param[in] payload
##  @param[in] name
##  @param[in] name_length
##  @param[in] value
##  @param[in] value_size
## 

proc cass_custom_payload_set_n*(payload: ptr CassCustomPayload; name: cstring;
                               name_length: csize; value: ptr cass_byte_t;
                               value_size: csize)
## *
##  Removes an item from the custom payload.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassCustomPayload
## 
##  @param[in] payload
##  @param[in] name
## 

proc cass_custom_payload_remove*(payload: ptr CassCustomPayload; name: cstring)
## *
##  Same as cass_custom_payload_set(), but with lengths for string
##  parameters.
## 
##  @cassandra{2.2+}
## 
##  @public @memberof CassCustomPayload
## 
##  @param[in] payload
##  @param[in] name
##  @param[in] name_length
## 

proc cass_custom_payload_remove_n*(payload: ptr CassCustomPayload; name: cstring;
                                  name_length: csize)
## **********************************************************************************
## 
##  Consistency
## 
## *********************************************************************************
## *
##  Gets the string for a consistency.
## 
##  @param[in] consistency
##  @return A null-terminated string for the consistency.
##  Example: "ALL", "ONE", "QUORUM", etc.
## 

proc cass_consistency_string*(consistency: CassConsistency): cstring
## **********************************************************************************
## 
##  Write type
## 
## *********************************************************************************
## *
##  Gets the string for a write type.
## 
##  @param[in] write_type
##  @return A null-terminated string for the write type.
##  Example: "BATCH", "SIMPLE", "COUNTER", etc.
## 

proc cass_write_type_string*(write_type: CassWriteType): cstring
## **********************************************************************************
## 
##  Error
## 
## *********************************************************************************
## *
##  Gets a description for an error code.
## 
##  @param[in] error
##  @return A null-terminated string describing the error.
## 

proc cass_error_desc*(error: CassError): cstring
## **********************************************************************************
## 
##  Log
## 
## *********************************************************************************
## *
##  Explicitly wait for the log to flush and deallocate resources.
##  This *MUST* be the last call using the library. It is an error
##  to call any cass_*() functions after this call.
## 
##  @deprecated This is no longer useful and does nothing. Expect this to be
##  removed in a few releases.
## 

proc cass_log_cleanup*()
## *
##  Sets the log level.
## 
##  <b>Note:</b> This needs to be done before any call that might log, such as
##  any of the cass_cluster_*() or cass_ssl_*() functions.
## 
##  <b>Default:</b> CASS_LOG_WARN
## 
##  @param[in] log_level
## 

proc cass_log_set_level*(log_level: CassLogLevel)
## *
##  Sets a callback for handling logging events.
## 
##  <b>Note:</b> This needs to be done before any call that might log, such as
##  any of the cass_cluster_*() or cass_ssl_*() functions.
## 
##  <b>Default:</b> An internal callback that prints to stderr
## 
##  @param[in] data An opaque data object passed to the callback.
##  @param[in] callback A callback that handles logging events. This is
##  called in a separate thread so access to shared data must be synchronized.
## 

proc cass_log_set_callback*(callback: CassLogCallback; data: pointer)
## *
##  Sets the log queue size.
## 
##  <b>Note:</b> This needs to be done before any call that might log, such as
##  any of the cass_cluster_*() or cass_ssl_*() functions.
## 
##  <b>Default:</b> 2048
## 
##  @deprecated This is no longer useful and does nothing. Expect this to be
##  removed in a few releases.
## 
##  @param[in] queue_size
## 

proc cass_log_set_queue_size*(queue_size: csize)
## *
##  Gets the string for a log level.
## 
##  @param[in] log_level
##  @return A null-terminated string for the log level.
##  Example: "ERROR", "WARN", "INFO", etc.
## 

proc cass_log_level_string*(log_level: CassLogLevel): cstring
## **********************************************************************************
## 
##  Inet
## 
## **********************************************************************************
## *
##  Constructs an inet v4 object.
## 
##  @public @memberof CassInet
## 
##  @param[in] address An address of size CASS_INET_V4_LENGTH
##  @return An inet object.
## 

proc cass_inet_init_v4*(address: ptr uint8): CassInet
## *
##  Constructs an inet v6 object.
## 
##  @public @memberof CassInet
## 
##  @param[in] address An address of size CASS_INET_V6_LENGTH
##  @return An inet object.
## 

proc cass_inet_init_v6*(address: ptr uint8): CassInet
## *
##  Returns a null-terminated string for the specified inet.
## 
##  @public @memberof CassInet
## 
##  @param[in] inet
##  @param[out] output A null-terminated string of length CASS_INET_STRING_LENGTH.
## 

proc cass_inet_string*(inet: CassInet; output: cstring)
## *
##  Returns an inet for the specified string.
## 
##  Examples: "127.0.0.1" or "::1"
## 
##  @public @memberof CassInet
## 
##  @param[in] str
##  @param[out] output
## 

proc cass_inet_from_string*(str: cstring; output: ptr CassInet): CassError
## *
##  Same as cass_inet_from_string(), but with lengths for string
##  parameters.
## 
##  @public @memberof CassInet
## 
##  @param[in] str
##  @param[in] str_length
##  @param[out] output
##  @return same as cass_inet_from_string()
## 
##  @see cass_inet_from_string()
## 

proc cass_inet_from_string_n*(str: cstring; str_length: csize; output: ptr CassInet): CassError
## **********************************************************************************
## 
##  Date/Time
## 
## **********************************************************************************
## *
##  Converts a unix timestamp (in seconds) to the Cassandra "date" type. The "date" type
##  represents the number of days since the Epoch (1970-01-01) with the Epoch centered at
##  the value 2^31.
## 
##  @cassandra{2.2+}
## 
##  @param[in] epoch_secs
##  @return the number of days since the date -5877641-06-23
## 

proc cass_date_from_epoch*(epoch_secs: int64): uint32
## *
##  Converts a unix timestamp (in seconds) to the Cassandra "time" type. The "time" type
##  represents the number of nanoseconds since midnight (range 0 to 86399999999999).
## 
##  @cassandra{2.2+}
## 
##  @param[in] epoch_secs
##  @return nanoseconds since midnight
## 

proc cass_time_from_epoch*(epoch_secs: int64): int64
## *
##  Combines the Cassandra "date" and "time" types to Epoch time in seconds.
## 
##  @cassandra{2.2+}
## 
##  @param[in] date
##  @param[in] time
##  @return Epoch time in seconds. Negative times are possible if the date
##  occurs before the Epoch (1970-1-1).
## 

proc cass_date_time_to_epoch*(date: uint32; time: int64): int64
{.pop.}