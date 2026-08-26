`timescale 1ns/1ps
module instr_mem(
    input [31:0] address,
    output [31:0] instruction
);

    reg [31:0] memory [0:255];

    initial begin
        $readmemh("test_words.hex", memory);
    end

    assign instruction = memory[address[9:2]];

endmodule
