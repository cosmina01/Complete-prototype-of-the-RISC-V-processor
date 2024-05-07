`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2024 01:25:20
// Design Name: 
// Module Name: ALUcontrol
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


module ALUcontrol(input [1:0] ALUop,
                  input [6:0] funct7,
                  input [2:0] funct3,
                  output reg [3:0] ALUinput);
                  
    always@(ALUop,funct7,funct3) begin
        casex({ALUop,funct7,funct3})
            {2'b00, 7'bxxxxxxx, 3'bxxx}: ALUinput = 4'b0010;  // LD, SD
            {2'b10, 7'b0000000, 3'b000}: ALUinput = 4'b0010;  // ADD
            {2'b11, 7'bxxxxxxx, 3'b000}: ALUinput = 4'b0010;  // ADDI
            {2'b10, 7'b0100000, 3'b000}: ALUinput = 4'b0110;  // SUB
            {2'b10, 7'b0000000, 3'b111}: ALUinput = 4'b0000;  // AND
            {2'b11, 7'bxxxxxxx, 3'b111}: ALUinput = 4'b0000;  // ANDI
            {2'b10, 7'b0000000, 3'b110}: ALUinput = 4'b0001;  // OR
            {2'b11, 7'bxxxxxxx, 3'b110}: ALUinput = 4'b0001;  // ORI
            {2'b10, 7'b0000000, 3'b100}: ALUinput = 4'b0011;  // XOR
            {2'b11, 7'bxxxxxxx, 3'b100}: ALUinput = 4'b0011;  // XORI
            {2'b1x, 7'b010000x, 3'b101}: ALUinput = 4'b0101;  // SRL, SRLI
            {2'b1x, 7'b000000x, 3'b001}: ALUinput = 4'b0100;  // SLL, SLLI
            {2'b1x, 7'b010000x, 3'b101}: ALUinput = 4'b1001;  // SRA, SRAI
            {2'b10, 7'b0000000, 3'b010}: ALUinput = 4'b1000;  // SLT
            {2'b10, 7'b0000000, 3'b011}: ALUinput = 4'b0111;  // SLTU
            {2'b01, 7'bxxxxxxx, 3'b00x}: ALUinput = 4'b0110;  // BEQ, BNE
            {2'b01, 7'bxxxxxxx, 3'b10x}: ALUinput = 4'b1000;  // BLT, BGE 
            {2'b01, 7'bxxxxxxx, 3'b11x}: ALUinput = 4'b0111;  // BLTU, BGEU   
        endcase 
    end
    
endmodule
