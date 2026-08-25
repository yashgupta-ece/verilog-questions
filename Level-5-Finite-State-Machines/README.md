# Level 5 — Finite State Machines (FSM)

> **Part of:** [verilog-questions](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · GTKWave · VS Code  
> **Status:** 🔄 In Progress — Day 20 (Q36- Q45 Completed) Level 5 Completed Finally!

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
| Q45 | `Q45_UARTtx.v` | UART Transmitter FSM | ⏳ |

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

# Q45 — UART Transmitter FSM

What it does: A Moore-style FSM-based UART transmitter that converts an 8-bit parallel data value into a serial bit stream. The transmitter uses four states — IDLE, START, DATA, and STOP — to generate a UART frame with one start bit, eight data bits transmitted LSB first, and one stop bit.

Real world use: UART is one of the most common serial communication protocols used in embedded systems, microcontrollers, FPGA designs, debugging interfaces, GPS modules, sensors, and communication between digital systems.

---

# Objective

The main objectives of this project are:

Implement a multi-state serial protocol FSM.

Understand the structure of a UART transmission frame.

Convert parallel 8-bit data into a serial output.

Transmit data LSB first.

Implement start and stop bits.

Use an FSM to control the transmission sequence.

Use a bit counter to track the eight data bits.

Use a data register to store the byte being transmitted.

Implement a Busy signal to indicate an active transmission.

Practice the interaction between an FSM and datapath registers.

Understand how sequential and combinational logic work together in a practical communication system.

---

# 📂 Inputs

| Signal | Width | Description |
|---|---:|---|
| Clock | 1 | System clock |
| Reset | 1 | Asynchronous reset |
| Start | 1 | Starts a new UART transmission |
| Data | 8 | Parallel data byte to transmit |

---

# 📂 Outputs

| Signal | Width | Description |
|---|---:|---|
| Tx | 1 | Serial UART transmission output |
| Busy | 1 | Indicates that a transmission is currently active |

---

# Internal Registers

The design uses four important registers.

### Current State

```verilog
reg [1:0] current_state;
```

### Next State
reg [1:0] next_state;

### Code:
module Q45 (
    input wire Clock,
    input wire Reset,
    input wire Start,
    input wire [7:0] Data,
    output reg Tx,
    output reg Busy
);

    reg [1:0] current_state;
    reg [1:0] next_state;

    parameter IDLE  = 2'b00;
    parameter START = 2'b01;
    parameter DATA  = 2'b10;
    parameter STOP  = 2'b11;

    reg [7:0] data_reg;
    reg [2:0] bit_count;

    // State register and datapath registers
    always @(posedge Clock or posedge Reset) begin
        if (Reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
        end
        else begin
            current_state <= next_state;

            if (current_state == IDLE && Start) begin
                data_reg <= Data;
                bit_count <= 3'b000;
            end

            else if (current_state == DATA && bit_count < 3'd7) begin
                bit_count <= bit_count + 1'b1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;

        case (current_state)

            IDLE: begin
                if (Start)
                    next_state = START;
            end

            START: begin
                next_state = DATA;
            end

            DATA: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
                else
                    next_state = DATA;
            end

            STOP: begin
                next_state = IDLE;
            end

            default:
                next_state = IDLE;

        endcase
    end

    // Output logic
    always @(*) begin

        Tx = 1'b0;
        Busy = 1'b0;

        case (current_state)

            IDLE: begin
                Tx = 1'b1;
                Busy = 1'b0;
            end

            START: begin
                Tx = 1'b0;
                Busy = 1'b1;
            end

            DATA: begin
                Tx = data_reg[bit_count];
                Busy = 1'b1;
            end

            STOP: begin
                Tx = 1'b1;
                Busy = 1'b1;
            end

            default: begin
                Tx = 1'b0;
                Busy = 1'b0;
            end

        endcase
    end

endmodule
---
# State Diagram:
                         Start = 1
                            │
                            ▼
                       ┌─────────┐
                       │  START  │
                       └────┬────┘
                            │
                            ▼
                       ┌─────────┐
                       │  DATA   │
                       │ Bit 0-7 │
                       └────┬────┘
                            │
                     bit_count == 7
                            │
                            ▼
                       ┌─────────┐
                       │  STOP   │
                       └────┬────┘
                            │
                            ▼
                       ┌─────────┐
                  ┌───►│  IDLE   │
                  │    └─────────┘
                  │
                  └── Start = 0

---
# State Table:

| State        |                    Tx | Busy | Meaning                        |
| ------------ | --------------------: | ---: | ------------------------------ |
| `IDLE (00)`  |                     1 |    0 | Waiting for a new transmission |
| `START (01)` |                     0 |    1 | Sending the UART start bit     |
| `DATA (10)`  | `data_reg[bit_count]` |    1 | Sending the 8 data bits        |
| `STOP (11)`  |                     1 |    1 | Sending the UART stop bit      |

---

# Transition Table:

| Current State | Condition       | Next State |
| ------------- | --------------- | ---------- |
| IDLE          | `Start = 0`     | IDLE       |
| IDLE          | `Start = 1`     | START      |
| START         | —               | DATA       |
| DATA          | `bit_count < 7` | DATA       |
| DATA          | `bit_count = 7` | STOP       |
| STOP          | —               | IDLE       |
| Invalid       | —               | IDLE       |


---
### UART Transmission Sequence

When a new byte is ready to be transmitted:

IDLE
 │
 │ Start = 1
 ▼
START
 │
 │ one clock
 ▼
DATA
 │
 ├── Data[0]
 ├── Data[1]
 ├── Data[2]
 ├── Data[3]
 ├── Data[4]
 ├── Data[5]
 ├── Data[6]
 └── Data[7]
 │
 ▼
STOP
 │
 │ one clock
 ▼
IDLE
---

### What I learned:

This project helped me understand how an FSM can control a real communication protocol rather than simply controlling the operating condition of a system.

I learned how to:
Encode four states using 2 bits.
Design a UART transmitter using IDLE, START, DATA, and STOP states.
Transmit an 8-bit data value serially using LSB-first transmission.
Use a 3-bit bit counter to track the eight data bits.
Use a data register to store the byte during transmission.
Implement start and stop bits as part of a UART frame.
Implement a Busy output to indicate an active transmission.
Separate state-register, next-state, and output logic.
Combine an FSM with datapath registers such as a data register and bit counter.
Build a testbench around external inputs such as Start and Data.
Verify the complete serial transmission using Icarus Verilog and GTKWave.
---
# Waveform:
![Q45 Waveforms](waveforms/q45_waveform.png)
---
### 🎉 Level 5 — Finally Completed!

Honestly, this one feels special.
---
### 🚀 Author

Yash Gupta

Learning Verilog HDL through structured RTL design, simulation, FSM design, and digital system implementation.