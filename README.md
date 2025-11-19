# MIPS Single-Cycle Processor Implementation in VHDL

This repository contains the VHDL implementation of a simplified, single-cycle **MIPS Processor**. The design is modular, featuring all core components of a classic MIPS architecture, which are then structurally connected to form the complete processor datapath.

## 🚀 Project Overview

The processor is designed to execute a subset of MIPS instructions, including R-type (arithmetic/logic), I-type (data transfer and immediate arithmetic), and branch instructions.

### Supported Operations:
The implemented instruction set includes:
* **Arithmetic/Immediate:** `add`, `sub`, `addi`
* **Data Transfer (Memory):** `lw` (Load Word), `sw` (Store Word)
* **Control Flow:** `bne` (Branch Not Equal)

## 🛠️ Design Components

The complete MIPS datapath is built from the following individual VHDL components, each defined with its own entity and architecture:

| Component | VHDL File | Description |
| :--- | :--- | :--- |
| **Control Unit** | `ControlUnit.vhd` | [cite_start]Generates control signals (e.g., `RegWrite`, `MemWrite`, `Branch`) based on the instruction **Opcode**[cite: 6, 7]. |
| **ALU Control** | `ALUControl.vhd` | [cite_start]Determines the specific ALU operation based on `ALUop` and `Funct` fields[cite: 22]. |
| **ALU** | `ALU.vhd` | [cite_start]Performs arithmetic and logical operations[cite: 20]. |
| **Register File** | `RegisterFile.vhd` | [cite_start]Stores 16 general-purpose registers (32-bit each), handling read and write operations[cite: 23, 24]. |
| **Instruction Memory (ROM)** | `InstructionMemory.vhd` | [cite_start]Stores the program instructions in a 16x32-bit array[cite: 25, 27]. |
| **Data Memory (RAM)** | `DataMemory.vhd` | [cite_start]Stores and retrieves data using a 16x32-bit array[cite: 12, 13]. |
| **Program Counter (PC)** | `ProgramCounter.vhd` | [cite_start]Sequential component that holds the address of the current instruction[cite: 52]. |
| **Sign Extender** | `SignExtender.vhd` | [cite_start]Extends a 16-bit immediate value to 32 bits based on the MSB (sign bit)[cite: 16, 17]. |
| **Multiplexers** | `MUX5.vhd`, `MUX32.vhd` | [cite_start]2-to-1 multiplexers for selecting data paths (5-bit and 32-bit)[cite: 8, 10]. |
| **Full Adder** | `FullAdder.vhd` | [cite_start]32-bit full adder for PC increments and branch calculations[cite: 14]. |
| **Other Logic** | `ANDgate.vhd`, `LeftShift.vhd` | [cite_start]Supporting logic gates and a 32-bit left shifter[cite: 47, 18]. |

## 📁 Repository Structure

The core implementation is contained in the following files:

* [cite_start]`ICE22390240_TSOUCHLIS_02_MIPS.vhd`: The **top-level entity** that structurally connects all the components above to form the complete MIPS processor datapath[cite: 2].
* [cite_start]`ICE22390240_TSOUCHLIS_03_testbench.vhd`: The testbench for simulating the main processor design[cite: 2].
* `*.vhd` (12 files): The source code for all individual components (ALU, Register File, Control Unit, etc.).
* `*testbench.vhd` (12 files): Testbenches for each individual component.

## ⚙️ Execution and Simulation

The project was primarily intended for simulation within a VHDL environment (e.g., ModelSim/QuestaSim).

### Simulation Steps:

1.  Start the simulation environment.
2.  Set the working library to `work`.
3.  Load the testbench entity: `work.ice22390240_tsouchlis_03_testbench(behavioral)`.
4.  Add all relevant signals and ports to the wave view.
5.  Run the simulation (e.g., `Run -All`).
