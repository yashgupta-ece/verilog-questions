# Level 5 — Finite State Machines (FSM)

> **Part of:** [verilog-questions](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · GTKWave · VS Code  
> **Status:** 🔄 In Progress — Day 13 (Q36- Q38 Completed)

---

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
| Q39 | `q39_*.v` | Sequence Detector | ⏳ |
| Q40 | `q40_*.v` | Advanced FSM | ⏳ |

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

# Q38 - Sequence Detector (101) using Moore FSM

## 📌 Aim

Design a **Moore Finite State Machine (FSM)** in Verilog HDL that detects the binary sequence **101**. The output becomes HIGH only after the complete sequence has been received.

---

## 📖 Theory

A **Sequence Detector** is a sequential circuit that recognizes a predefined bit pattern from a serial input stream.

This design implements an **Overlapping Moore FSM**, meaning that after detecting one sequence, the FSM continues tracking possible overlapping occurrences instead of restarting completely.

Target Sequence:

```
101
```

---

## State Description

| State | Meaning | Detector |
|------|----------|----------|
| S0 | No bits matched | 0 |
| S1 | Matched "1" | 0 |
| S2 | Matched "10" | 0 |
| S3 | Matched "101" | 1 |

---

## State Transition Table

| Current State | X = 0 | X = 1 |
|--------------|-------|-------|
| S0 | S0 | S1 |
| S1 | S2 | S1 |
| S2 | S0 | S3 |
| S3 | S2 | S1 |

---

## 🛠 Components Used

- State Register
- Next-State Logic
- Moore Output Logic
- Sequential Always Block
- Combinational Always Block
- Continuous Assignment

---

## 💻 Verilog Code

```verilog
// q38.v
```

(Place your RTL here.)

---

## ▶️ Simulation

Simulation verifies:

- Reset operation
- Sequence detection (101)
- Multiple detections
- Overlapping sequence detection
- Correct state transitions

---

## 🌊 Waveform

> ![Q38 Waveform](waveforms/q38_waveform.png)

Example:

```
Input:

1 0 1 0 1

Detected:

0 0 1 0 1
```

The detector successfully identifies overlapping occurrences of **101**.

---

## 📚 Concepts Learned

- Moore FSM
- Sequence Detector
- Overlapping Sequence Detection
- State Encoding
- State Register
- Next-State Logic
- Output Logic
- FSM Design Methodology

---

## 🎯 Applications

- UART Receivers
- Pattern Detection
- Packet Detection
- Communication Protocols
- Digital Locks
- Embedded Controllers
- FPGA Control Logic

---

## 💡 Key Takeaway

A sequence detector remembers previously received bits using states instead of storing the entire input stream.

Each state represents the **longest matched prefix** of the target sequence, making FSMs efficient for real-time pattern detection.

---

## 📁 Files

```
q38.v
tb_q38.v
q38.vcd
waveform.png
README.md
```

---

## 🚀 Author

**Yash Gupta**

Learning Verilog HDL from scratch through hands-on RTL design projects, progressing from combinational logic to industry-style Finite State Machines.