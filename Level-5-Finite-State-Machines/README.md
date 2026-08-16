# Level 5 — Finite State Machines (FSM)

> **Part of:** [verilog-questions](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · GTKWave · VS Code  
> **Status:** 🔄 In Progress — Day 19 (Q36- Q44 Completed)

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
| Q43 | `Q43_TC.v` | Smart Traffic Controller — 4 states + emergency override | ✅ Done |
| Q44 | `q44_PL.v` | Parking Lot Controller | ✅ Done |
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

# Q44 — Parking Lot Controller FSM

What it does: A Moore FSM-based parking lot controller with 4 states — EMPTY, OCCUPIED, FULL, and a dedicated EMERGENCY state. The controller tracks the parking lot status based on vehicle entry and exit events and provides an emergency override that temporarily takes the system into the EMERGENCY state.

Real world use: Parking management systems use digital controllers and sensors to monitor vehicle entry and exit, determine parking availability, and control gates, indicators, and emergency handling systems.

---

# Objective

The main objectives of this project are:

Implement a multi-state FSM.

Track parking lot status using FSM states.

Handle vehicle entry and exit events.

Implement an emergency override mechanism.

Use Moore output logic to indicate the current parking status.

Practice state registers and next-state logic.

Understand priority between emergency and normal parking operations.

Understand the interaction between sequential and combinational logic.

---

# 📂 Inputs

| Signal | Width | Description |
|---|---:|---|
| Clock | 1 | System clock |
| Reset | 1 | Asynchronous reset |
| Entry | 1 | Indicates a vehicle entering the parking lot |
| Exit | 1 | Indicates a vehicle leaving the parking lot |
| Emergency | 1 | Activates emergency override |

---

# 📂 Outputs

| Signal | Width | Description |
|---|---:|---|
| Empty_Out | 1 | Indicates that the parking lot is empty |
| Occupied_Out | 1 | Indicates that the parking lot is occupied |
| Full_Out | 1 | Indicates that the parking lot is full |
| Emergency_Out | 1 | Indicates that the controller is in emergency mode |

---

# Internal Registers

The design uses two important state registers:

### Current State

reg [1:0] current_state;

### Next State
reg [1:0] next_state;


# Code:
module Q44 (
    input wire Clock, Reset, Entry, Exit, Emergency,
    output reg Empty_Out, Occupied_Out, Full_Out, Emergency_Out
);

    reg [1:0] current_state;
    reg [1:0] next_state;

    parameter Empty     = 2'b00;
    parameter Occupied  = 2'b01;
    parameter Full      = 2'b10;
    parameter EMERGENCY = 2'b11;

    // State register
    always @(posedge Clock or posedge Reset) begin
        if (Reset) begin
            current_state <= Empty;
        end
        else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;

        if (Emergency) begin
            next_state = EMERGENCY;
        end
        else begin
            case (current_state)

                Empty: begin
                    if (Entry)
                        next_state = Occupied;
                end

                Occupied: begin
                    if (Entry)
                        next_state = Full;
                    else if (Exit)
                        next_state = Empty;
                end

                Full: begin
                    if (Exit)
                        next_state = Occupied;
                end

                EMERGENCY: begin
                    next_state = Empty;
                end

                default:
                    next_state = current_state;

            endcase
        end
    end

    // Moore output logic
    always @(*) begin

        Empty_Out     = 1'b0;
        Occupied_Out  = 1'b0;
        Full_Out      = 1'b0;
        Emergency_Out = 1'b0;

        case (current_state)

            Empty:
                Empty_Out = 1'b1;

            Occupied:
                Occupied_Out = 1'b1;

            Full:
                Full_Out = 1'b1;

            EMERGENCY:
                Emergency_Out = 1'b1;

            default: begin
                Empty_Out     = 1'b0;
                Occupied_Out  = 1'b0;
                Full_Out      = 1'b0;
                Emergency_Out = 1'b0;
            end

        endcase
    end

endmodule
---
# State Diagram:
                         Entry
              ┌─────────────────────┐
              │                     ▼
           [EMPTY] ───────────► [OCCUPIED]
              ▲                       │
              │                       │ Entry
              │                       ▼
              │                    [FULL]
              │                       │
              │                       │ Exit
              │                       ▼
              └────────────────── [OCCUPIED]
                       Exit

  Emergency = 1 from ANY state
              │
              ▼
        [EMERGENCY]
              │
              │ Emergency = 0
              ▼
           [EMPTY]
---
# State Table:

| State            | Output              | Meaning                                        |
| ---------------- | ------------------- | ---------------------------------------------- |
| `EMPTY (00)`     | `Empty_Out = 1`     | No vehicle currently occupying the parking lot |
| `OCCUPIED (01)`  | `Occupied_Out = 1`  | Parking lot is occupied but not full           |
| `FULL (10)`      | `Full_Out = 1`      | Parking lot has reached full capacity          |
| `EMERGENCY (11)` | `Emergency_Out = 1` | Emergency override is active                   |

---
# Transition Table:

| Current State | Entry | Exit | Emergency | Next State |
| ------------- | ----: | ---: | --------: | ---------- |
| EMPTY         |     0 |    X |         0 | EMPTY      |
| EMPTY         |     1 |    X |         0 | OCCUPIED   |
| OCCUPIED      |     0 |    0 |         0 | OCCUPIED   |
| OCCUPIED      |     1 |    0 |         0 | FULL       |
| OCCUPIED      |     0 |    1 |         0 | EMPTY      |
| FULL          |     0 |    0 |         0 | FULL       |
| FULL          |     X |    1 |         0 | OCCUPIED   |
| ANY           |     X |    X |         1 | EMERGENCY  |
| EMERGENCY     |     X |    X |         1 | EMERGENCY  |
| EMERGENCY     |     X |    X |         0 | EMPTY      |

---
# Normal Parking Operation

The parking controller follows the occupancy sequence:

EMPTY
  │
  │ Entry = 1
  ▼
OCCUPIED
  │
  │ Entry = 1
  ▼
FULL

When vehicles leave:

FULL
  │
  │ Exit = 1
  ▼
OCCUPIED
  │
  │ Exit = 1
  ▼
EMPTY

Therefore the normal sequence is:

EMPTY → OCCUPIED → FULL


FULL → OCCUPIED → EMPTY
---
# Emergency Override

The controller also has an Emergency input.

When:

Emergency = 1'b1;

the FSM overrides normal Entry/Exit processing and transitions to:

EMERGENCY

Emergency has priority over normal parking operations.

For example:

OCCUPIED + Entry + Emergency
              │
              ▼
         EMERGENCY

Even though Entry = 1 would normally cause:

OCCUPIED → FULL

the emergency condition takes priority:

OCCUPIED → EMERGENCY
---
# Emergency Recovery

Unlike Q43, this controller does not store the previous state.

When emergency is cleared:

Emergency = 0;

the controller returns to:

EMPTY

The sequence is therefore:

Normal State
     │
     │ Emergency = 1
     ▼
EMERGENCY
     │
     │ Emergency = 0
     ▼
EMPTY

This provides a simple restart behavior after emergency mode.
---
# Previous-State Mechanism

The previous-state register is an important part of this project.

Normal State
     │
     │ Emergency = 1
     ▼
Save Current State
     │
     ▼
EMERGENCY
     │
     │ Emergency = 0
     ▼
Previous State
     │
     ▼
Resume Normal Operation

This prevents the traffic controller from simply restarting from S0 after an emergency.
---

# What I learned:
This project helped me understand how an FSM can represent the operating condition of a real-world system rather than simply controlling a sequence of abstract states.

I learned how to:
Encode four states using 2 bits.
Design a parking controller using Entry and Exit inputs.
Implement emergency override logic.
Give Emergency higher priority than normal Entry/Exit operations.
Implement a Moore output structure.
Use a default state assignment to hold the current state.
Use asynchronous reset in the state register.
Separate state-register, next-state, and output logic.
Build a testbench around external inputs rather than directly controlling internal FSM states.
Verify the design using Icarus Verilog and GTKWave.
---
# Waveform:
![Q44 Waveforms](waveforms/q44_waveform.png)
---
## 🚀 Author

Yash Gupta

Learning Verilog HDL through structured RTL design, simulation, FSM design, and digital system implementation.