# 🧪 Testing & Network Simulation Guide

This document outlines the testing architecture, test harnesses, and execution procedures for `nano-node`.

---

## 📐 Testing Architecture Overview

`nano-node` tests run under the `nano_dev_network` configuration when built with `-DNANO_TEST=ON`. This configuration enables:
- Fast genesis block creation with pre-configured dev keys.
- Reduced PoW thresholds for instantaneous block generation during tests.
- Accelerated election timing and voting rounds.
- In-memory node transport options to eliminate real socket overhead when testing consensus.

---

## 🛠️ Executing Tests with `just`

All test suites are managed via `just` targets defined in [Justfile](file:///home/mj/dev/nano-privacy/nano-node/Justfile).

### 1. Core Unit & Module Tests (`core_test`)
Runs unit tests for core primitives, block stores, cryptography, wallet state, and ledger processing.

```bash
# Run entire core suite
just test

# Run specific unit test or class
just test "block_store.*"
just test "account_info.*"
```

### 2. RPC Integration Tests (`rpc_test`)
Tests node RPC endpoints against active dev-network node instances.

```bash
# Run entire RPC test suite
just test-rpc

# Run filtered RPC tests
just test-rpc "rpc.account_balance*"
```

### 3. Multi-Node System Integration Tests
Exercises interaction between multiple nodes using the in-memory system harness (`nano::test::system`).

```bash
# Run all system tests
just test-system

# Run specific system fixture test
just test-system "latch"
```

### 4. Live Consensus & Election Network Simulations
Simulates voting, representative weight distribution, fork resolution, and election propagation.

```bash
# Run all consensus/election tests
just test-consensus

# Run filtered consensus tests
just test-consensus "*vote*"
```

---

## 🏗️ Test Harnesses & Fixtures

### `nano::test::system` Harness
Located in `nano/core_test/test_util.hpp`, the `system` harness allows creating multiple virtual nodes within a single test binary:

```cpp
#include <nano/core_test/test_util.hpp>

TEST (system, multi_node_example)
{
    nano::test::system system;
    // Spawns node 1 on dev network
    auto node1 = system.add_node ();
    // Spawns node 2 connected to node 1
    auto node2 = system.add_node ();

    // Assert peers discovered each other
    ASSERT_TIMELY (5s, node1->network.size () == 1);
}
```

### Key Assertions & Helpers
- `ASSERT_TIMELY(timeout, condition)`: Periodically polls `condition` up to `timeout` before failing. Essential for asynchronous network and election assertions.
- `nano::dev::genesis`: Provides pre-mined genesis account and keypairs for dev network transaction construction.

---

## 🔍 Privacy Protocol Testing Guidelines

When adding privacy features (e.g. stealth addresses, zero-knowledge proofs, blinded commitment stores):

1. **Unit Verification**:
   - Add module-level tests under `nano/core_test/` covering key derivation, commitment construction, and validation functions.
2. **Ledger & State Tests**:
   - Verify state transitions when processing privacy-enabled blocks against LMDB/RocksDB stores.
3. **Consensus & Propagation**:
   - Use `just test-consensus` to verify privacy blocks are correctly validated, broadcast, and voted on by representative nodes without breaking consensus.

---

## 🐞 Advanced Debugging Options

Pass additional GoogleTest flags directly through `just` filter arguments:

```bash
# Break on failure for gdb/lldb attachment
just test "block_store.* --gtest_break_on_failure"

# Repeat a flaky test 10 times
just test "node.election* --gtest_repeat=10"
```
