# Spartan-6 DSP48A1 Slice Implementation

## Project Overview

This project implements and verifies the DSP48A1 slice of the Xilinx Spartan-6 FPGA series. The DSP48A1 primitive is a versatile, math-intensive building block optimized for digital signal processing tasks, offering configurable pipeline registers, pre- and post-adders, and carry chains. The design covers RTL development, directed testbench verification in ModelSim/QuestaSim, synthesis and implementation in Vivado, and timing closure at 100 MHz on the XC7A200T‑FFG1156‑3 device.

## Table of Contents

1. [Features](#features)
2. [Prerequisites](#prerequisites)
3. [Project Structure](#project-structure)
4. [Getting Started](#getting-started)
   - [RTL Compilation](#rtl-compilation)
   - [Testbench Simulation](#testbench-simulation)
   - [Do-File Flow](#do-file-flow)
   - [Vivado Implementation](#vivado-implementation)
5. [Deliverables](#deliverables)
6. [Parameterization & Configuration](#parameterization--configuration)
7. [References](#references)

---

## Features

- **Configurable Pipeline Registers**: A0REG, A1REG, B0REG, B1REG, CREG, DREG, MREG, PREG, CARRYINREG, CARRYOUTREG, OPMODEREG.
- **Pre-Adder/Subtracter**: Supports D±B operations before multiplication.
- **Multiplier**: 18×18-bit signed/unsigned multiplication with optional pipelining.
- **Post-Adder/Subtracter**: Supports accumulation via Z‑multiplexer and carry chain operations.
- **Carry Cascade**: Dedicated CARRYIN/CARRYOUT ports for high‑speed cascaded arithmetic.
- **Dynamic Operation Modes**: Controlled by 6‑bit OPMODE input for flexible arithmetic functions.

## Prerequisites

- Xilinx Vivado 2018.3 (or later)
- Mentor Graphics ModelSim/QuestaSim
- GNU Make (optional)
- FPGA Board: Basys3-compatible connector assignment, target device XC7A200T‑FFG1156‑3
- Constraint file (`constraints.xdc`) specifying 100 MHz clock on pin W5

## Project Structure

```plaintext
Project1/
├── rtl/
│   └── dsp48a1.v           # RTL implementation of DSP48A1 slice
├── tb/
│   ├── dsp48a1_tb.v        # Directed testbench source
│   └── dofile.do           # QuestaSim DO file for batch simulation
├── vivado/
│   ├── constraints.xdc     # Timing constraint for 100 MHz clock
│   └── project.tcl         # Tcl script to automate Vivado flow
├── docs/
│   └── QuestaSim_snippets.pdf  # Waveform snapshots with input/output values
└── README.md
```

## Getting Started

### RTL Compilation

1. Navigate to the `rtl/` directory:
   ```bash
   cd Project1/rtl
   ```
2. Compile the design:
   ```bash
   vlog dsp48a1.v
   ```

### Testbench Simulation

1. In the `tb/` directory, launch QuestaSim:
   ```bash
   cd ../tb
   vsim -c -do dofile.do
   ```
2. The `dofile.do` script will:
   - Compile RTL and testbench
   - Apply directed input patterns
   - Compare simulation outputs against expected values
   - Dump waveforms to `wave.vcd`
3. Review waveforms or generated reports to verify pass/fail for each test vector.

### Do-File Flow

- The `tb/dofile.do` contains commands for automated simulation flow:
  ```tcl
  vlog ../rtl/dsp48a1.v
  vlog dsp48a1_tb.v
  vsim work.dsp48a1_tb -do "run -all; quit"
  ```
- Adjust test patterns or add asserts within the testbench for additional coverage.

### Vivado Implementation

1. Open Vivado and source the TCL script:
   ```bash
   cd ../vivado
   vivado -mode batch -source project.tcl
   ```
2. The `project.tcl` performs:
   - Elaboration, synthesis, and implementation
   - Reports generation for utilization, timing, and schematic snapshots
   - Ensures zero critical warnings/errors in Messages tab
3. Inspect generated reports in `vivado/runs/`.

## Deliverables

1. **RTL Code** (`rtl/dsp48a1.v`)
2. **Testbench Code** (`tb/dsp48a1_tb.v`)
3. **DO File** (`tb/dofile.do`)
4. **QuestaSim Snippets** (`docs/QuestaSim_snippets.pdf`)
5. **Constraint File** (`vivado/constraints.xdc`)
6. **Elaboration Reports** (Messages & Schematic PDF)
7. **Synthesis Reports** (Utilization & Timing)
8. **Implementation Reports** (Utilization, Timing & Device Snippets)

## Parameterization & Configuration

| Parameter   | Default | Description                         |
| ----------- | ------- | ----------------------------------- |
| A0REG/A1REG | 0/1     | Pipeline stages for input A         |
| B0REG/B1REG | 0/1     | Pipeline stages for input B         |
| CREG/DREG   | 1/0     | Registers for C and D paths         |
| MREG/PREG   | 1/1     | Registers for multiplier and output |
| CARRYINSEL  | OPMODE5 | Carry source selection              |
| B_INPUT     | DIRECT  | B vs. cascade input selection       |
| RSTTYPE     | SYNC    | Reset synchronization mode          |

## References

- Xilinx DSP48A1 User Guide (UG389)

---

*Prepared by Karim Mohamed, April 2025*

