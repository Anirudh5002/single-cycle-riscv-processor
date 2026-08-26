`timescale 1ns/1ps
module regfile(
    input  clk,
    input  reset,

    input  [4:0]  s1reg,
    input  [4:0]  s2reg,

    input  [4:0]  wb_register,
    input  reg_write,

    input  [31:0] wb_value,

    output [31:0] s1val,
    output [31:0] s2val
);

    reg [31:0] registers [0:31];

    integer i;

    // READ PORT 1

    assign s1val = registers[s1reg];

    // READ PORT 2

    assign s2val = registers[s2reg];

    // WRITE PORT


    always @(posedge clk) begin

        if (reset) begin

            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'b0;

        end

        else if (reg_write && (wb_register != 5'b0)) begin

            registers[wb_register] <= wb_value;

        end

    end

endmodule
