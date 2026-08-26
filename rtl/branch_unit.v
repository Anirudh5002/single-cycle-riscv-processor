`timescale 1ns/1ps
module branch_unit(
    input [1:0] Branch_type,
    input [31:0] alu_out,

    output reg branch_taken
);

    always @(*) begin

        case (Branch_type)

            // No branch
            2'b00: begin
                branch_taken = 1'b0;
            end


            // BEQ
            2'b01: begin

                if (alu_out == 32'b0)
                    branch_taken = 1'b1;
                else
                    branch_taken = 1'b0;

            end


            // BNE
            2'b10: begin

                if (alu_out != 32'b0)
                    branch_taken = 1'b1;
                else
                    branch_taken = 1'b0;

            end


            default: begin
                branch_taken = 1'b0;
            end

        endcase

    end

endmodule
