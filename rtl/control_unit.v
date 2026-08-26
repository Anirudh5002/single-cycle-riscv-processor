`timescale 1ns/1ps
module control_unit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg ALUsrc,
    output reg [2:0] ALU_control,
    output reg Regwrite,
    output reg Memread,
    output reg Memwrite,
    output reg [1:0] Branch_type,
    output reg jump,
    output reg [1:0] wbsel
);

    always @(*) begin

    
        // DEFAULT VALUES

        ALUsrc      = 1'b0;
        ALU_control = 3'b000;
        Regwrite    = 1'b0;
        Memread     = 1'b0;
        Memwrite    = 1'b0;
        Branch_type = 2'b00;
        jump        = 1'b0;
        wbsel       = 2'b00;


        case (opcode)

            // R-TYPE
            // ADD, SUB, AND, OR, XOR

            7'b0110011: begin

                if (funct3 == 3'b000) begin

                    case (funct7)

                        // ADD
                        7'b0000000: begin
                            ALU_control = 3'b000;
                            ALUsrc      = 1'b0;
                            Regwrite    = 1'b1;
                            wbsel       = 2'b00;
                        end

                        // SUB
                        7'b0100000: begin
                            ALU_control = 3'b001;
                            ALUsrc      = 1'b0;
                            Regwrite    = 1'b1;
                            wbsel       = 2'b00;
                        end

                        default: begin
                        end

                    endcase

                end

                // AND
                else if (funct3 == 3'b111) begin
                    ALU_control = 3'b010;
                    ALUsrc      = 1'b0;
                    Regwrite    = 1'b1;
                    wbsel       = 2'b00;
                end

                // OR
                else if (funct3 == 3'b110) begin
                    ALU_control = 3'b011;
                    ALUsrc      = 1'b0;
                    Regwrite    = 1'b1;
                    wbsel       = 2'b00;
                end

                // XOR
                else if (funct3 == 3'b100) begin
                    ALU_control = 3'b100;
                    ALUsrc      = 1'b0;
                    Regwrite    = 1'b1;
                    wbsel       = 2'b00;
                end

            end

            // I-TYPE
            // ADDI, ANDI

            7'b0010011: begin

                case (funct3)

                    // ADDI
                    3'b000: begin
                        ALU_control = 3'b000;
                        ALUsrc      = 1'b1;
                        Regwrite    = 1'b1;
                        wbsel       = 2'b00;
                    end

                    // ANDI
                    3'b111: begin
                        ALU_control = 3'b010;
                        ALUsrc      = 1'b1;
                        Regwrite    = 1'b1;
                        wbsel       = 2'b00;
                    end

                    default: begin
                    end

                endcase

            end

            // LW
     

            7'b0000011: begin

                ALU_control = 3'b000;
                ALUsrc      = 1'b1;
                Regwrite    = 1'b1;
                Memread     = 1'b1;
                Memwrite    = 1'b0;
                Branch_type = 2'b00;
                jump        = 1'b0;
                wbsel       = 2'b01;

            end

            // SW
      

            7'b0100011: begin

                ALU_control = 3'b000;
                ALUsrc      = 1'b1;
                Regwrite    = 1'b0;
                Memread     = 1'b0;
                Memwrite    = 1'b1;
                Branch_type = 2'b00;
                jump        = 1'b0;
                wbsel       = 2'b00;

            end


            
            // BEQ/BNE

            7'b1100011: begin

                case (funct3)

                    // BEQ
                    3'b000: begin

                        ALU_control = 3'b001;
                        ALUsrc      = 1'b0;
                        Regwrite    = 1'b0;
                        Memread     = 1'b0;
                        Memwrite    = 1'b0;
                        Branch_type = 2'b01;
                        jump        = 1'b0;
                        wbsel       = 2'b00;

                    end


                    // BNE
                    3'b001: begin

                        ALU_control = 3'b001;
                        ALUsrc      = 1'b0;
                        Regwrite    = 1'b0;
                        Memread     = 1'b0;
                        Memwrite    = 1'b0;
                        Branch_type = 2'b10;
                        jump        = 1'b0;
                        wbsel       = 2'b00;

                    end


                    default: begin
                    end

                endcase

            end

            // JAL
            
            7'b1101111: begin

                ALU_control = 3'b000;
                ALUsrc      = 1'b0;
                Regwrite    = 1'b1;
                Memread     = 1'b0;
                Memwrite    = 1'b0;
                Branch_type = 2'b00;
                jump        = 1'b1;
                wbsel       = 2'b10;

            end

            // DEFAULT
         
            default: begin
            end

        endcase

    end

endmodule
