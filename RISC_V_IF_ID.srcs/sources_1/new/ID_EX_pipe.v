`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2024 10:22:36
// Design Name: 
// Module Name: ID_EX_pipe
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


module ID_EX_pipe(input write,
                  input clk,
                  input res,
                  input PC_in,
                  input func3_in,
                  input func7_in,
                  input ALU_A_in,
                  input ALU_B_in,
                  input RS1_in,
                  input RS2_in,
                  input RD_in,
                  input IMM_in,
                  
                  output PC_out,
                  output func3_out,
                  output func7_out,
                  output ALU_A_out,
                  output ALU_B_out,
                  output RS1_out,
                  output RS2_out,
                  output RD_out,
                  output IMM_out);
endmodule
