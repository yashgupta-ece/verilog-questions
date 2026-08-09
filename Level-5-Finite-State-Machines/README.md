# Level 5 — Finite State Machines (FSM)

> **Part of:** [verilog-questions](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · GTKWave · VS Code  
> **Status:** 🔄 In Progress — Day 17 (Q36- Q42 Completed)

## What This Level Covers

Introducing **Finite State Machines (FSMs)** — digital circuits capable of remembering previous states and making decisions based on both current inputs and stored state information.

Unlike basic sequential circuits that simply store data, FSMs are **control circuits**. They are used whenever hardware needs to follow a sequence of operations or react differently depending on what happened previously.

DSA equivalent: State transitions, graphs, finite automata, transition tables

Verilog equivalent: State registers, next-state logic, Moore FSMs, Mealy FSMs, state encoding

### Three rules that never change in this level

- Every FSM has a **State Register**
- Every FSM requires **Next-State Logic**
- Every FSM produces outputs using either **Moore** or **Mealy** output logic

---

## Standard FSM Architecture

```
             Inputs
                │
                ▼
    ┌────────────────────────┐
    │   Next-State Logic     │
    │     always @(*)        │
    └──────────┬─────────────┘
               │
          Next State
               │
               ▼
    ┌────────────────────────┐
Clk │    State Register      │
───►│ always @(posedge clk)  │
    └──────────┬─────────────┘
               │
         Current State
               │
               ▼
    ┌────────────────────────┐
    │     Output Logic       │
    │ assign / always @(*)   │
    └──────────┬─────────────┘
               │
             Outputs
```

---

## Progress

| # | File | What It Does | Status |
|---|------|-------------|--------|
| Q36 | `Q36-Two-State-Toggle-FSM.v` | Two-State Toggle Moore FSM | ✅ Done |
| Q37 | `q37_Multi-State FSM.v` | Multi-State FSM | ✅ Done |
| Q38 | `q38_FSM Controller.v` | FSM Controller | ✅ Done |
| Q39 | `Q39-Vending_machine(simple).v` | Vending Machine FSM | ✅ Done |
| Q40 | `q40_Edge_Detector.v` | Edge Detector | ✅ Done |
| Q41 | `Q41-Serial_to_Parallel_Converter.v` | Serial to Parallel Converter  | ✅ Done |
| Q42 | `q42_*.v` | FSM with Datapath  | ✅ Done |
| Q43 | `q43_*.v` | Smart Traffic Controller — 4 states + emergency override | ⏳ |
| Q44 | `q44_*.v` | Parking Lot Controller | ⏳ |
| Q45 | `q45_*.v` | UART Transmitter FSM | ⏳ |

---

## How to Run

```bash
iverilog -o output q36.v tb_q36.v
vvp output
gtkwave q36.vcd
```

GTKWave becomes even more important in this level because FSMs continuously change state based on the clock and input conditions.

Useful tips:

- Display current state and next state
- Watch state transitions on every positive clock edge
- Verify reset behavior
- Compare state transitions with your state diagram
- Predict the next state before simulation

---

# Q42 — FSM with Datapath

## 📌 Overview

This project implements a **Finite State Machine (FSM) combined with a 4-bit counter datapath** in Verilog HDL.

The FSM acts as the **control unit**, deciding whether the datapath counter should be enabled or stopped.

The project introduces an important RTL design concept:

> **Control Logic + Datapath = Complete Hardware System**

The FSM generates an `enable` signal, which is internally connected to the counter datapath.

---

## 🎯 Objective

- Understand how an FSM controls a datapath.
- Separate control logic from datapath logic.
- Implement a two-state FSM.
- Generate an `enable` control signal using output logic.
- Implement a 4-bit counter datapath.
- Connect multiple Verilog modules using a Top module.
- Understand hierarchical RTL design.
- Verify the complete design using a testbench and GTKWave.

---

## 🛠️ Features

- 2-State FSM
- `IDLE` and `RUNNING` states
- Start/Stop control
- FSM-generated Enable signal
- 4-bit Counter Datapath
- Asynchronous Reset
- Hierarchical Module Design
- Separate FSM and Datapath
- Top-Level Module Integration
- Testbench Verification

---

## 📂 Inputs

| Signal | Width | Description |
| ------ | ----- | ----------- |
| Clock | 1 | System Clock |
| Reset | 1 | Asynchronous Reset |
| Start | 1 | Starts the counter operation |
| Stop | 1 | Stops the counter operation |

---

## 📂 Outputs

| Signal | Width | Description |
| ------ | ----- | ----------- |
| Count | 4 | Current value of the counter |

---

## ⚙️ Working Principle

The design is divided into three major sections:

1. **FSM**
2. **Datapath**
3. **Top Module**

---

### 1. FSM

The FSM contains two states:

```text
IDLE
RUNNING
````

### IDLE State

```text
enable = 0
```

The counter remains stopped.

If:

```text
Start = 1
```

the FSM transitions to `RUNNING` on the next rising clock edge.

Otherwise, it remains in `IDLE`.

---

### RUNNING State

```text
enable = 1
```

The counter is enabled.

If:

```text
Stop = 1
```

the FSM transitions back to `IDLE` on the next rising clock edge.

Otherwise, it remains in `RUNNING`.

---

## 🔄 State Transition

```text
                 Start = 1
              ┌─────────────┐
              │             ▼
           ┌──────┐     ┌─────────┐
           │ IDLE │     │ RUNNING │
           │      │     │         │
           │ en=0 │     │  en=1   │
           └──────┘     └─────────┘
              ▲             │
              │             │
              └─────────────┘
                 Stop = 1
```

---

## 2. Datapath

The datapath contains a **4-bit counter**.

The counter operates according to the `enable` signal generated by the FSM.

### When Reset is asserted:

```text
count = 0000
```

### When enable = 1:

```text
count = count + 1
```

### When enable = 0:

```text
count holds its current value
```

The counter changes only on the appropriate **rising edge of the clock**.

---

## 3. Top Module

The Top module connects the FSM and datapath together.

```text
                 TOP MODULE
                     │
          ┌──────────┴──────────┐
          │                     │
          ▼                     ▼
        FSM                 DATAPATH
          │                     ▲
          │      enable         │
          └─────────────────────┘
                                │
                              count
```

The internal connection is:

```verilog
wire enable;
```

The FSM produces `enable`, while the datapath receives it.

---

## 🧠 Internal Components

### FSM

* State Register
* Next-State Logic
* Output Logic
* `IDLE` State
* `RUNNING` State

### Datapath

* 4-bit Counter
* Enable Control
* Reset Logic

### Top Module

* FSM Instance
* Datapath Instance
* Internal `enable` Wire

---

## 🔗 Module Hierarchy

```text
Q42_tb
   │
   ▼
Q42_top
   │
   ├──────────────► Q42_FSM
   │                    │
   │                    │ enable
   │                    ▼
   └──────────────► Q42-DATAPATH
                        │
                        ▼
                      count
```

---

## 📂 Project Files

| File             | Description                                  |
| ---------------- | -------------------------------------------- |
| `Q42_FSM.v`      | FSM control logic                            |
| `Q42-DATAPATH.v` | 4-bit counter datapath                       |
| `Q42_top.v`      | Top-level module connecting FSM and datapath |
| `Q42_tb.v`       | Testbench                                    |
| `q42.vcd`        | GTKWave waveform                             |

---

# Waveform

The waveform verifies the relationship between:

```text
Start → FSM State → enable → Counter
```

Expected behavior:

```text
Reset
  ↓
IDLE
enable = 0
count = 0
  ↓
Start = 1
  ↓
Rising Clock Edge
  ↓
RUNNING
enable = 1
  ↓
Counter increments
  ↓
Stop = 1
  ↓
Rising Clock Edge
  ↓
IDLE
enable = 0
  ↓
Counter stops
```

---

## 🧪 Test Cases

### Test Case 1

✔ Reset Verification

* Reset is asserted.
* FSM enters `IDLE`.
* `enable = 0`.
* Counter is cleared to zero.

---

### Test Case 2

✔ Start Operation

* `Start` is asserted.
* FSM transitions from `IDLE` to `RUNNING` on a rising clock edge.
* `enable` becomes HIGH.

---

### Test Case 3

✔ Counter Operation

* FSM remains in `RUNNING`.
* `enable = 1`.
* Counter increments on rising clock edges.

Expected behavior:

```text
0 → 1 → 2 → 3 → 4 → ...
```

---

### Test Case 4

✔ Stop Operation

* `Stop` is asserted.
* FSM transitions from `RUNNING` to `IDLE` on a rising clock edge.
* `enable` becomes LOW.
* Counter stops incrementing.

---

### Test Case 5

✔ Reset During Operation

* Counter is running.
* Reset is asserted.
* FSM returns to `IDLE`.
* Counter is cleared.

---

## 📊 Simulation

Simulation Tools:

* Icarus Verilog
* GTKWave
* VS Code

### Compile

```bash
iverilog -o q42 Q42_FSM.v Q42_top.v Q42-DATAPATH.v Q42_tb.v
```

### Run

```bash
vvp q42
```

### View Waveform

```bash
gtkwave q42.vcd
```

---

## 📚 Concepts Learned

* Finite State Machines
* Moore FSM
* State Registers
* Next-State Logic
* Output Logic
* Sequential Logic
* Combinational Logic
* Datapath Design
* FSM and Datapath Separation
* Hierarchical RTL Design
* Module Instantiation
* Named Port Mapping
* `wire` vs `reg`
* Non-Blocking Assignments (`<=`)
* Testbench Design
* Icarus Verilog Simulation
* GTKWave Waveform Analysis

---

## 💡 Key Learning

The main concept learned from Q42 is that an FSM does not necessarily perform the actual data operation.

Instead:

```text
              CONTROL
                 │
                 ▼
               FSM
                 │
              enable
                 │
                 ▼
              DATAPATH
                 │
                 ▼
               count
```

The **FSM controls what the datapath should do**, while the **datapath performs the actual operation**.

This separation between control logic and datapath is a fundamental concept in RTL design.

---

## 🚀 Future Improvements

* 8-bit Up/Down Counter
* Multiple counter modes
* Counter overflow detection
* Pause/Resume functionality
* Additional FSM states
* Parameterized counter width
* More complex control/datapath architectures
* Integration with larger RTL systems

---

## 🏁 Conclusion

This project demonstrates how a **Finite State Machine can be combined with a datapath to create a complete hierarchical RTL design**.

The FSM controls the counter through an `enable` signal, while the datapath performs the counting operation.

Q42 is an important step from designing individual digital blocks toward designing **larger modular RTL systems**.

---

## 🚀 Author

Yash Gupta

Learning Verilog HDL through structured RTL design, simulation, FSM design, and digital system implementation.