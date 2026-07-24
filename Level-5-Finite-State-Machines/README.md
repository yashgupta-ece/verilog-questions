# Level 5 — Finite State Machines (FSM)

> **Part of:** [verilog-questions](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · GTKWave · VS Code  
> **Status:** 🔄 In Progress — Day 11 (Q36 Completed)

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
| Q37 | `q37_*.v` | Multi-State FSM | ✅ Done |
| Q38 | `q38_*.v` | FSM Controller | ⏳ |
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

# Q37 - Three-State Moore Finite State Machine (FSM)

## 📌 Aim

Design a **Three-State Moore Finite State Machine (FSM)** in Verilog HDL that cycles through three states based on an input signal `X`. The output `LED` depends **only on the current state**, making it a **Moore FSM**.

---

## 📖 Theory

A **Finite State Machine (FSM)** is a sequential circuit that stores its current state and changes state based on clock edges and input conditions.

This design implements a **Moore FSM**, where the output depends only on the current state and **not directly on the input**.

The FSM consists of three states:

| State | LED Output |
|-------|------------|
| S0 | 0 |
| S1 | 0 |
| S2 | 1 |

### State Transition Diagram

```
          X=1            X=1
     +-----------> S1 -----------> S2
     |              ^              |
     |              |              |
     | X=0          | X=0          | X=0
     |              |              |
     |              +--------------+
     |                     |
     +------ S0 <----------+
             ^
             |
             +----- X=1 (from S2)
```

Or as a transition table:

| Current State | X = 0 | X = 1 |
|--------------|-------|-------|
| S0 | S0 | S1 |
| S1 | S1 | S2 |
| S2 | S2 | S0 |

The Reset signal initializes the FSM to **S0**.

---

## 🛠️ Components Used

- State Register
- Next-State Logic
- Moore Output Logic
- Sequential Always Block
- Combinational Always Block
- Continuous Assignment (`assign`)

---

## 💻 Verilog Code

```verilog
module q37 (
    input wire Clock,
    input wire Reset,
    input wire X,
    output wire LED
);

reg [1:0] Current_State, Next_State;

parameter [1:0]
    S0 = 2'b00,
    S1 = 2'b01,
    S2 = 2'b10;

// State Register
always @(posedge Clock) begin
    if (Reset)
        Current_State <= S0;
    else
        Current_State <= Next_State;
end

// Next-State Logic
always @(*) begin
    case(Current_State)

        S0:
            if(X)
                Next_State = S1;
            else
                Next_State = S0;

        S1:
            if(X)
                Next_State = S2;
            else
                Next_State = S1;

        S2:
            if(X)
                Next_State = S0;
            else
                Next_State = S2;

        default:
            Next_State = S0;

    endcase
end

// Moore Output Logic
assign LED = (Current_State == S2);

endmodule
```

---

## ▶️ Simulation

The simulation verifies the following cases:

- Reset initializes the FSM to **S0**
- FSM remains in the same state when `X = 0`
- S0 → S1 transition
- S1 → S2 transition
- S2 → S0 transition
- LED becomes HIGH only in **S2**

---

## 🌊 Waveform

> ![Q37 Waveform](waveforms/q37_waveform.png)

Example sequence:

```
Reset

↓

S0 (LED = 0)

↓

X = 1

↓

S1 (LED = 0)

↓

X = 1

↓

S2 (LED = 1)

↓

X = 1

↓

S0 (LED = 0)
```

---

## 📚 Concepts Learned

- Finite State Machines (FSM)
- Moore FSM
- State Encoding
- State Register
- Next-State Logic
- Output Logic
- State Transition Table
- Sequential Logic
- Combinational Logic
- Continuous Assignment
- Safe Default State

---

## 🎯 Applications

- Traffic Light Controllers
- Elevator Controllers
- Vending Machines
- Digital Sequence Controllers
- Embedded Systems
- Communication Protocols
- FPGA and ASIC Control Logic

---

## 💡 Key Takeaway

A Moore FSM separates the design into three logical blocks:

1. **State Register** – Stores the current state.
2. **Next-State Logic** – Determines the next state based on the current state and input.
3. **Output Logic** – Generates outputs using only the current state.

This modular architecture improves readability, debugging, and scalability while following industry-standard RTL design practices.

---

## 📁 Files

```
q37.v
tb_q37.v
q37.vcd
README.md
waveform.png
```

---

## 🚀 Author

**Yash Gupta**

Learning Verilog HDL from scratch through hands-on digital design projects, progressing from basic combinational circuits to industry-style RTL design and Finite State Machines.