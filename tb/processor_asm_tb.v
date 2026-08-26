`timescale 1ns/1ps

module processor_asm_tb;

    reg clk;
    reg reset;

    processor DUT(
        .clk(clk),
        .reset(reset)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reset = 1;

        #20;
        reset = 0;

        #150;

        $display("");
        $display("========================================");
        $display("       RISC-V ASSEMBLER PROGRAM");
        $display("========================================");

        $display("");
        $display("REGISTER VALUES");
        $display("----------------------------------------");

        $display("x0  = %0d", DUT.RF.registers[0]);
        $display("x1  = %0d", DUT.RF.registers[1]);
        $display("x2  = %0d", DUT.RF.registers[2]);
        $display("x3  = %0d", DUT.RF.registers[3]);
        $display("x4  = %0d", DUT.RF.registers[4]);
        $display("x5  = %0d", DUT.RF.registers[5]);
        $display("x6  = %0d", DUT.RF.registers[6]);
        $display("x7  = %0d", DUT.RF.registers[7]);
        $display("x8  = %0d", DUT.RF.registers[8]);
        $display("x9  = %0d", DUT.RF.registers[9]);
        $display("x10 = %0d", DUT.RF.registers[10]);
        $display("x11 = %0d", DUT.RF.registers[11]);
        $display("x12 = %0d", DUT.RF.registers[12]);
        $display("x13 = %0d", DUT.RF.registers[13]);
        $display("x14 = %0d", DUT.RF.registers[14]);
        $display("x15 = %0d", DUT.RF.registers[15]);

        $display("");
        $display("DATA MEMORY");
        $display("----------------------------------------");

        $display("Memory[0] = %0d", DUT.DMEM.memory[0]);
        $display("Memory[1] = %0d", DUT.DMEM.memory[1]);
        $display("Memory[2] = %0d", DUT.DMEM.memory[2]);
        $display("Memory[3] = %0d", DUT.DMEM.memory[3]);

        $display("");
        $display("PROGRAM COUNTER");
        $display("----------------------------------------");

        $display("PC = %0d", DUT.pc_out);

        $display("");
        $display("========================================");
        $display("       SIMULATION COMPLETED");
        $display("========================================");

        $finish;

    end

endmodule
