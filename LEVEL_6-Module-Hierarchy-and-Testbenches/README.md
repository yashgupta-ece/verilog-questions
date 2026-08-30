# Level 6 — Module Hierarchy and Testbenches

> **Part of:** [verilog-questions](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · GTKWave · VS Code  
> **Status:** 🔄 In Progress — Day 3 (Q46-Q48 done)

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
| Q49 | `q49_*.v` | Exhaustive testbench for 4-bit counter | ⬜ Not Started |
| Q50 | `q50_*.v` | Exhaustive testbench for traffic light FSM | ⬜ Not Started |

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

## Key Concepts So Far

| Concept | What It Means |
|---------|--------------|
| Module instantiation | Placing one module inside another like plugging in a chip |
| Named port mapping | `.port_name(signal)` — connects sub-module port to local signal |
| Internal wires | `wire` signals declared in top module to connect sub-module ports |
| Hierarchical design | Building complex systems from verified smaller modules |
| Reusability | A verified sub-module can be used in many different top modules |

---

## The Golden Rule of Hierarchical Design

Design small → Verify small → Reuse in larger design → Verify larger

Never build a large module from scratch.
Always build from verified smaller pieces.


---

*Updated as questions are completed*  
*Next: Q49 exhaustive testbench for 4-bit counter*
*Previous: [Level 5 — FSMs]

---
### 🚀 Author

Yash Gupta

Learning Verilog HDL through structured RTL design, simulation, FSM design, and digital system implementation.
