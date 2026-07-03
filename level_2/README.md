# Level 2 — Vectors and Multi-Bit Signals

> **Part of:** [verilog-practice](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · VS Code · GTKWave  
>**Status:** ✅ Level 2 Complete — All 8 questions done

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
| Q17 | `q17_replicate.v` | Replicate 4-bit input 4 times to make 16-bit | ✅ Done |
| Q18 | `q18_swapnibble.v` | Swap upper and lower nibbles of 8-bit input | ✅ Done |

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

Q17 — Replication
What it does: Takes a 4-bit input and repeats it 4 times to produce a 16-bit output.
Real world use: Sign extension in processors, filling a wide bus with a repeated pattern, initializing memory with a repeated value.
Code:
verilogmodule q17_replicate(
    input  [3:0] in,
    output [15:0] out
);
    assign out = {4{in}};
endmodule
Examples:
in     out
1010 1010101010101010
1111 1111111111111111
0001 0001000100010001
1100 1100110011001100

Simulation output:
time=0  | in=A | out=AAAA
time=10 | in=F | out=FFFF
time=20 | in=1 | out=1111
time=30 | in=C | out=CCCC
What I learned:
{4{in}} means "repeat in four times." The number before the braces is the replication count. This is much cleaner than writing {in, in, in, in} manually — and scales easily if you need 8 or 16 repetitions. Replication and concatenation can also be combined like {2{a}, 2{b}}.

Q18 — Swap Nibbles
What it does: Takes an 8-bit input and swaps the upper 4 bits with the lower 4 bits.
Real world use: Byte manipulation in communication protocols, endianness conversion, data formatting between different hardware interfaces.
Code:
verilogmodule q18_swapnibble(
    input  [7:0] in,
    output [7:0] out
);
    assign out = {in[3:0], in[7:4]};
endmodule
Examples:
in       out
11001010 10101100
11110000 00001111
10100101 01011010
00010010 00100001

Simulation output:
time=0  | in=CA | out=AC
time=10 | in=F0 | out=0F
time=20 | in=A5 | out=5A
time=30 | in=12 | out=21
What I learned:
Combining part-select and concatenation in one assign statement is very powerful. {in[3:0], in[7:4]} puts the lower nibble first and the upper nibble second — effectively swapping them. This question combined two concepts from earlier questions into one solution.

Full Level 2 Summary
ConceptWhat It Means[3:0]4-bit vector declaration — MSB:LSB4'b1010Sized binary literaldata[3:2]Part-select — extracts a range of bitsdata[0]Single bit access{a, b}Concatenation — joins signals into wider signal{4{in}}Replication — repeats signal N times|inReduction OR — ORs all bits into one&inReduction AND — ANDs all bits into oneBitwise ops on vectors&, |, ^ work bit-by-bit across full width
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
**Level 2 Complete — Moving to [Level 3 — Combinational Logic](../level3-combinational/README.md)**