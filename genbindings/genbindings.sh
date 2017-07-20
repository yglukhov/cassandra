#!/bin/sh

THIS_DIR=$(dirname "$0")
CASSANDRA_H="$THIS_DIR/cassandra.h"
c2nim "$THIS_DIR/bindings.cfg" "$THIS_DIR/cassandra.h"
mv "$THIS_DIR/cassandra.nim" "$THIS_DIR/../cassandra/bindings.nim"
rm -f "$THIS_DIR/bindings.nim" # Extra file
