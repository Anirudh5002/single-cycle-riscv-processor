`timescale 1ns/1ps
module pc(
    input clk,
    input rst,
    input mux,
    input [31:0] imm,
    output reg [31:0] pc_out
);

    wire [31:0] pc_4;
    wire [31:0] ta;

    assign pc_4 = pc_out + 32'd4;
    assign ta   = pc_out + imm;

    always @(posedge clk) begin
        if (rst)
            pc_out <= 32'b0;
        else begin
            if (mux)
                pc_out <= ta;
            else
                pc_out <= pc_4;
        end
    end

endmodule
