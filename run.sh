#!/bin/bash

echo "========================================"
echo "       RISC-V ASSEMBLY BUILD"
echo "========================================"

riscv64-unknown-elf-gcc \
-march=rv32i \
-mabi=ilp32 \
-nostdlib \
-Ttext=0x0 \
-o test.elf programs/test.s

if [ $? -ne 0 ]; then
    echo "ASSEMBLY FAILED"
    exit 1
fi

riscv64-unknown-elf-objdump -d test.elf | \
awk '/^[[:space:]]+[0-9a-f]+:/{print $2}' > test_words.hex

echo ""
echo "Generated instructions:"
cat test_words.hex

echo ""
echo "========================================"
echo "       VERILATOR BUILD"
echo "========================================"

verilator --binary --timing \
--top-module processor_asm_tb \
rtl/processor_top.v \
rtl/pc.v \
rtl/instr_mem.v \
rtl/imm_gen.v \
rtl/control_unit.v \
rtl/reg_file.v \
rtl/alu_mux.v \
rtl/alu.v \
rtl/data_mem.v \
rtl/branch_unit.v \
rtl/wbmux.v \
tb/processor_asm_tb.v

if [ $? -ne 0 ]; then
    echo "VERILATOR BUILD FAILED"
    exit 1
fi

echo ""
echo "========================================"
echo "       RUNNING PROCESSOR"
echo "========================================"

./obj_dir/Vprocessor_asm_tb
