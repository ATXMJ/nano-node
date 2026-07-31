# ⚙️ Nano Node (C++) - Agent Directives & Build Protocol

## 🛠️ Environment & Prerequisites
- System dependencies: `build-essential`, `g++`, `wget`, `python3`, `zlib1g-dev`, `cmake`, `git`
- Qt5 dependencies are only required if building GUI (`-DNANO_GUI=ON`).

## 🛠️ Justfile & Command Execution Protocol

### ⚠️ Mandatory `just` Command Execution Policy
1. **Strict `just` Delegation**: Always perform building, testing, linting, formatting, and daemon execution via `just` commands. Never directly invoke raw terminal commands (e.g., `cmake --build`, `./build/core_test`, `./format-do.sh`, `git submodule update`) when an existing `just` recipe covers the action.
2. **Dynamic Recipe Creation**: If a task requires executing a command that does not yet exist in `nano-node/Justfile`, add a generalized, reusable recipe to `nano-node/Justfile` *first*, then execute it via `just`.

## ⚡ Command Directives & Examples

For full architecture details, test harness patterns, and debugging options, see [TESTING.md](file:///home/mj/dev/nano-privacy/nano-node/TESTING.md).

Run `just --list` (or inspect [Justfile](file:///home/mj/dev/nano-privacy/nano-node/Justfile)) to see all available targets.

### Common Usage Examples:
- **Submodules & Build:** `just submodules` then `just build` or `just build-tests`
- **Unit / Module Testing:** `just test "block_store.*"`
- **RPC Integration Testing:** `just test-rpc "rpc.account_balance*"`
- **Multi-Node System Testing:** `just test-system`
- **Consensus & Live Election Simulation:** `just test-consensus "*vote*"`
- **Formatting:** `just check-fmt` / `just fmt`

