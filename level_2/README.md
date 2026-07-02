# Level 2 — Vectors and Multi-Bit Signals

> **Part of:** [verilog-practice](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · VS Code · GTKWave  
> **Status:** 🔄 In Progress — Day 6 (Q11–Q16 done)

---

## What This Level Covers

This level introduces **vectors** (multi-bit signals), one of the most important concepts in Verilog. Instead of working with single-bit wires, we now manipulate groups of bits using indexing, slicing, and concatenation.

Every design is simulated using Icarus Verilog and verified in GTKWave to observe how multiple bits change together.

DSA equivalent: Arrays → Indexing → Subarrays  
Verilog equivalent: Vectors → Bit Selection → Part Select

---

## Progress

| # | File | What It Does | Status |
|---|------|-------------|--------|
| Q11 | `q11_vector_basic.v` | Declares a 4-bit wire and assigns constant `1010` | ✅ Done |
| Q12 | `q12_bit_extract.v` | Extracts upper and lower 2 bits from a 4-bit input | ✅ Done |
| Q13 | `q13_reverse.v` | Reverse bits of an 8-bit input | ✅ Done |
| Q14 | `q14_concat.v` | Combine two 4-bit inputs into 8-bit output | ✅ Done |
| Q15 | `q15_bitwise4.v` | Bitwise AND, OR, XOR of two 4-bit inputs | ✅ Done |
| Q16 | `q16_reduction.v` | Check if 8-bit number is zero | ✅ Done |
| Q17 | `q17_replication.v` | Replicate a 4-bit input four times | ⏳ Pending |
| Q18 | `q18_swap_nibbles.v` | Swap upper and lower nibble of an 8-bit input | ⏳ Pending |

---

## How to Run

```bash
# Compile module and testbench
iverilog -o output q11_vector_basic.v q11_tb.v

# Simulate
vvp output
```

For Level 2, GTKWave is recommended to visualize multi-bit buses.

```bash
gtkwave dump.vcd
```

In GTKWave:

- Right click signal
- **Data Format → Binary** or **Hex**

This makes vector values easier to understand.

---

Q15 — 4-bit Bitwise Operations
What it does: Takes two 4-bit inputs and performs AND, OR, and XOR on all bits simultaneously, producing three 4-bit outputs.
Real world use: Masking specific bits, setting or clearing flags, comparing two data values in hardware.
Code:
verilogmodule q15_bitwise4(
    input  [3:0] a,
    input  [3:0] b,
    output [3:0] and_out,
    output [3:0] or_out,
    output [3:0] xor_out
);
    assign and_out = a & b;
    assign or_out  = a | b;
    assign xor_out = a ^ b;
endmodule
Examples:
a     b    AND  OR   XOR 
1100 1010 1000 1110  0110 
1111 0000 0000 1111  1111
1010 0101 0000 1111  1111
1111 1111 1111 1111  0000

Simulation output:
time=0  | a=C b=A | and=8 or=E xor=6
time=10 | a=F b=0 | and=0 or=F xor=F
time=20 | a=A b=5 | and=0 or=F xor=F
time=30 | a=F b=F | and=F or=F xor=0
What I learned:
The same operators &, |, ^ that worked on single bits in Level 1 work on vectors too — they just operate on each bit position independently and simultaneously. This is called bitwise operation. XOR of identical values always gives 0 — this is actually used in hardware to detect if two signals are equal.

Q16 — Zero Checker (Reduction Operator)
What it does: Takes an 8-bit input and outputs 1 if all bits are zero, 0 otherwise.
Real world use: Zero detection in ALUs, checking if a register is empty, flag generation in processors.
Code:
verilogmodule q16_reduction(
    input  [7:0] in,
    output       zero
);
    assign zero = ~(|in);
endmodule
Examples:
in        zero
00000000   1
00000001   0
10000000   0
11111111   0
Simulation output:
time=0  | in=00 | zero=1
time=10 | in=01 | zero=0
time=20 | in=80 | zero=0
time=30 | in=FF | zero=0
What I learned:
|in is a reduction OR — it ORs all 8 bits of in together into a single bit. If any bit is 1, the result is 1. Inverting that with ~ gives 1 only when all bits were 0. This was the first time I used a reduction operator and it replaced what would have been 7 OR operations written manually.
---

# Key Concepts Learned — Level 2 So Far

| Concept | Meaning |
|---------|---------|
| `wire [3:0]` | Declares a 4-bit vector |
| `4'b1010` | 4-bit binary constant |
| `a[3]` | Access a single bit |
| `a[3:2]` | Extract multiple bits |
| Vector | Multiple bits grouped into one signal |
| Part-select | Selecting a range of bits |
| Multi-bit assign | Drive an entire bus at once |

---

*Updated daily as questions are completed*  
**Next: Q17 replication, Q18 swap nibbles**