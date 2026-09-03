# Level 6 — Module Hierarchy and Testbenches

> **Part of:** [verilog-questions](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · GTKWave · VS Code  
> **Status:** ✅ Level 6 Complete — All 5 questions done
---

## What This Level Covers

Moving from single modules to hierarchical designs — instantiating one module inside another, connecting ports between modules, and writing exhaustive testbenches that cover all edge cases.

DSA equivalent: Functions and modular code — breaking big problems into small reusable pieces  
Verilog equivalent: Sub-modules, instantiation, proper testbenches

**Key concept this level:**  
Every large design in real VLSI is built from smaller verified modules connected together. A processor is not one giant module — it is hundreds of smaller modules each verified independently. This level teaches you to think and design that way.

---

## Progress

| # | File | What It Does | Status |
|---|------|-------------|--------|
| Q46 | `Q46_4bitRCA.v` | 4-bit Ripple Carry Adder using 4 Full Adder instances | ✅ Done |
| Q47 | `Q47_8BITADDR` | 8-bit Adder using two 4-bit Adder instances | ✅ Done |
| Q48 | `Q48_ALU.v` | ALU using separate sub-modules for each operation | ✅ Done |
| Q49 | `Q49_COUNTER.v` | Exhaustive testbench for 4-bit counter | ✅ Done |
| Q50 | `tb_Q50.v` | Exhaustive testbench for traffic light FSM | ✅ Done |

---

## How to Run

```bash
iverilog -o output q46_ripple_adder.v full_adder.v q46_ripple_adder_tb.v
vvp output
gtkwave dump.vcd
```

Note: When using hierarchy, compile ALL module files together in one iverilog command. If a sub-module file is missing from the command, you will get a "module not found" error.

---

## Q46 — 4-bit Ripple Carry Adder

**What it does:** Adds two 4-bit numbers by chaining 4 Full Adder instances together. The carry output of each FA feeds into the carry input of the next — this is called carry rippling.  
**Real world use:** The ripple carry adder is the simplest multi-bit adder. All larger adders — carry lookahead, carry select — are improvements on this basic concept. Understanding this is the foundation of all arithmetic hardware.

**Code — Full Adder sub-module:**
```verilog
module Full_Adder (
    input wire A,B,C_in, output Sum,Carry
);
    wire w1,w2,w3;

    and a1(w1,A,B);
    and a2(w2,B,C_in);
    and a3(w3,A,C_in);
    or r1(Carry,w1,w2,w3);

    xor x1(Sum,A,B,C_in);
endmodule
```

**Code — 4-bit Ripple Carry Adder (top module):**
```verilog
module Ripple_Carry (
    input wire [3:0] A_in,
    input wire [3:0] B_in,
    input wire C_in,
    output wire [3:0] Sum,
    output wire C_out
);
wire C1,C2,C3;
Full_Adder FA_0(.A(A_in[0]),.B(B_in[0]),.C_in(C_in),.Sum(Sum[0]),.Carry(C1));
Full_Adder FA_1(.A(A_in[1]),.B(B_in[1]),.C_in(1),.Sum(Sum[1]),.Carry(C2));
Full_Adder FA_2(.A(A_in[2]),.B(B_in[2]),.C_in(C2),.Sum(Sum[2]),.Carry(C3));
Full_Adder FA_3(.A(A_in[3]),.B(B_in[3]),.C_in(C3),.Sum(Sum[3]),.Carry(C_out));

    
endmodule
```
---
## Test Cases:

| a    | b    | cin | sum  | cout | Decimal check |
|------|------|-----|------|------|---------------|
| 0000 | 0000 | 0   | 0000 | 0    | 0+0=0 ✅ |
| 0001 | 0001 | 0   | 0010 | 0    | 1+1=2 ✅ |
| 0101 | 0011 | 0   | 1000 | 0    | 5+3=8 ✅ |
| 0111 | 0001 | 0   | 0000 | 1    | 7+1=8 ✅ |
| 1111 | 0001 | 1   | 1111 | 1    | 15+1=16 ✅ |
| 1010 | 0101 | 0   | 0000 | 1    | 10+5+1=16 ✅ |
| 1111 | 1111 | 0   | 1111 | 1    | 15+15=30 ✅ |

---
## Waveform:

![Q46 Waveform](waveforms/q46_waveform.png)

**What I learned:**  
Module instantiation uses named port mapping — `.a(a[0])` means "connect port named `a` of the sub-module to signal `a[0]` in this module." The intermediate carry wires `c1`, `c2`, `c3` must be declared as `wire` in the top module — they are internal connections not visible outside. The most important thing I learned is that the full adder module I built in Q9 can be directly reused here without any changes — this is the real power of modular design. In real chip design, verified modules are reused across hundreds of larger designs.

---
### Q47 — 8-bit Adder using Two 4-bit Ripple Carry Adder Instances

What it does: Adds two 8-bit numbers by connecting two 4-bit ripple carry adder instances together. The carry-out of the lower 4-bit adder (RC1) feeds directly into the carry-in of the upper 4-bit adder (RC2).
Real world use: This is exactly how real multi-bit adders are built — verified smaller adders chained together. A 32-bit adder in a processor uses the same principle scaled up.

### Code:
```verilog
module Eight_bit_Adder (
    input wire [7:0] A_in,
    input wire [7:0] B_in,
    input wire C_in,
    output wire [7:0] Sum,
    output wire C_out
);
    wire C4;
    Ripple_Carry RC1(.A_in(A_in[3:0]),.B_in(B_in[3:0]),.C_in(C_in),.Sum(Sum[3:0]),.C_out(C4));
    Ripple_Carry RC2(.A_in(A_in[7:4]),.B_in(B_in[7:4]),.C_in(C4),.Sum(Sum[7:4]),.C_out(C_out));
endmodule
```
### Test Cases Verified:

|A_in(hex) | B_in(hex) |	C_in |	Sum(hex) |	C_out  |	Decimal Check              |
|--------------------------------------------------------------------------------------|
|00	      |    00	   |   0	  |      00	 |      0  |	  0+0=0 ✅                |
|01	      |    01	   |   0	  |      02	 |      0  |	  1+1=2 ✅                |
|0F	      |    01	   |   0	  |      10	 |      0  |	  15+1=16 ✅              |
|55	      |    33	   |   0	  |      88	 |      0  |	  85+51=136 ✅            |
|FF	      |    01	   |   0	  |      00	 |      1  |	  255+1=256 overflow ✅   |
|AA	      |    55	   |   1	  |      00	 |      1  |	  170+85+1=256 overflow ✅|
|FF	      |    FF	   |   1	  |      FF	 |      1  |	  255+255+1=511 ✅        |
---
## Waveform:
![Q47 Waveform](waveforms/q47_waveform.png)
---
**What I learned:**
The internal carry wire RC1_cout connects RC1's carry-out directly to RC2's carry-in — this is what makes it a proper 8-bit adder rather than two independent 4-bit adders. I also added RC1's internal signals to GTKWave using the hierarchy tree on the left panel — expanding dut → RC1 showed me the individual FA_0 to FA_3 signals inside the lower adder. Seeing the hierarchy visually in GTKWave made the module nesting much clearer than reading the code alone. The overflow cases where Sum=00 and C_out=1 confirmed the carry propagation is working correctly across the boundary between RC1 and RC2.
---
### Q48 — 4-bit ALU using Sub-modules

**What it does**: A 4-bit ALU that performs Add, Subtract, AND, OR operations using separate sub-modules for each operation. A 2-bit select signal chooses which result to output.
Real world use: Every processor has an ALU at its core. The real insight here is that the ALU doesn't switch between operations — all four operations run simultaneously and a multiplexer selects which result to pass through. This is how real hardware works.

### Code:
```verilog
module ALU (
    input wire [3:0] A_in,
    input wire [3:0] B_in,
    input wire [1:0] Sel,
    output reg [3:0] ALU_Out
);
    wire [3:0] Add_Result;
    wire [3:0] Sub_Result;
    wire [3:0] AND_Result;
    wire [3:0] XOR_Result;

    Ripple_Carry ADD(
        .A_in(A_in),
        .B_in(B_in),
        .C_in(1'b0),
        .Sum(Add_Result),
        .C_out()
    );

    SUBTRACTION SUB(
        .A(A_in),
        .B(B_in),
        .Y(Sub_Result)
    );

    AND And(
        .A(A_in),
        .B(B_in),
        .Y(AND_Result)
    );

    XOR Xor(
        .A(A_in),
        .B(B_in),
        .Y(XOR_Result)
    );

    always @(*) begin
        case (Sel)
            2'b00:ALU_Out=Add_Result;
            2'b01:ALU_Out=Sub_Result;
            2'b10:ALU_Out= AND_Result;
            2'b11:ALU_Out=XOR_Result;
            default:ALU_Out=4'b0000;
        endcase
    end
endmodule
```
---
### Operation Table:
|Sel	|   Operation	|  Example (A=5, B=3)	|   Result |
|----------------------------------------------------------|
| 00    |  Addition     |      5+3              |     8    |
| 01    |  Subtraction  |      5-3              |     8    |
| 10    |  AND          |    0101 & 0011        |     8    |
| 11    |  XOR          |      0101 | 0011      |     8    |

### Test Cases Verified from Waveform:

|A_in | B_in  |	Sel  |	ALU_Out  |	Operation  |
|----------------------------------------------|
| 5   |  3    |  00  |     8     |    Add      |
| 5   |  3    |  01  |     2     |  Subtraction|
| A   |  C    |  10  |     8     |    AND      |
| A   |  C    |  11  |     6     |    XOR      |
| F   |  1    |  00  |     0     |    ADD      |
| 9   |  3    |  01  |     6     |    AND      |

---
### Waveform:
![Q48 Waveform](waveforms/q48_waveform.png)

---
### What I learned:
The most important thing I learned in this question is that all four operation modules run simultaneously — the adder, subtractor, AND, and OR are all computing their results every single moment. The case statement on Sel is just a multiplexer selecting which result to output. This is fundamentally different from software where only one operation executes at a time. Hardware is always running — you just choose which output to use. I also learned that AND and OR cannot be used as instance names in Verilog because they are reserved keywords — I used AND_M and OR_M instead.
---
### Q49 — Exhaustive Testbench for 4-bit Up-Down Counter

What it does: A complete testbench for the 4-bit up-down counter covering all meaningful scenarios — count up, count down, mid-count reset, direction change mid-sequence, overflow and underflow behaviour.
Real world use: In industry, a testbench is not an afterthought — it is written before or alongside the design. A testbench that only checks the happy path is not a testbench, it is a demo. Exhaustive verification means every edge case is covered.
---
# Code:
```verilog
Main Module
module Q49(
    input wire Clock, Reset, UpDown,
    output reg [3:0] Counter
);
    always @(posedge Clock) begin
        if (Reset)
            Counter <= 4'b0000;
        else if (UpDown)
            Counter <= Counter + 4'b0001;
        else
            Counter <= Counter - 4'b0001;
    end
endmodule
```

```verilog
TESTBENCH
module tb_q49;
reg Clock;
reg Reset;
reg UpDown;

wire [3:0] Counter;

Q49 dut(
    .Reset(Reset),.Clock(Clock),.UpDown(UpDown),.Counter(Counter)
);

always #5 Clock=~Clock;

initial begin
    $dumpfile("q49.vcd");
    $dumpvars(0,tb_q49);

    $monitor("Clock=%b,Reset=%b,Updown=%b,Counter=%b",Clock,Reset,UpDown,Counter);

    Clock=0;Reset=1;UpDown=1;#10;
    Reset=0;UpDown=1;#70;
    UpDown=0;#30;
    Reset=1;#10;
    Reset=0;UpDown=1;#30;
    UpDown=0;#50;
    Reset=1;#10;
    UpDown=1;#170;
    $finish;
end
endmodule
```
---
### Test Scenarios Verified:
| Scenario           | What Was Tested                                  | Result   |
| ------------------ | ------------------------------------------------ | ---------|
| Initial reset      | Counter starts at 0000 on reset                  | ✅      |
| Count up           | 0 → 1 → 2 → 3 → 4 → 5 → 6 → 7                    | ✅      |
| Direction change   | UpDown switches mid-sequence, counter reverses   | ✅      |
| Reset mid-count    | Reset fires while counting, counter returns to 0 | ✅      |
| Resume after reset | Counter resumes correctly from 0                 | ✅      |
| Count down         | F → E → D visible in waveform                    | ✅      |
| Overflow           | Counter wraps F → 0 correctly                    | ✅      |
---
![Q49 Waveform](waveforms/q49_waveform.png)
---
### What I learned:
Writing an exhaustive testbench forced me to think about the design from the outside — what inputs could a real user apply, what could go wrong, and what are the boundary conditions. Reset mid-count and direction change mid-sequence are the two cases most beginners skip. The waveform showed the counter hitting F and wrapping back to 0 correctly — this confirmed the 4-bit overflow behaviour is handled naturally by Verilog's arithmetic without any extra logic needed. A good testbench tells a story: setup → normal operation → edge cases → recovery.
---
### Q50 — Exhaustive Testbench for Traffic Light FSM

What it does: A complete testbench for the Q43 Smart Traffic Controller FSM covering reset, normal state cycling, emergency activation mid-cycle, emergency clearing and state recovery, and repeated emergency triggering.
Real world use: FSM testbenches in industry must prove every state transition — not just that the happy path works. Emergency and reset scenarios are the most safety-critical cases and must be explicitly verified.
---
### Code:
```verilog
module tb_q50;

reg Clock;
reg Reset;
reg Emergency;

wire Light0;
wire Light1;
wire Light2;
wire Light3;
wire Emergency_Out;

q43 dut (
    .Clock(Clock),
    .Reset(Reset),
    .Emergency(Emergency),
    .Light0(Light0),
    .Light1(Light1),
    .Light2(Light2),
    .Light3(Light3),
    .Emergency_Out(Emergency_Out)
);

always #5 Clock = ~Clock;

initial begin

    $dumpfile("q50.vcd");
    $dumpvars(0, tb_q50);

    $monitor("Time=%0t | Clock=%b Reset=%b Emergency=%b | L0=%b L1=%b L2=%b L3=%b Emergency_Out=%b",
             $time, Clock, Reset, Emergency,
             Light0, Light1, Light2, Light3, Emergency_Out);

    Clock = 0;Reset = 1;Emergency = 0;#10;
    Reset = 0;#10;
    Emergency = 1;#10;
    Emergency = 0;#10;
    #10;
    Emergency = 1;#10;
    Emergency = 0;#10;
    #20;

    $finish;
end
endmodule
```
---
### Test Scenarios Verified:
| Scenario              | What Was Tested                                | Result |
| --------------------- | ---------------------------------------------- | ------ |
| Reset                 | System initialises to S0, Light0 HIGH          | ✅      |
| Normal cycling        | S0→S1→S2→S3 state sequence                     | ✅      |
| Emergency fires       | Emergency_Out goes HIGH, all lights go LOW     | ✅      |
| Emergency clears      | FSM returns to previous state correctly        | ✅      |
| Emergency fires again | Second emergency trigger verified              | ✅      |
| State recovery        | Correct light activates after emergency clears | ✅      |
---
### Waveform:
![Q50 Waveform](waveforms/q50_waveform.png)
---
### What I learned:
An FSM testbench needs to verify not just normal operation but every transition that involves external events — reset, emergency, and recovery. The waveform showed Emergency_Out going HIGH correctly every time Emergency fired and the previous state restoring cleanly when it cleared. This testbench also reused the Q43 module directly without any changes — proving that a well-designed FSM module is self-contained and testable in isolation. Writing this testbench made me think much more carefully about what I need to verify in the main traffic controller project.
---
## Key Concepts So Far

| Concept               |                        What It Means                              |
|-----------------------|-------------------------------------------------------------------|
| Module instantiation  | Placing one module inside another like plugging in a chip         |
| Named port mapping    | `.port_name(signal)` — connects sub-module port to local signal   |
| Internal wires        | `wire` signals declared in top module to connect sub-module ports |
| Hierarchical design   | Building complex systems from verified smaller modules            |
| Reusability           | A verified sub-module can be used in many different top modules   |

---

## The Golden Rule of Hierarchical Design

Design small → Verify small → Reuse in larger design → Verify larger

Never build a large module from scratch.
Always build from verified smaller pieces.


---
### Full Level 6 Summary
| Concept              | What It Means                                              |
| -------------------- | ---------------------------------------------------------- |
| Module instantiation | Placing verified sub-modules inside a top module           |
| Named port mapping   | `.port(signal)` connects sub-module ports to local signals |
| Internal wires       | Connect sub-module outputs to other sub-module inputs      |
| Hierarchical design  | Complex systems built from verified smaller pieces         |
| Exhaustive testbench | All edge cases covered — not just happy path               |
| Reusability          | Same module used across multiple designs and testbenches   |

---
*Updated as questions are completed*  
*Level 6 Complete — All 50 questions done — Moving to Main Project*
*Project will be uploaded as a separate repositry*
---
### 🚀 Author

Yash Gupta

Learning Verilog HDL through structured RTL design, simulation, FSM design, and digital system implementation.
