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
| Q37 | `q37_*.v` | Multi-State FSM | ⏳ |
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

# Q36 - Two-State Toggle Moore FSM

## 📌 Aim

Design a **Two-State Moore Finite State Machine (FSM)** that toggles between two states whenever the `Toggle` input is HIGH.

---

## 📖 Theory

A **Finite State Machine (FSM)** is a sequential circuit whose output depends on its current state and, optionally, the current inputs.

This project implements a **Moore FSM**, where the output depends **only on the current state**.

The FSM has two states:

### STATE_A
- LED = OFF
- Remains here while `Toggle = 0`
- Moves to STATE_B when `Toggle = 1`

### STATE_B
- LED = ON
- Remains here while `Toggle = 0`
- Returns to STATE_A when `Toggle = 1`

The Reset input always initializes the FSM to **STATE_A**.

---

## 🛠️ Components Used

- State Register
- Next-State Logic
- Moore Output Logic
- Sequential Always Block
- Combinational Always Block
- Continuous Assignment

---

## 💻 Verilog Code

```verilog
module q36(
    input wire Toggle,
    input wire Clock,
    input wire Reset,
    output wire LED
);

reg Current_State, Next_State;

parameter STATE_A = 1'b0;
parameter STATE_B = 1'b1;

always @(posedge Clock) begin
    if (Reset)
        Current_State <= STATE_A;
    else
        Current_State <= Next_State;
end

always @(*) begin
    case(Current_State)

        STATE_A:
            if(Toggle)
                Next_State = STATE_B;
            else
                Next_State = STATE_A;

        STATE_B:
            if(Toggle)
                Next_State = STATE_A;
            else
                Next_State = STATE_B;

        default:
            Next_State = STATE_A;

    endcase
end

assign LED = Current_State;

endmodule
```

---

## ▶️ Simulation

The simulation verifies that:

- Reset initializes the FSM to STATE_A.
- Toggle = 0 keeps the FSM in its current state.
- Toggle = 1 switches between STATE_A and STATE_B.
- LED changes only when the state changes.
- State transitions occur only on the rising edge of the clock.

---

## 🌊 Waveform

> ![Q36 Waveform](waveforms/q36_waveform.png)

Example:

```
Reset = 1

↓

STATE_A

↓

Toggle = 1

↓

Clock ↑

↓

STATE_B

↓

LED = 1

↓

Toggle = 1

↓

Clock ↑

↓

STATE_A

↓

LED = 0
```

---

## 📚 Concepts Learned

- Finite State Machines
- Moore FSM
- State Encoding
- State Register
- Next-State Logic
- Output Logic
- Sequential Logic
- Combinational Logic
- Non-blocking Assignments (`<=`)
- Continuous Assignment (`assign`)
- State Transitions

---

## 🎯 Applications

- Traffic Light Controllers
- Vending Machines
- Elevators
- Washing Machines
- UART Controllers
- Communication Protocols
- Embedded Controllers
- FPGA & ASIC Design

---

## 💡 Key Takeaway

A Moore FSM separates hardware into three logical blocks:

1. **State Register** – stores the current state.
2. **Next-State Logic** – decides where to move next.
3. **Output Logic** – generates outputs from the current state.

This three-block architecture forms the foundation of almost every hardware controller.

---

## 📁 Files

```
Level-5-Finite-State-Machines/
│
├── README.md
│
└── Q36-Two-State-Toggle-FSM/
    ├── q36.v
    ├── tb_q36.v
    ├── q36.vcd
    ├── waveform.png
    └── README.md
```

---

## 🚀 Author

**Yash Gupta**

Learning Verilog HDL from scratch through hands-on digital design projects, progressing from basic logic gates to industry-standard RTL design and Finite State Machines.