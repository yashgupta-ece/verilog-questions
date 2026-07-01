# Level 2 — Vectors and Multi-Bit Signals

> **Part of:** [verilog-practice](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · VS Code · GTKWave  
> **Status:** 🔄 In Progress — Day 5 (Q11–Q14 done)

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
| Q15 | `q15_vector_logic.v` | 4-bit AND, OR and XOR | ⏳ Pending |
| Q16 | `q16_zero_detect.v` | Detect whether an 8-bit input is zero | ⏳ Pending |
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

Q13 — Reverse Bits
What it does: Takes an 8-bit input and outputs it with all bits in reverse order. Bit 0 becomes bit 7, bit 7 becomes bit 0.
Real world use: Bit reversal is used in FFT algorithms, serial communication protocols, and data formatting between different hardware systems.
Code:
verilogmodule q13_reverse(
    input  [7:0] in,
    output [7:0] out
);
    assign out = {in[0], in[1], in[2], in[3],
                  in[4], in[5], in[6], in[7]};
endmodule
Examples:
in             out
10110001    10001101
11110000    00001111
10101010    01010101
00000001    10000000


Simulation output:
time=0  | in=B1 | out=8D
time=10 | in=F0 | out=0F
time=20 | in=AA | out=55
time=30 | in=01 | out=80
What I learned:
Curly braces {} in Verilog are the concatenation operator — they join multiple signals into one wider signal. By listing individual bits in reverse order inside {}, the output gets reversed. This was the first time I used individual bit access in[0], in[1] etc. on a vector.

Q14 — Concatenation
What it does: Takes two separate 4-bit inputs and joins them into one 8-bit output.
Real world use: Building wider data buses from narrower ones, combining address and data fields, packing multiple signals into one register.
Code:
verilogmodule q14_concat(
    input  [3:0] a,
    input  [3:0] b,
    output [7:0] out
);
    assign out = {a, b};
endmodule
Examples:
a    b     out
1100 1010  11001010
1111 0000  11110000
0001 0010  00010010
1010 0101  10100101


Simulation output:
time=0  | a=C b=A | out=CA
time=10 | a=F b=0 | out=F0
time=20 | a=1 b=2 | out=12
time=30 | a=A b=5 | out=A5
What I learned:
{a, b} places a in the upper bits and b in the lower bits of the output. Order inside {} matters — {a, b} and {b, a} give different results. The total width of the output must match the sum of widths of all signals inside the braces — {4-bit, 4-bit} gives exactly 8 bits.

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
**Next: Q15 bitwise operations, Q16 reduction**