# Level 3 — Always Blocks and Combinational Logic

> **Part of:** [verilog-questions](../) — Verilog HDL learning from zero to FSM-based project  
> **Tools:** Icarus Verilog · GTKWave · VS Code  
> **Status:** 🔄 In Progress — Day 1 (Q19 done)

---

## What This Level Covers

Moving from `assign` statements to `always @(*)` blocks — a more powerful way to describe combinational logic using if/else and case statements.

DSA equivalent: If/else logic, switch/case, conditional expressions  
Verilog equivalent: always @(*), if/else, case inside hardware

**Two rules that never change in this level:**
- Outputs driven inside always blocks must be declared as `reg` not `wire`
- Use blocking assignment `=` inside always @(*) — never `<=`

---

## Progress

| # | File | What It Does | Status |
|---|------|-------------|--------|
| Q19 | `q19_mux2to1.v` | 2-to-1 Multiplexer using if/else | ✅ Done |
| Q20 | `q20_mux4to1.v` | 4-to-1 Multiplexer using case | ⬜ Not Started |
| Q21 | `q21_priority.v` | Priority Encoder — highest active input | ⬜ Not Started |
| Q22 | `q22_sevenseg.v` | 7-Segment Display Decoder | ⬜ Not Started |
| Q23 | `q23_comparator.v` | 2-bit Comparator — gt, eq, lt outputs | ⬜ Not Started |
| Q24 | `q24_alu.v` | 4-bit ALU — add, sub, AND, OR | ⬜ Not Started |
| Q25 | `q25_barrel.v` | Barrel Shifter — shift left by N | ⬜ Not Started |

---

## How to Run

```bash
iverilog -o output q19_mux2to1.v q19_mux2to1_tb.v
vvp output
gtkwave dump.vcd
```

---

## Q19 — 2-to-1 Multiplexer

**What it does:** Selects between two inputs based on a select signal. When sel=0 output follows a, when sel=1 output follows b.  
**Real world use:** Data selection in buses, routing signals between different parts of a circuit, choosing between two data sources.

**Code:**
```verilog
module q19_mux2to1(
    input  a,
    input  b,
    input  sel,
    output reg out
);
    always @(*) begin
        if (sel)
            out = b;
        else
            out = a;
    end
endmodule
```

**Truth Table:**

| sel | out |
|-----|-----|
| 0   | a   |
| 1   | b   |

**Simulation output:**
time=0  | a=0 b=0 sel=0 | out=0
time=10 | a=0 b=1 sel=0 | out=0
time=20 | a=0 b=1 sel=1 | out=1
time=30 | a=1 b=0 sel=0 | out=1
time=40 | a=1 b=0 sel=1 | out=0
time=50 | a=1 b=1 sel=1 | out=1

**What I learned:**  
Unlike `assign`, the `always @(*)` block re-evaluates whenever any input signal changes. The `*` means "watch all signals used inside this block." Output must be `reg` because always blocks can only drive reg types — even though the output behaves like combinational logic with no memory.

---

## Key Concepts So Far

| Concept | What It Means |
|---------|--------------|
| `always @(*)` | Runs whenever any input signal changes — combinational |
| `reg` output | Required for signals driven inside always blocks |
| `=` blocking | Used inside always @(*) — executes in order |
| `if/else` | Conditional logic — hardware selects between options |

---

*Updated as questions are completed*  
*Next: Q20 4-to-1 Mux using case statement*  
*Previous: [Level 2 — Vectors](../level2-vectors/README.md)*