`timescale 1ns/1ps
module alu_mux(
    input [31:0] s2val,
    input [31:0] imm_out,
    input alusrc,
    output reg [31:0] alu_b
);

    always @(*) begin

        if (alusrc)
            alu_b = imm_out; //selects immediate value
        else
            alu_b = s2val;  //selects the second register's value

    end

endmodule
