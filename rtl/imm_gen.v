`timescale 1ns/1ps
module imm_gen(
    input [31:0] instr,
    output reg [31:0] imm_out
);

    wire [6:0] opcode = instr[6:0];

    always @(*) begin

        case (opcode)

            
            // I-TYPE : ADDI, ANDI
            // LOAD   : LW
   
            7'b0010011,
            7'b0000011:
                imm_out = {{20{instr[31]}},
                           instr[31:20]};

            // S-TYPE : SW
          
            7'b0100011:
                imm_out = {{20{instr[31]}},
                           instr[31:25],
                           instr[11:7]};

            // B-TYPE : BEQ, BNE
            
            7'b1100011:
                imm_out = {{19{instr[31]}},
                           instr[31],
                           instr[7],
                           instr[30:25],
                           instr[11:8],
                           1'b0};

            // J-TYPE : JAL
            7'b1101111:
                imm_out = {{11{instr[31]}},
                           instr[31],
                           instr[19:12],
                           instr[20],
                           instr[30:21],
                           1'b0};

            // DEFAULT
           
            default:
                imm_out = 32'b0;

        endcase

    end

endmodule
