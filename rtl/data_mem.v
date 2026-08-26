`timescale 1ns/1ps
module data_mem(
    input clk,
    input Memread,
    input Memwrite,

    input [31:0] address,
    input [31:0] write_data,

    output reg [31:0] read_data
);

    reg [31:0] memory [0:255];

    // READ

    always @(*) begin

        if (Memread)
            read_data = memory[address[9:2]];
        else
            read_data = 32'b0;

    end

    // WRITE

    always @(posedge clk) begin

        if (Memwrite)
            memory[address[9:2]] <= write_data;

    end

endmodule
