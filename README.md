# Single-Cycle RISC-V Processor

A 32-bit single-cycle RISC-V processor implemented using Verilog HDL.

The processor is designed around the RISC-V RV32I architecture and is verified using Verilator with a RISC-V assembly test program.

## Features

- 32-bit single-cycle processor
- Verilog RTL implementation
- RISC-V RV32I-based instruction execution
- 32 general-purpose registers
- Program Counter (PC)
- Instruction memory
- Register file
- Immediate generator
- Control unit
- ALU
- ALU input multiplexer
- Data memory
- Branch unit
- Write-back multiplexer
- RISC-V assembly program execution
- Verilator-based simulation

## Supported Instructions

The current RTL supports the following instruction types:

### Arithmetic
- ADD
- SUB
- ADDI

### Logical
- AND
- OR
- XOR
- ANDI

### Memory
- LW
- SW

### Branch
- BEQ
- BNE

Additional instructions can be added as the processor is extended.

## Project Structure

```text
Single_cycle_RISC-V/
│
├── rtl/
│   ├── processor_top.v
│   ├── pc.v
│   ├── instr_mem.v
│   ├── imm_gen.v
│   ├── control_unit.v
│   ├── reg_file.v
│   ├── alu_mux.v
│   ├── alu.v
│   ├── data_mem.v
│   ├── branch_unit.v
│   └── wbmux.v
│
├── tb/
│   ├── processor_asm_tb.v
│   └── processor_tb.v
│
├── programs/
│   └── test.s
│
├── constraints/
├── docs/
├── run.sh
├── .gitignore
└── README.md
```

## Processor Architecture

The processor consists of the following major blocks:

```text
                  ┌──────────────┐
                  │      PC      │
                  └──────┬───────┘
                         │
                         ▼
                ┌─────────────────┐
                │ Instruction Mem │
                └────────┬────────┘
                         │
                         ▼
                ┌─────────────────┐
                │   Control Unit  │
                └────────┬────────┘
                         │
              ┌──────────┴──────────┐
              ▼                     ▼
       ┌──────────────┐      ┌──────────────┐
       │ Register File│      │ Immediate Gen│
       └──────┬───────┘      └──────┬───────┘
              │                     │
              └──────────┬──────────┘
                         ▼
                    ┌─────────┐
                    │   ALU   │
                    └────┬────┘
                         │
                ┌────────┴────────┐
                ▼                 ▼
         ┌─────────────┐    ┌─────────────┐
         │ Data Memory │    │ Branch Unit │
         └──────┬──────┘    └─────────────┘
                │
                ▼
           ┌──────────┐
           │   WBMUX  │
           └────┬─────┘
                │
                ▼
          Register File
```

## Assembly Program

The processor can execute RISC-V assembly programs.

The current test program is located at:

```text
programs/test.s
```

Example instructions used in the test program include:

```asm
addi x1, x0, 5
addi x2, x0, 67

add  x3, x1, x2
sub  x4, x3, x1

and  x5, x1, x2
or   x6, x1, x2
xor  x7, x1, x2

andi x8, x2, 15

sw   x3, 0(x0)
lw   x9, 0(x0)

beq  x9, x3, loop
```

The assembly program is compiled using the RISC-V GNU toolchain and converted into instruction data for the processor's instruction memory.

## Simulation

### Tools

- Verilog HDL
- RISC-V GNU Toolchain
- Verilator
- Ubuntu Linux

### Build and Run

From the project root:

```bash
./run.sh
```

The script performs the following steps:

1. Compiles the RISC-V assembly program.
2. Generates the instruction memory data.
3. Compiles the Verilog RTL and testbench using Verilator.
4. Builds the simulation executable.
5. Runs the processor simulation.

## Verification

The processor has been successfully compiled and simulated using Verilator.

The project contains two testbenches:

```text
tb/processor_tb.v
tb/processor_asm_tb.v
```

The assembly-based testbench verifies execution of the RISC-V program through the processor datapath.

## Generated Files

The following files are generated during compilation or simulation and are not intended to be committed to the repository:

```text
obj_dir/
*.elf
*.o
*.d
test.hex
test_words.hex
*.vcd
*.fst
*.log
```

These files are excluded using `.gitignore`.

## Project Status

The current version implements a basic single-cycle RISC-V processor with arithmetic, logical, memory and branch functionality.

These are my future enhancement ideas:

- Additional RV32I instructions
- More extensive verification
- Improved memory organization
- Pipeline implementation
- Hazard handling
