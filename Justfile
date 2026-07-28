# nano-node Justfile

default: build

# Initialize all git submodules (required before first build)
submodules:
    git submodule update --init --recursive

# Build standard debug node executable (e.g. `just build` or `just build 8`)
build jobs=num_cpus():
    mkdir -p build
    cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DPORTABLE=ON -DACTIVE_NETWORK=nano_live_network -DNANO_TEST=OFF -DNANO_GUI=OFF ..
    cmake --build build --parallel {{jobs}}

# Build node with test binaries enabled (`core_test`, `rpc_test`)
build-tests jobs=num_cpus():
    mkdir -p build
    cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DPORTABLE=ON -DACTIVE_NETWORK=nano_dev_network -DNANO_TEST=ON -DNANO_GUI=OFF ..
    cmake --build build --parallel {{jobs}}

# Run core GoogleTest suite with optional filter (e.g. `just test` or `just test "block_store.*"`)
test filter="": build-tests
    ./build/core_test {{ if filter != "" { "--gtest_filter=" + filter } else { "" } }}

# Run RPC integration test suite with optional filter (e.g. `just test-rpc "rpc.account_balance*"`)
test-rpc filter="": build-tests
    ./build/rpc_test {{ if filter != "" { "--gtest_filter=" + filter } else { "" } }}

# Run in-memory multi-node system integration tests (e.g. `just test-system` or `just test-system "latch"`)
test-system filter="*": build-tests
    ./build/core_test --gtest_filter=system.{{filter}}

# Run live election & consensus simulation tests (e.g. `just test-consensus` or `just test-consensus "*vote*"`)
test-consensus filter="*": build-tests
    ./build/core_test --gtest_filter=node.election*{{filter}}

# Check code formatting without modifying files (requires clang-format 17 & cmake-format 0.6.13)
check-fmt:
    ./format-check.sh

# Apply code formatting in-place (requires clang-format 17 & cmake-format 0.6.13)
fmt:
    ./format-do.sh

# Run CI build script for a target (e.g. `just ci-build node` or `just ci-build core_test`)
ci-build target="node":
    ./ci/build.sh {{target}}

