import os
import ../cassandra/bindings
import ../cassandra/linker_options

var host = getEnv("CASSANDRA_HOST")
if host.len == 0: host = "127.0.0.1"

let cluster = cass_cluster_new()
let session = cass_session_new()

# Add contact points
discard cass_cluster_set_contact_points(cluster, host)

# Provide the cluster object as configuration to connect the session
let connect_future = cass_session_connect(session, cluster)

# This operation will block until the result is ready
var rc = cass_future_error_code(connect_future)
if rc == CASS_OK:
    let statement = cass_statement_new("select * from system_schema.keyspaces where keyspace_name = ?", 1)
    discard cass_statement_bind_string(statement, 0, "system")
    let queryFuture = cass_session_execute(session, statement)
    rc = cass_future_error_code(queryFuture)
    if rc == CASS_OK:
        let res = cass_future_get_result(queryFuture)
        let row = cass_result_first_row(res)
        let val = cass_row_get_column_by_name(row, "replication")
        doAssert(cass_value_type(val) == CASS_VALUE_TYPE_MAP)
    else:
        echo "Select result: ", cass_error_desc(rc)
        doAssert(false)
else:
    echo "Connect result: ", cass_error_desc(rc)
    doAssert(false)

cass_future_free(connect_future)
cass_session_free(session)
cass_cluster_free(cluster)
