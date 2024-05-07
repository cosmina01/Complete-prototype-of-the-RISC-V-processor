`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2024 02:04:22
// Design Name: 
// Module Name: forwarding
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


module forwarding(input [4:0] rs1,          //adresa RS1 in etapa EX
                  input [4:0] rs2,          //adresa RS2 in etapa EX
                  input [4:0] ex_mem_rd,    //adresa reg dest in etapa MEM
                  input [4:0] mem_wb_rd,    //adresa reg dest in etapa WB
                  input ex_mem_regwrite,    //semnal control in etapa MEM
                  input mem_wb_regwrite,    //semnal control in etapa WB
                  output reg [1:0] forwardA,forwardB);//semnale selectie mux; aleg valoarea de bypass
                  
    initial begin
        forwardA = 2'b00;
        forwardB = 2'b00;
    end
                  
    always@(*) begin
        //hazard in etapa EX
        if (ex_mem_regwrite && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs1)) begin
            forwardA <= 2'b10;
        end
        if (ex_mem_regwrite && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs2)) begin
            forwardB <= 2'b10;
        end
        
        //hazard in etapa MEM
        if (mem_wb_regwrite && (mem_wb_rd != 5'b0) && !(ex_mem_regwrite && (ex_mem_rd != 5'b0) 
            && (ex_mem_rd == rs1)) && (mem_wb_rd == rs1)) begin
            forwardA <= 2'b01;
        end 
        
        if (mem_wb_regwrite && (mem_wb_rd != 5'b0) && !(ex_mem_regwrite && (ex_mem_rd != 5'b0) 
            && (ex_mem_rd == rs2)) && (mem_wb_rd == rs2)) begin
            forwardB <= 2'b01;
        end
    end
endmodule
