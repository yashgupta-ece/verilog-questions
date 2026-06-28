# Level 1 — Basics: Wire, Gates, Assign

> **Part of:** [verilog-practice](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · VS Code  
> **Status:** 🔄 In Progress — Day 2 (Q1–Q6 done)

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
| Q7 | `q07_nand_nor.v` | NAND and NOR in same module | ⬜ Not Started |
| Q8 | `q08_half_adder.v` | Sum and carry from two inputs | ⬜ Not Started |
| Q9 | `q09_full_adder.v` | Three inputs, sum and carry | ⬜ Not Started |
| Q10 | `q10_7458.v` | Implements the real 7458 IC logic | ⬜ Not Started |

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

## Q4 — OR Gate

**What it does:** Output is HIGH when at least one input is HIGH.
**Real world use:** Combining multiple signals — if any condition is true, output activates.

**Code:**
```verilog
module q04_or(input a, input b, output out);
    assign out = a | b;
endmodule
```

**Truth Table:**

| a | b | out |
|---|---|-----|
| 0 | 0 | 0   |
| 0 | 1 | 1   |
| 1 | 0 | 1   |
| 1 | 1 | 1   |

**Simulation output:**
```
time=0  | a=0 b=0 | out=0
time=10 | a=0 b=1 | out=1
time=20 | a=1 b=0 | out=1
time=30 | a=1 b=1 | out=1
```

**What I learned:**  
`|` is the bitwise OR operator. Output is 0 only when both inputs are 0 — any single HIGH input is enough to make output HIGH.

---

## Q5 — XOR Gate

**What it does:** Output is HIGH only when inputs are different from each other.  
**Real world use:** Parity checking, comparators, and generating the sum bit in adders.

**Code:**
```verilog
module q05_xor(input a, input b, output out);
    assign out = a ^ b;
endmodule
```

**Truth Table:**

| a | b | out |
|---|---|-----|
| 0 | 0 | 0   |
| 0 | 1 | 1   |
| 1 | 0 | 1   |
| 1 | 1 | 0   |

**Simulation output:**
```
time=0  | a=0 b=0 | out=0
time=10 | a=0 b=1 | out=1
time=20 | a=1 b=0 | out=1
time=30 | a=1 b=1 | out=0
```

**What I learned:**  
`^` is the XOR operator. When both inputs are same — whether both 0 or both 1 — output is 0. This is why XOR is used for the sum bit in a half adder — 1+1 gives sum=0 with a carry.

---

## Q6 — XNOR Gate

**What it does:** Output is HIGH only when both inputs are the same. Opposite of XOR.  
**Real world use:** Equality checkers — used when you want to detect if two signals match.

**Code:**
```verilog
module q06_xnor(input a, input b, output out);
    assign out = ~(a ^ b);
endmodule
```

**Truth Table:**

| a | b | out |
|---|---|-----|
| 0 | 0 | 1   |
| 0 | 1 | 0   |
| 1 | 0 | 0   |
| 1 | 1 | 1   |

**Simulation output:**
```
time=0  | a=0 b=0 | out=1
time=10 | a=0 b=1 | out=0
time=20 | a=1 b=0 | out=0
time=30 | a=1 b=1 | out=1
```

**What I learned:**  
XNOR is just XOR with a NOT on the output — `~(a ^ b)`. It outputs 1 when inputs are equal, which is the exact opposite of XOR. This makes it naturally useful as an equality checker.

---


## Key Concepts So Far

| Concept | What It Means |
|---------|--------------|
| `module` | A hardware block with defined inputs and outputs |
| `input` / `output` | Ports — how signals enter and leave a module |
| `assign` | Continuously drives a wire — always active, not a one-time execution |
| `wire` | Carries a value but cannot store it — no memory |
| `~` | Bitwise NOT — flips 0 to 1 and 1 to 0 |
| `&` | Bitwise AND — output 1 only when all inputs are 1 |
| `$monitor` | Prints to terminal whenever any listed signal changes |

---

## Testbench Pattern Used for All Questions

```verilog
module q01_wire_tb;
    reg in;
    wire out;

    q01_wire uut (.in(in), .out(out));

    initial begin
        $monitor("time=%0t | in=%b | out=%b", $time, in, out);
        in = 0; #10;
        in = 1; #10;
        $finish;
    end
endmodule
```

---

*Updated daily as questions are completed*  
*Next: Q7 NAND/NOR gate, Q8 Half Adder, Q9 Full Adder, Q10 7458 chip*