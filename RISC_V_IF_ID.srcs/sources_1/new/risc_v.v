//////////////////////////////////////////////RISC-V_MODULE///////////////////////////////////////////////////
module RISC_V(input clk,reset,
              /*input IF_ID_write,
              input PCSrc,PC_write,
              input [31:0] PC_Branch,
              input RegWrite_WB, 
              input [31:0] ALU_DATA_WB,
              input [4:0] RD_WB,
              output [31:0] PC_ID,
              output [31:0] INSTRUCTION_ID,
              output [31:0] IMM_ID,
              output [31:0] REG_DATA1_ID,REG_DATA2_ID,
              output [2:0] FUNCT3_ID,
              output [6:0] FUNCT7_ID,
              output [6:0] OPCODE,
              output [4:0] RD_ID,
              output [4:0] RS1_ID,
              output [4:0] RS2_ID)*/
              
              output [31:0] PC_EX,
              output [31:0] ALU_OUT_EX,
              output [31:0] PC_MEM,
              output PCSrc,
              output [31:0] DATA_MEMORY_MEM,
              input [31:0] ALU_DATA_WB,
              output [1:0] forwardA, forwardB,
              output pipeline_stall);
  
  //////////////////////////////////////////internal signals////////////////////////////////////////////////////////
  wire [31:0] PC_IF;               //current PC
  wire [31:0] INSTRUCTION_IF;
  wire RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID;
  wire [1:0] ALUop_ID;
  wire ALUSrc_ID;
  wire Branch_ID;
  
  wire IF_ID_write;
wire PC_write;
wire PCSrc_V;
wire [31:0] PC_Branch;  
wire [4:0] RD_WB;

wire [31:0] PC_ID,INSTRUCTION_ID,IMM_ID,REG_DATA1_ID,REG_DATA2_ID;
wire [2:0] FUNCT3_ID;
wire [6:0] FUNCT7_ID,OPCODE;
wire [4:0] RD_ID,RS1_ID,RS2_ID;

wire zero_ID;

wire [31:0] INSTRUCTION_EX,IMM_EX,REG_DATA1_EX,REG_DATA2_EX;
wire [2:0] func3_EX;
wire [6:0] func7_EX,OPCODE_EX;
wire [4:0] RD_EX,RS1_EX,RS2_EX;

wire zero_EX,RegWrite_EX,MemtoReg_EX,MemRead_EX,MemWrite_EX,Branch_EX,ALUSrc_EX;
wire [1:0] ALUop_EX;

wire [31:0] ALU_OUT_EX_l;
wire [31:0] PC_Branch_EX;
wire [31:0] REG_DATA2_EX_FINAL;


wire zero_MEM,RegWrite_MEM,MemtoReg_MEM,MemRead_MEM,MemWrite_MEM,Branch_MEM,ALUSrc_MEM;
wire [1:0] ALUop_MEM;
wire [4:0] RD_MEM;
wire [31:0] PC_Branch_MEM;
wire [31:0] ALU_OUT_MEM;
wire [31:0] REG_DATA2_MEM_FINAL;


wire zero_WB,RegWrite_WB,MemtoReg_WB,MemRead_WB,MemWrite_WB,Branch_WB,ALUSrc_WB;
wire [1:0] ALUop_WB;
wire [31:0] READ_DATA_WB;
wire [31:0] ALU_OUT_MEM_WB;
 
 /////////////////////////////////////IF Module/////////////////////////////////////
 IF instruction_fetch(clk, reset, 
                      PCSrc, PC_write,
                      PC_Branch,
                      PC_IF,INSTRUCTION_IF);
  
  
 //////////////////////////////////////pipeline registers////////////////////////////////////////////////////
 IF_ID_reg IF_ID_REGISTER(clk,reset,
                          IF_ID_write,
                          PC_IF,INSTRUCTION_IF,
                          PC_ID,INSTRUCTION_ID);
  
  
 ////////////////////////////////////////ID Module//////////////////////////////////
 ID instruction_decode(clk,
                       PC_ID,INSTRUCTION_ID,
                       RegWrite_WB, 
                       ALU_DATA_WB,
                       RD_WB,
                       IMM_ID,
                       REG_DATA1_ID,REG_DATA2_ID,
                       RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID,
                       ALUop_ID,
                       ALUSrc_ID,
                       Branch_ID,
                       FUNCT3_ID,FUNCT7_ID,
                       OPCODE,
                       RD_ID,RS1_ID,RS2_ID);
 hazard_detection H_D(RD_EX,
                      RS1_ID,
                      RS2_ID,
                      MemRead_ID,
                      PC_write,
                      IF_ID_write,
                      pipeline_stall);
 control_path control(OPCODE_ID,
                      pipeline_stall,
                      RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID,Branch_ID,ALUSrc_ID,
                      ALUop_ID);

