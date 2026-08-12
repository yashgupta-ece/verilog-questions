# Level 5 — Finite State Machines (FSM)

> **Part of:** [verilog-questions](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · GTKWave · VS Code  
> **Status:** 🔄 In Progress — Day 18 (Q36- Q43 Completed)

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

# Q43 — Smart Traffic Controller with Emergency Override

What it does: A Moore FSM traffic light controller with 5 states — 4 normal traffic states and a dedicated EMERGENCY state that activates when an emergency vehicle is detected. The system stores the previous state so it can resume normal operation exactly where it left off after emergency clears.
Real world use: Real traffic intersections use FSM-based digital controllers. Emergency override is a genuine feature — ambulances and fire trucks trigger it to clear intersections instantly.

---
# Objective

The main objectives of this project are:

Implement a multi-state FSM.
Control traffic lights using Moore output logic.
Implement an emergency override mechanism.
Store the previous traffic state.
Return to the previous state after emergency mode ends.
Practice state registers and next-state logic.
Understand the interaction between sequential and combinational logic.

---
# 📂 Inputs
Signal	Width	Description
Clock	1	System clock
Reset	1	Asynchronous reset
Emergency	1	Activates emergency override
# 📂 Outputs
Signal	Width	Description
Light_Red	1	Controls red traffic light
Light_Yellow	1	Controls yellow traffic light
Light_Green	1	Controls green traffic light
Emergency_Out	1	Indicates emergency mode
---
# Internal Registers

The design uses three important registers:

Current State
reg [2:0] current_state;

Stores the FSM's present state.

Next State
reg [2:0] next_state;

Stores the state that the FSM will enter on the next clock edge.

Previous State
reg [2:0] previous_state;

Stores the state from which the controller entered emergency mode.
---
# Code:
module q43 (
    input wire Clock, Reset, Emergency,
    output reg Light0, Light1, Light2, Light3, Emergency_Out
);
    reg [2:0] current_state;
    reg [2:0] next_state;
    reg [2:0] previous_state;

    parameter S0        = 3'b000;
    parameter S1        = 3'b001;
    parameter S2        = 3'b010;
    parameter S3        = 3'b011;
    parameter EMERGENCY = 3'b100;

    wire [3:0] Lights;
    assign Lights = {Light3, Light2, Light1, Light0};

    // State register
    always @(posedge Clock or posedge Reset) begin
        if (Reset) begin
            current_state  <= S0;
            previous_state <= S0;
        end else begin
            if (Emergency && current_state != EMERGENCY) begin
                previous_state <= current_state;
            end
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        if (Emergency) begin
            next_state = EMERGENCY;
        end else begin
            case (current_state)
                S0:        next_state = S1;
                S1:        next_state = S2;
                S2:        next_state = S3;
                S3:        next_state = S0;
                EMERGENCY: next_state = previous_state;
                default:   next_state = current_state;
            endcase
        end
    end

    // Output logic
    always @(*) begin
        Light0        = 1'b0;
        Light1        = 1'b0;
        Light2        = 1'b0;
        Light3        = 1'b0;
        Emergency_Out = 1'b0;
        case (current_state)
            S0:        Light0        = 1'b1;
            S1:        Light1        = 1'b1;
            S2:        Light2        = 1'b1;
            S3:        Light3        = 1'b1;
            EMERGENCY: Emergency_Out = 1'b1;
            default: ;
        endcase
    end
endmodule
---
# State Diagram:
rst
   |
   ▼
 [S0] ──► [S1] ──► [S2] ──► [S3]
   ▲                              |
   └──────────────────────────────┘

  Emergency=1 from ANY state → [EMERGENCY]
  Emergency=0 from EMERGENCY → previous_state
---
# State Table:

State	          Light_Output	         Meaning
S0 (000)	       Light0=1	         Direction 0(active)
S1 (001)	       Light1=1	         Direction 1(active)
S2 (010)	       Light2=1	         Direction 2(active)
S3 (011)	       Light3=1	         Direction 3(active)
EMERGENCY(100)	Emergency_Out=1	 All directions halted
---
# Transition Table:

Current_State	 Emergency	 Next State
S0	              0	          S1
S1	              0	          S2
S2	              0	          S3
S3	              0	          S0
ANY	              1	        EMERGENCY
EMERGENCY	        0	       previous_state

---

# Emergency Override

The controller also has an Emergency input.

When:

Emergency = 1'b1;

the FSM immediately transitions toward:

EMERGENCY

Before entering emergency mode, the controller stores the current state in:

previous_state
Example

If the controller is currently in S2:

S2
 │
 │ Emergency = 1
 ▼
EMERGENCY

The controller stores:

Previous_State = S2

When the emergency condition is cleared:

Emergency = 0

the FSM returns to:

S2

and continues normal operation.

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
My design used a dedicated EMERGENCY state with previous_state storage — different from the simpler priority-input approach. Storing previous state allows the FSM to resume exactly where it left off after emergency clears, which is more realistic behaviour. The two bugs I hit — missing begin/end and case sensitivity — were subtle. The begin/end bug was particularly tricky because the code looked correct visually but only the first statement was inside the if block. Case sensitivity in Verilog is something to always watch — Emergency and EMERGENCY are completely different identifiers.

Design Decision — Previous State Recovery:
Returning to previous_state after emergency clears feels natural but has a safety consideration — if emergency fires during an active green light and clears immediately, traffic resumes on green which could be dangerous. A safer alternative for the main project would be returning to RED after any emergency regardless of previous state.

---
# Waveform:
![Q43 Waveforms](waveforms/q43_waveform.png)
---
## 🚀 Author

Yash Gupta

Learning Verilog HDL through structured RTL design, simulation, FSM design, and digital system implementation.