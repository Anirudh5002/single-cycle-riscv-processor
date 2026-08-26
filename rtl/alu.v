`timescale 1ns/1ps
module alu(
    input [31:0] s1val,
    input [31:0] alu_b,
    input [2:0] alu_control,
    output reg [31:0] alu_out
);

    always @(*) begin

        case (alu_control)

            3'b000:
                alu_out = s1val + alu_b; //ADD

            3'b001:
                alu_out = s1val - alu_b;  //SUB

            3'b010:
                alu_out = s1val & alu_b;  //AND

            3'b011:
                alu_out = s1val | alu_b;  //OR

            3'b100:
                alu_out = s1val ^ alu_b;  //XOR

            default:
                alu_out = 32'b0;

        endcase

    end

endmodule
