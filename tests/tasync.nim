import os, asyncdispatch
import ../cassandra/asyncwrapper

proc test() {.async.} =
    var host = getEnv("CASSANDRA_HOST")
    if host.len == 0: host = "127.0.0.1"

    let cluster = newCluster()
    let session = newSession()

    # Add contact points
    cluster.setContactPoints(host)

    # Provide the cluster object as configuration to connect the session
    discard await session.connect(cluster)
    echo "Connected"

    let statement = newStatement("select * from system_schema.keyspaces where keyspace_name = ?")
    statement[0] = "system"
    let res = await session.execute(statement)
    let val = res.firstRow.columns["replication"]
    let cl = val.getMapValue("class").string
    echo "result: ", cl
    doAssert(cl == "org.apache.cassandra.locator.LocalStrategy")

waitFor test()
