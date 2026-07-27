# ⚙️ Nano Node (C++) - Agent Directives & Build Protocol

## 🛠️ Environment & Prerequisites
- System dependencies: `build-essential`, `g++`, `wget`, `python3`, `zlib1g-dev`, `cmake`, `git`
- Qt5 dependencies are only required if building GUI (`-DNANO_GUI=ON`).

## ⚡ Just Quick Commands
If `just` is installed, you can use these shortcuts:
- `just submodules` : Initialize git submodules
- `just build`      : Build standard debug node
- `just test`       : Build and run core unit tests
- `just test-rpc`   : Build and run RPC test suite
- `just check-fmt`  : Check formatting without modifying files
- `just fmt`        : Format C++ and CMake sources

## 🔄 Submodule Initialization
Submodules must be initialized before the first build:
```bash
git submodule update --init --recursive
```

## 🏗️ Build Commands

### Standard Debug Build
```bash
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Debug -DPORTABLE=ON -DACTIVE_NETWORK=nano_live_network -DNANO_TEST=OFF -DNANO_GUI=OFF ..
cmake --build . --parallel $(nproc)
```

### CI Build Script
```bash
# Build node daemon
./ci/build.sh node

# Build test binaries
NANO_TEST=ON NANO_NETWORK=dev NANO_GUI=OFF ./ci/build.sh core_test
```

## 🧪 Testing Protocol
Run compiled test binaries from the `build/` output directory:
```bash
# Run core test suite
./build/core_test

# Run RPC test suite
./build/rpc_test
```

## 🧹 Formatting & Code Quality
- Check formatting without modifying files:
  ```bash
  ./format-check.sh
  ```
- Format C++ and CMake sources:
  ```bash
  ./format-do.sh
  ```
  *(Requires `clang-format` v17 and `cmake-format` v0.6.13)*
