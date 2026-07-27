# nano-node Justfile

default: build

# Initialize all git submodules (required before first build)
submodules:
    git submodule update --init --recursive

# Build standard debug node executable
build jobs=num_cpus():
    mkdir -p build
    cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DPORTABLE=ON -DACTIVE_NETWORK=nano_live_network -DNANO_TEST=OFF -DNANO_GUI=OFF ..
    cmake --build build --parallel {{jobs}}

# Build with test binaries enabled
build-tests jobs=num_cpus():
    mkdir -p build
    cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DPORTABLE=ON -DACTIVE_NETWORK=nano_dev_network -DNANO_TEST=ON -DNANO_GUI=OFF ..
    cmake --build build --parallel {{jobs}}

# Run core test suite
test: build-tests
    ./build/core_test

# Run RPC test suite
test-rpc: build-tests
    ./build/rpc_test

# Check code formatting without modifying files
check-fmt:
    ./format-check.sh

# Apply code formatting (requires clang-format 17 & cmake-format 0.6.13)
fmt:
    ./format-do.sh

# Run CI build script for a specific target (e.g. `just ci-build node` or `just ci-build core_test`)
ci-build target="node":
    ./ci/build.sh {{target}}

