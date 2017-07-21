# cassandra [![Build Status](https://travis-ci.org/yglukhov/cassandra.svg?branch=master)](https://travis-ci.org/yglukhov/cassandra)
Nim bindings to cassandra db [driver](https://github.com/datastax/cpp-driver)

# Usage
```nim
import asyncdispatch, cassandra

proc test() {.async.} =
    let cluster = newCluster()
    let session = newSession()

    # Add contact points
    cluster.setContactPoints("127.0.0.1")

    # Provide the cluster object as configuration to connect the session
    discard await session.connect(cluster)
    echo "Connected"

    let statement = newStatement("SELECT * FROM system.schema_keyspaces WHERE keyspace_name = ?")
    statement[0] = "system"
    let res = await session.execute(statement)
    let val = res.firstRow.columns["strategy_class"]
    let cl = val.string
    echo "result: ", val
    assert(cl == "org.apache.cassandra.locator.LocalStrategy")

waitFor test()
```
# Lower level
While high level bindings are still in development you can use low level bindings generated directly from `cassandra.h`. You can always take underlying binding type value from higher level api types. As an option, contributions are welcome ;)

Example of mixing two APIs:
```nim
import cassandra
import cassandra/bindings # Low-level bindings
let cluster = newCluster()
let session = newSession()

# Add contact points
discard cass_cluster_set_contact_points(cluster.o, "127.0.0.1") # Note: .o is the low-level type
```
# Dependencies
- [libcassandra](https://github.com/datastax/cpp-driver) - most likely, you'll have to build it yourself
- [libuv](https://github.com/libuv/libuv) - check out your package manager, most likely it will be there
