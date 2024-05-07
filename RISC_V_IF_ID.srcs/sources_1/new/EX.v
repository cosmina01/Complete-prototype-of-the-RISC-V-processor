`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2024 01:48:40
// Design Name: 
// Module Name: EX
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module EX(input [31:0] IMM_EX,              //valoarea imm in EX
          input [31:0] REG_DATA1_EX,        //valoarea reg1
          input [31:0] REG_DATA2_EX,        //valoarea reg2
          input [31:0] PC_EX,               //adresa instr curente in EX
          input [2:0] FUNCT3_EX,            //func3 pt instr din EX
          input [6:0] FUNCT7_EX,            //func7 pt instr din EX
          input [4:0] RD_EX,                //adresa reg dest
          input [4:0] RS1_EX,               //adresa reg1
          input [4:0] RS2_EX,               //adresa reg2
          input RegWrite_EX,                //semnal scriere in banc reg
          input MemtoReg_EX,                
          input MemRead_EX,                 //semnal activare citire din mem
          input MemWrite_EX,                //semnal scriere in mem
          input [1:0] ALUop_EX,             //semnal control ALUop
          input ALUSrc_EX,                  //semnal selectie RS2 si imm
          input Branch_EX,                  //semnal identificare instr branch
          input [1:0] forwardA,forwardB,    //semnale selectie mux-uri forward
          
          input [31:0] ALU_DATA_WB,         //valoare calc de ALU; in WB
          input [31:0] ALU_OUT_MEM,         //valoare calc de ALU; in MEM
          
          output ZERO_EX,                   //flag ZERO calc de ALU
          output [31:0] ALU_OUT_EX,         //rezultat calc de ALU in EX
          output [31:0] PC_Branch_EX,       //adresa salt calc in EX
          output [31:0] REG_DATA2_EX_FINAL);//val RS2 selectata dintre val in etapele EX,MEM,WB
          
    wire [31:0] ALU_Source1, MUX_B_temp, ALU_Source2;
    wire [3:0] ALU_Control;
    
    adder add(IMM_EX, PC_EX, PC_Branch_EX); //adresa de salt pt instr branch
    
    mux3_1 mux_FW_A(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM, forwardA, ALU_Source1);         
    mux3_1 mux_FW_B(REG_DATA2_EX, ALU_DATA_WB, ALU_OUT_MEM, forwardB, MUX_B_temp);
    mux2_1 mux3_2_1(MUX_B_temp, IMM_EX, ALUSrc_EX, ALU_Source2);
    assign REG_DATA2_EX_FINAL = MUX_B_temp;

    ALUcontrol ALU_Cont(ALUop_EX, FUNCT7_EX, FUNCT3_EX, ALU_Control);
    ALU alu(ALU_Control, ALU_Source1, ALU_Source2, ZERO_EX, ALU_OUT_EX);
    
endmodule