//ID/EX PIPELINE
ID_EX_pipe ID_EX_REG(VDD,
                  clk,
                  reset,
                  PC_ID,
                  func3_ID,
                  func7_ID,
                  REG_DATA1_ID,
                  REG_DATA2_ID,
                  RS1_ID,
                  RS2_ID,
                  RD_ID,
                  IMM_ID,
                  
                  PC_EX,
                  func3_EX,
                  func7_EX,
                  REG_DATA1_EX,
                  REG_DATA2_EX,
                  RS1_EX,
                  RS2_EX,
                  RD_EX,
                  IMM_EX);

//EX
EX execute(IMM_EX,             
          REG_DATA1_EX,        
          REG_DATA2_EX,       
          PC_EX,               
          FUNCT3_EX,            
          FUNCT7_EX,           
          RD_EX,               
          RS1_EX,               
          RS2_EX,              
          RegWrite_EX,                
          MemtoReg_EX,                
          MemRead_EX,                 
          MemWrite_EX,                
          ALUop_EX,             
          ALUSrc_EX,                  
          Branch_EX,                 
          forwardA,forwardB,    
          ALU_DATA_WB,
          ALU_OUT_MEM,
          
          ZERO_EX,
          ALU_OUT_EX,
          PC_Branch_EX,
          REG_DATA2_EX_FINAL);

forwarding fw(RS1_EX,
              RS2_EX,
              RD_MEM,
              RD_WB,
              RegWrite_MEM,
              RegWrite_WB,
              forwardA,forwardB);
                      
EX_MEM_pipe EX_PIPE_REG(VDD,
                        clk,
                        reset,
              
                        PC_Branch_EX,
                        func3_EX,
                        func7_EX,
                        zero_EX,
                        ALU_out_EX,
                        MUX_B_temp,
                        RD_EX,
                      
                        PC_MEM,
                        func3_MEM,
                        func7_MEM,
                        zero_MEM,
                        ALU_OUT_MEM,
                        REG2_DATA_MEM,
                        RD_MEM);
                                               
/*assign PCSrc_V = zero_MEM & Branch_MEM;
assign PCSrc = PCSrc_V; */ 

data_memory dm(clk,
               MemRead_MEM,
               MemWrite_MEM,
               ALU_OUT_MEM,
               REG_DATA2_MEM_FINAL,
               DATA_MEMORY_MEM
               );

MEM_WB_pipe MEM_WB_pipeline(clk,reset,
                                zero_MEM,RegWrite_MEM,MemtoReg_MEM,MemRead_MEM,MemWrite_MEM,Branch_MEM,ALUSrc_MEM,
                                ALUop_MEM,
                                RD_MEM,
                                DATA_MEMORY_MEM,
                                ALU_OUT_MEM,
                                
                                zero_WB,RegWrite_WB,MemtoReg_WB,MemRead_WB,MemWrite_WB,Branch_WB,ALUSrc_WB,
                                ALUop_WB,
                                RD_WB,
                                READ_DATA_WB,
                                ALU_OUT_MEM_WB
                                );
                                
mux2_1 MUX_WB(ALU_OUT_MEM_WB,READ_DATA_WB,MemtoReg_WB,ALU_DATA_WB);

endmodule
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
