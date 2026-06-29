# Level 1 — Basics: Wire, Gates, Assign

> **Part of:** [verilog-practice](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · VS Code  
> **Status:** 🔄 In Progress — Day 3 (Q1–Q10 done)

---

## What This Level Covers

Starting point of Verilog — single-bit signals, basic logic gates, and the `assign` statement.  
Every question is simulated using Icarus Verilog and verified against its truth table using `$monitor`.  
GTKWave not used at this level — terminal output is sufficient for single-bit combinational logic.

DSA equivalent: Print Hello World → Basic I/O → Simple operators  
Verilog equivalent: Wire → NOT gate → AND gate

---

## Progress

| # | File | What It Does | Status |
|---|------|-------------|--------|
| Q1 | `q01_wire.v` | Connects input directly to output | ✅ Done |
| Q2 | `q02_not.v` | Inverts a single input | ✅ Done |
| Q3 | `q03_and.v` | AND of two inputs | ✅ Done |
| Q4 | `q04_or.v` | OR of two inputs | ✅ Done |
| Q5 | `q05_xor.v` | XOR of two inputs | ✅ Done |
| Q6 | `q06_xnor.v` | XNOR of two inputs | ✅ Done |
| Q7 | `q07_nand_nor.v` | NAND and NOR in same module | ✅ Done |
| Q8 | `q08_half_adder.v` | Sum and carry from two inputs | ✅ Done |
| Q9 | `q09_full_adder.v` | Three inputs, sum and carry | ✅ Done |
| Q10 | `q10_7458.v` | Implements the real 7458 IC logic | ✅ Done |

---

## How to Run

```bash
# Compile both files
iverilog -o output q01_wire.v q01_wire_tb.v

# Simulate — output prints in terminal
vvp output
```

No GTKWave needed at this level. Verify output against truth table below.


---

Q7 — NAND and NOR Gates
What it does: Implements both NAND and NOR in one module with two outputs.

Real world use: NAND and NOR are called universal gates — any logic circuit in the world can be built using only NAND gates or only NOR gates.
Code:
verilogmodule q07_nand_nor(
    input  a,
    input  b,
    output nand_out,
    output nor_out
);
    assign nand_out = ~(a & b);
    assign nor_out  = ~(a | b);
endmodule
Truth Table:
abnand_outnor_out0011011010101100
Simulation output:
time=0  | a=0 b=0 | nand=1 nor=1
time=10 | a=0 b=1 | nand=1 nor=0
time=20 | a=1 b=0 | nand=1 nor=0
time=30 | a=1 b=1 | nand=0 nor=0
What I learned:

NAND is AND with a NOT on the output — ~(a & b). NOR is OR with a NOT — ~(a | b). One module can have multiple outputs driven by separate assign statements simultaneously.

Q8 — Half Adder
What it does: Adds two 1-bit numbers and produces a sum bit and a carry bit.

Real world use: The fundamental building block of all arithmetic in digital hardware. Every processor, calculator, and computer uses half adders at its core.
Code:
verilogmodule q08_half_adder(
    input  a,
    input  b,
    output sum,
    output carry
);
    assign sum   = a ^ b;
    assign carry = a & b;
endmodule
Truth Table:
absumcarry0000011010101101
Simulation output:
time=0  | a=0 b=0 | sum=0 carry=0
time=10 | a=0 b=1 | sum=1 carry=0
time=20 | a=1 b=0 | sum=1 carry=0
time=30 | a=1 b=1 | sum=0 carry=1
What I learned:

1+1 in binary is 10 — the sum bit is 0 and carry is 1. XOR naturally gives the sum because it outputs 0 when both inputs are 1. AND gives the carry because carry is only generated when both inputs are 1.

Q9 — Full Adder
What it does: Adds three 1-bit numbers — a, b, and carry-in. Produces sum and carry-out.

Real world use: Chained together to build multi-bit adders. A 32-bit adder inside a processor uses 32 full adders connected in sequence.
Code:
verilogmodule q09_full_adder(
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule
Truth Table:
abcinsumcout0000000110010100110110010101011100111111
Simulation output:
time=0  | a=0 b=0 cin=0 | sum=0 cout=0
time=10 | a=0 b=0 cin=1 | sum=1 cout=0
time=20 | a=0 b=1 cin=0 | sum=1 cout=0
time=30 | a=0 b=1 cin=1 | sum=0 cout=1
time=40 | a=1 b=0 cin=0 | sum=1 cout=0
time=50 | a=1 b=0 cin=1 | sum=0 cout=1
time=60 | a=1 b=1 cin=0 | sum=0 cout=1
time=70 | a=1 b=1 cin=1 | sum=1 cout=1
What I learned:

Carry-out is generated whenever at least two of the three inputs are 1 — that's what (a&b) | (b&cin) | (a&cin) checks. This was the first time I wrote a truth table with 8 rows and verified all 8 cases in simulation.

Q10 — 7458 Chip
What it does: Implements the exact logic of the real 7458 dual AND-OR IC.

Real world use: Shows how a real IC datasheet maps directly to Verilog. Reading datasheets and translating to HDL is a core skill in chip design.
Logic:

Output p = (a AND b) OR (c AND d)
Output q = (e AND f) OR (g AND h)

Code:
verilogmodule q10_7458(
    input  a, b, c, d,
    input  e, f, g, h,
    output p, q
);
    assign p = (a & b) | (c & d);
    assign q = (e & f) | (g & h);
endmodule
Simulation output:
time=0  | a=1 b=1 c=0 d=0 | p=1
time=10 | a=0 b=0 c=1 d=1 | p=1
time=20 | a=1 b=1 c=1 d=1 | p=1
time=30 | a=0 b=0 c=0 d=0 | p=0
What I learned:

A real IC has a fixed internal logic structure that was designed decades ago. Verilog can describe that exact same structure using assign statements. Looking at the 7458 datasheet before coding made the logic immediately obvious.

Key Concepts Learned — Full Level 1 Summary
ConceptWhat It MeansmoduleA hardware block with defined inputs and outputsinput / outputPorts — how signals enter and leave a moduleassignContinuously drives a wire — always activewireCarries a value but cannot store it~Bitwise NOT&Bitwise AND|Bitwise OR^Bitwise XOR~(a & b)NAND — AND with inverted output~(a | b)NOR — OR with inverted output$monitorPrints signal values to terminal on every changeMultiple outputsOne module can drive several outputs simultaneously

---

*Updated daily as questions are completed*  
*Level 1 Complete — Moving to [Level 2 — Vectors](../level2-vectors/README.md)*