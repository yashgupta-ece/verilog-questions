# Level 6 — Module Hierarchy and Testbenches

> **Part of:** [verilog-questions](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · GTKWave · VS Code  
> **Status:** 🔄 In Progress — Day 1 (Q46 done)

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
| Q47 | `q47_*` | 8-bit Adder using two 4-bit Adder instances | ⬜ Not Started |
| Q48 | `q48_*.v` | ALU using separate sub-modules for each operation | ⬜ Not Started |
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
*Next: Q47 8-bit adder using two 4-bit adder instances*  
*Previous: [Level 5 — FSMs]

---
### 🚀 Author

Yash Gupta

Learning Verilog HDL through structured RTL design, simulation, FSM design, and digital system implementation.
