`timescale 1ns/1ps
module processor(
    input clk,
    input reset
);

    // PC signals
    wire [31:0] pc_out;
    wire [31:0] pc_4;
    wire pc_mux;

    // Instruction
    wire [31:0] instr;

    // Instruction fields
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [2:0] funct3;
    wire [6:0] funct7;

    // Immediate
    wire [31:0] imm_out;

    // Control signals
    wire ALUsrc;
    wire [2:0] ALU_control;
    wire Regwrite;
    wire Memread;
    wire Memwrite;
    wire [1:0] Branch_type;
    wire jump;
    wire [1:0] wbsel;

    // Register file
    wire [31:0] s1val;
    wire [31:0] s2val;

    // ALU
    wire [31:0] alu_b;
    wire [31:0] alu_out;

    // Data memory
    wire [31:0] mem_data;

    // Branch
    wire branch_taken;

    // Write back
    wire [31:0] wb_value;

    // Instruction fields
    assign opcode = instr[6:0];
    assign rd     = instr[11:7];
    assign funct3 = instr[14:12];
    assign rs1    = instr[19:15];
    assign rs2    = instr[24:20];
    assign funct7 = instr[31:25];

    // PC + 4
    assign pc_4 = pc_out + 32'd4;

    // PC selection
    assign pc_mux = branch_taken | jump;

    // PC
    pc PC(
        .clk(clk),
        .rst(reset),
        .mux(pc_mux),
        .imm(imm_out),
        .pc_out(pc_out)
    );

    // Instruction memory
    instr_mem IMEM(
        .address(pc_out),
        .instruction(instr)
    );

    // Immediate generator
    imm_gen IMMGEN(
        .instr(instr),
        .imm_out(imm_out)
    );

    // Control unit
    control_unit CU(
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .ALUsrc(ALUsrc),
        .ALU_control(ALU_control),
        .Regwrite(Regwrite),
        .Memread(Memread),
        .Memwrite(Memwrite),
        .Branch_type(Branch_type),
        .jump(jump),
        .wbsel(wbsel)
    );

    // Register file
    regfile RF(
        .clk(clk),
        .reset(reset),
        .s1reg(rs1),
        .s2reg(rs2),
        .wb_register(rd),
        .reg_write(Regwrite),
        .wb_value(wb_value),
        .s1val(s1val),
        .s2val(s2val)
    );

    // ALU input selection
    assign alu_b = (ALUsrc) ? imm_out : s2val;

    // ALU
    alu ALU(
        .s1val(s1val),
        .alu_b(alu_b),
        .alu_control(ALU_control),
        .alu_out(alu_out)
    );

    // Data memory
    data_mem DMEM(
        .clk(clk),
        .Memread(Memread),
        .Memwrite(Memwrite),
        .address(alu_out),
        .write_data(s2val),
        .read_data(mem_data)
    );

    // Branch unit
    branch_unit BU(
        .Branch_type(Branch_type),
        .alu_out(alu_out),
        .branch_taken(branch_taken)
    );

    // Write back selection
    wbmux WBMUX(
        .pc_4(pc_4),
        .mem_data(mem_data),
        .alu_out(alu_out),
        .wbsel(wbsel),
        .wb_out(wb_value)
    );

endmodule
