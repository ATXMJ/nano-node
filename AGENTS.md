# ⚙️ Nano Node (C++) - Agent Directives & Build Protocol

## 🛠️ Environment & Prerequisites
- System dependencies: `build-essential`, `g++`, `wget`, `python3`, `zlib1g-dev`, `cmake`, `git`
- Qt5 dependencies are only required if building GUI (`-DNANO_GUI=ON`).

## 🛠️ Justfile & Command Execution Protocol

### ⚠️ Mandatory `just` Command Execution Policy
1. **Strict `just` Delegation**: Always perform building, testing, linting, formatting, and daemon execution via `just` commands. Never directly invoke raw terminal commands (e.g., `cmake --build`, `./build/core_test`, `./format-do.sh`, `git submodule update`) when an existing `just` recipe covers the action.
2. **Dynamic Recipe Creation**: If a task requires executing a command that does not yet exist in `nano-node/Justfile`, add a generalized, reusable recipe to `nano-node/Justfile` *first*, then execute it via `just`.

## ⚡ Available `just` Command Directives

### 🔄 Submodule Initialization
Initialize submodules prior to first build:
```bash
just submodules
```

### 🏗️ Building
- **Standard Debug Node Build:**
  ```bash
  just build
  ```
- **Build Node with Test Executables Enabled (`core_test`, `rpc_test`):**
  ```bash
  just build-tests
  ```
- **Run CI Build Pipeline:**
  ```bash
  just ci-build node
  just ci-build core_test
  ```

### 🧪 Testing
- **Run Core GoogleTest Suite:**
  ```bash
  just test
  ```
- **Run RPC Test Suite:**
  ```bash
  just test-rpc
  ```

### 🧹 Formatting & Code Quality
- **Verify Formatting (Read-Only):**
  ```bash
  just check-fmt
  ```
- **Apply Auto-Formatting:**
  ```bash
  just fmt
  ```
  *(Requires `clang-format` v17 and `cmake-format` v0.6.13)*

