# Level 1 — Basics: Wire, Gates, Assign

> **Part of:** [verilog-practice](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · VS Code  
> **Status:** 🔄 In Progress — Day 1 (Q1–Q3 done)

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
| Q4 | `q04_or.v` | OR of two inputs | ⬜ Not Started |
| Q5 | `q05_xor.v` | XOR of two inputs | ⬜ Not Started |
| Q6 | `q06_xnor.v` | XNOR of two inputs | ⬜ Not Started |
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

## Q1 — Simple Wire

**What it does:** Passes input signal directly to output. No logic, just a connection.  
**Real world use:** Signal routing between modules in larger designs.

**Code:**
```verilog
module q01_wire(input in, output out);
    assign out = in;
endmodule
```

**Truth Table:**

| in | out |
|----|-----|
| 0  | 0   |
| 1  | 1   |

**Simulation output:**
```
time=0  | in=0 | out=0
time=10 | in=1 | out=1
```

**What I learned:**  
`assign` continuously connects one signal to another — it is not a one-time statement like in programming. The output follows the input at all times.

---

## Q2 — NOT Gate

**What it does:** Inverts the input. Output is always the opposite of input.  
**Real world use:** Signal inversion, enable/disable control logic.

**Code:**
```verilog
module q02_not(input in, output out);
    assign out = ~in;
endmodule
```

**Truth Table:**

| in | out |
|----|-----|
| 0  | 1   |
| 1  | 0   |

**Simulation output:**
```
time=0  | in=0 | out=1
time=10 | in=1 | out=0
```

**What I learned:**  
`~` is the bitwise NOT operator in Verilog. For a single bit it simply flips the value.

---

## Q3 — AND Gate

**What it does:** Output is HIGH only when both inputs are HIGH.  
**Real world use:** Enable signals — output is active only when all conditions are true simultaneously.

**Code:**
```verilog
module q03_and(input a, input b, output out);
    assign out = a & b;
endmodule
```

**Truth Table:**

| a | b | out |
|---|---|-----|
| 0 | 0 | 0   |
| 0 | 1 | 0   |
| 1 | 0 | 0   |
| 1 | 1 | 1   |

**Simulation output:**
```
time=0  | a=0 b=0 | out=0
time=10 | a=0 b=1 | out=0
time=20 | a=1 b=0 | out=0
time=30 | a=1 b=1 | out=1
```

**What I learned:**  
`&` is the bitwise AND operator. Output is 1 only at time=30 when both a and b are 1 — matches exactly what the truth table says.

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
*Next: Q4 OR gate, Q5 XOR gate, Q6 XNOR gate*