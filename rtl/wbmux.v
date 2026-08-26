`timescale 1ns/1ps
module wbmux(
    input [31:0] pc_4,
    input [31:0] mem_data,
    input [31:0] alu_out,

    input [1:0] wbsel,

    output reg [31:0] wb_out
);

    always @(*) begin

        case (wbsel)

            // ALU result
            2'b00:
                wb_out = alu_out;

            // Data memory
            2'b01:
                wb_out = mem_data;

            // PC + 4
            2'b10:
                wb_out = pc_4;

            default:
                wb_out = 32'b0;

        endcase

    end

endmodule
