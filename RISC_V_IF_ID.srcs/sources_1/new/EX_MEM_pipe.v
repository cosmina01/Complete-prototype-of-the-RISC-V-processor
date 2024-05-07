`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2024 09:11:06
// Design Name: 
// Module Name: EX_MEM_pipe
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


module EX_MEM_pipe (input write,
                    input clk,
                    input res,
              
                    input [31:0] pc_in,
                    input [2:0] func3_in,
                    input [7:0] func7_in,
                    input zero_in,
                    input [31:0] alu_in,
                    input [31:0] reg2_data_in,
                    input [4:0] rd_in,
                      
                    output reg pc_out,
                    output reg func3_out,
                    output reg func7_out,
                    output reg zero_out,
                    output reg alu_out,
                    output reg reg2_data_out,
                    output reg rd_out);
     
     always@(posedge clk) begin
        if (res) begin 
            pc_out <= 32'b0;
            func3_out <= 3'b0;
            func7_out <= 7'b0;
            zero_out <= 0;
            alu_out <= 32'b0;
            reg2_data_out <= 32'b0;
            rd_out <= 5'b0;
        end 
        else begin 
           if (write) begin 
               pc_out <= pc_in;
               func3_out <= func3_in;
               func7_out <= func7_in;
               zero_out <= zero_in;
               alu_out <= alu_in;
               reg2_data_out <= reg2_data_in;
               rd_out <= rd_in;
            end
        end 
     end         
     
endmodule
