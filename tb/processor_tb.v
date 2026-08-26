`timescale 1ns/1ps

module processor_tb;

    reg clk;
    reg reset;

    processor dut(
        .clk(clk),
        .reset(reset)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reset = 1;

        dut.IMEM.memory[0]  = 32'h00F00093;
        dut.IMEM.memory[1]  = 32'h00600113;
        dut.IMEM.memory[2]  = 32'h002081B3;
        dut.IMEM.memory[3]  = 32'h40208233;
        dut.IMEM.memory[4]  = 32'h0020F2B3;
        dut.IMEM.memory[5]  = 32'h0020E333;
        dut.IMEM.memory[6]  = 32'h0020C3B3;
        dut.IMEM.memory[7]  = 32'h01900413;
        dut.IMEM.memory[8]  = 32'h00747493;
        dut.IMEM.memory[9]  = 32'h00302023;
        dut.IMEM.memory[10] = 32'h00002503;
        dut.IMEM.memory[11] = 32'h00A18463;
        dut.IMEM.memory[12] = 32'h06F00593;
        dut.IMEM.memory[13] = 32'h00419463;
        dut.IMEM.memory[14] = 32'h0DE00613;
        dut.IMEM.memory[15] = 32'h008006EF;
        dut.IMEM.memory[16] = 32'h06300713;
        dut.IMEM.memory[17] = 32'h07B00793;
        dut.IMEM.memory[18] = 32'h0000006F;

        #12;
        reset = 0;

        #160;

        $display("");
        $display("========================================");
        $display("       RISC-V PROCESSOR RESULTS");
        $display("========================================");

        $display("");
        $display("REGISTER VALUES");
        $display("----------------------------------------");

        $display("x0  = %0d", dut.RF.registers[0]);
        $display("x1  = %0d", dut.RF.registers[1]);
        $display("x2  = %0d", dut.RF.registers[2]);
        $display("x3  = %0d", dut.RF.registers[3]);
        $display("x4  = %0d", dut.RF.registers[4]);
        $display("x5  = %0d", dut.RF.registers[5]);
        $display("x6  = %0d", dut.RF.registers[6]);
        $display("x7  = %0d", dut.RF.registers[7]);
        $display("x8  = %0d", dut.RF.registers[8]);
        $display("x9  = %0d", dut.RF.registers[9]);
        $display("x10 = %0d", dut.RF.registers[10]);
        $display("x11 = %0d", dut.RF.registers[11]);
        $display("x12 = %0d", dut.RF.registers[12]);
        $display("x13 = %0d", dut.RF.registers[13]);
        $display("x14 = %0d", dut.RF.registers[14]);
        $display("x15 = %0d", dut.RF.registers[15]);

        $display("");
        $display("DATA MEMORY");
        $display("----------------------------------------");

        $display("Memory[0] = %0d", dut.DMEM.memory[0]);
        $display("Memory[1] = %0d", dut.DMEM.memory[1]);
        $display("Memory[2] = %0d", dut.DMEM.memory[2]);
        $display("Memory[3] = %0d", dut.DMEM.memory[3]);

        $display("");
        $display("PROGRAM COUNTER");
        $display("----------------------------------------");

        $display("PC = %0d", dut.pc_out);

        $display("");
        $display("========================================");
        $display("       SIMULATION COMPLETED");
        $display("========================================");

        $finish;

    end

endmodule
