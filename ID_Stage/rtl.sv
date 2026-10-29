```systemverilog
module id_stage (
    input  logic        clk,
    input  logic        reset,
    input  logic        stall,
    input  logic [31:0] instruction,
    input  logic [31:0] wb_data,

    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data,
    output logic [31:0] imm_out,
    output logic [6:0]  opcode_out_d,
    output logic [6:0]  imm11_5,
    output logic [2:0]  fn3_out_d,
    output logic        fn7_5,
    output logic [2:0]  aluop,
    output logic [1:0]  memtoreg,
    output logic        branch,
    output logic        mem_write,
    output logic        mem_read,
    output logic        alu_src,
    output logic        mux_inp
);

    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;

    logic [11:0] imm;
    logic [19:0] imm_uj;

    logic reg_write;

    // Instruction decoder
    decoder dec (
        .instruction (instruction),
        .rs1         (rs1),
        .rs2         (rs2),
        .rd          (rd),
        .imm         (imm),
        .imm_uj      (imm_uj),
        .fn3         (fn3_out_d),
        .opcode      (opcode_out_d),
        .imm11_5     (imm11_5),
        .fn7_5       (fn7_5)
    );

    // Immediate generator
    imm_generator immgen (
        .imm         (imm),
        .imm_uj      (imm_uj),
        .opcode      (opcode_out_d),
        .imm_out     (imm_out)
    );

    // Register file
    register_file rf (
        .clk      (clk),
        .reset    (reset),
        .we       (reg_write && !stall),
        .rs1      (rs1),
        .rs2      (rs2),
        .rd       (rd),
        .wb_data  (wb_data),
        .rs1_data (rs1_data),
        .rs2_data (rs2_data)
    );

    // Main control
    main_control control (
        .opcode    (opcode_out_d),
        .aluop     (aluop),
        .memtoreg  (memtoreg),
        .branch    (branch),
        .mem_write (mem_write),
        .mem_read  (mem_read),
        .alu_src   (alu_src),
        .mux_inp   (mux_inp),
        .reg_write (reg_write)
    );

endmodule
```
