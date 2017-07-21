set -e

apt-get update
apt-get install -y cmake libuv0.10-dev g++

git clone --depth 1 https://github.com/datastax/cpp-driver
mkdir cpp-driver/build
cd cpp-driver/build
cmake ..
make install
cd ../..

nimble install -yd

export CASSANDRA_HOST=$(cat ./scylla_host)
echo "CASSANDRA_HOST: $CASSANDRA_HOST"

nim c -r tests/tbindings.nim
nim c -r tests/tasync.nim
