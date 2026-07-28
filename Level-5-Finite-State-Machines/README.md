# Level 5 — Finite State Machines (FSM)

> **Part of:** [verilog-questions](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · GTKWave · VS Code  
> **Status:** 🔄 In Progress — Day 15 (Q36- Q40 Completed)

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
| Q39 | `Q39-Vending_machine(simple).v` | Vending Machine FSM | ✅ Done |
| Q40 | `q40_Edge_Detector.v` | Edge Detector | ✅ Done |
| Q41 | `q41_*.v` | Serial to Parallel Converter  | ⏳ |
| Q42 | `q42_*.v` | FSM with Datapath  | ⏳ |
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

# Q40 - Rising Edge Detector using Mealy FSM

## 📌 Aim

Design a Rising Edge Detector using a Mealy Finite State Machine (FSM) in Verilog HDL. The circuit generates a one-clock-cycle pulse whenever the input signal transitions from LOW (0) to HIGH (1).

---

## 📖 Theory

A Rising Edge Detector identifies the transition of a digital signal from logic LOW to logic HIGH.

Instead of keeping the output HIGH while the input remains HIGH, the detector generates a single clock pulse only at the instant the rising edge occurs.

Since the output depends on both the current state and the current input, this is implemented using a **Mealy FSM**.

---

## 🛠 Components Used

- Mealy Finite State Machine
- State Register
- Next State Logic
- Combinational Logic
- Asynchronous Reset

---

## 🗂 State Encoding

| State | Meaning |
|-------|---------|
| S0 | Previous Input = 0 |
| S1 | Previous Input = 1 |

---

## 🔄 State Transition Table

| Current State | Input | Next State | Detector |
|---------------|-------|------------|----------|
| S0 | 0 | S0 | 0 |
| S0 | 1 | S1 | 1 |
| S1 | 0 | S0 | 0 |
| S1 | 1 | S1 | 0 |

---

## 📊 State Diagram

```
                 In=1 / Detector=1
          +----------------------+
          |                      |
          ▼                      |
        +------+            +------+
        |  S0  |            |  S1  |
        +------+            +------+
          ▲                    |
          |                    |
          +--------------------+
          In=0 / Detector=0

S0 --In=0--> S0
S1 --In=1--> S1
```

---

## ▶️ Simulation

The simulation verifies:

- Reset initializes the FSM to S0.
- Detector generates a pulse only when the input changes from 0 to 1.
- Detector remains LOW while the input stays HIGH.
- Detector remains LOW during falling edges.
- Multiple rising edges generate multiple pulses.

---

## 🌊 Waveform

*![Q40 Waveform](waveforms/q40_waveform.png)*

---

## 📚 Concepts Learned

- Mealy FSM
- Edge Detection
- Previous Value Storage
- State Register
- Next State Logic
- Output Logic
- Asynchronous Reset

---

## 🎯 Applications

- Button Debouncing
- Digital Pulse Generation
- Event Detection
- Synchronizers
- Communication Interfaces
- Interrupt Generation

---

## 💡 Key Takeaway

A Mealy FSM produces outputs based on both the current state and the current input. This makes it ideal for detecting signal transitions such as rising edges.

---

## 📁 Files

```
q40.v
tb_q40.v
q40.vcd
README.md
```

---

## 🚀 Author

**Yash Gupta**

Learning Verilog HDL through structured RTL design, simulation, FSM design, and digital system implementation.