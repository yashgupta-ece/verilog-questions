# Level 2 — Vectors and Multi-Bit Signals

> **Part of:** [verilog-practice](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · VS Code · GTKWave  
> **Status:** 🔄 In Progress — Day 4 (Q11–Q12 done)

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
| Q13 | `q13_reverse_bits.v` | Reverse bits of an 8-bit input | ⏳ Pending |
| Q14 | `q14_concat.v` | Combine two 4-bit inputs into one 8-bit output | ⏳ Pending |
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

## Q11 — 4-bit Vector Constant

**What it does:**  
Declares a 4-bit output vector and continuously assigns the binary constant `1010`.

**Real world use:**  
Digital circuits often use constant bit patterns for initialization, control signals, configuration registers, and instruction encoding.

### Code

```verilog
module q11_vector_basic(
    input  wire [3:0] a,
    output wire [3:0] y
);

    assign y = 4'b1010;

endmodule
```

### Simulation Output

```
a=0000 y=1010
a=0101 y=1010
a=1111 y=1010
```

### What I Learned

- `[3:0]` declares a 4-bit vector.
- Binary constants use the format `4'b1010`.
- `assign` can drive an entire vector, not just a single bit.
- The input `a` is unused because the output is a fixed constant.

---

## Q12 — Extract Upper and Lower Bits

**What it does:**  
Splits a 4-bit input into two separate 2-bit outputs using part-select.

**Real world use:**  
Processors, communication protocols, and instruction decoders frequently divide buses into smaller fields for independent processing.

### Code

```verilog
module q12_bit_extract(
    input  wire [3:0] a,
    output wire [1:0] upper,
    output wire [1:0] lower
);

    assign upper = a[3:2];
    assign lower = a[1:0];

endmodule
```

### Example

| Input | Upper | Lower |
|------|------|------|
| 1010 | 10 | 10 |
| 1101 | 11 | 01 |
| 0111 | 01 | 11 |

### Simulation Output

```
a=0000 upper=00 lower=00
a=1010 upper=10 lower=10
a=1101 upper=11 lower=01
a=0111 upper=01 lower=11
```

### What I Learned

- Individual bits are accessed using indexing (`a[0]`).
- Groups of bits are extracted using part-select (`a[3:2]`).
- Verilog numbers bits from **LSB (0)** to **MSB (N-1)**.
- A single vector can be split into multiple outputs without extra logic.

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
*Next: Q13 — Reverse Bits using Concatenation*