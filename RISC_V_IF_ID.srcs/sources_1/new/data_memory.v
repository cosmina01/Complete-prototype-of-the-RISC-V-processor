`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2024 01:59:18
// Design Name: 
// Module Name: data_memory
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


module data_memory(input clk,       
                   input mem_read,      //semnal activare citire din mem
                   input mem_write,     //semnal activare scriere in mem
                   input [31:0] address,//adresa de scriere/citire
                   input [31:0] write_data,     //valoarea scrisa in mem
                   output reg [31:0] read_data);//valoarea citita in mem
                   
    reg [31:0] mem [0:1023];
    integer i;
    
    initial begin
        for (i = 0; i < 1024; i = i + 1) begin 
            mem[i] = 32'b0; 
        end
    end
    
    //citire asincrona
    always@(mem_read) begin 
        read_data <= mem[address[11:2]];
    end
    
    //scriere sincrona
    always@(posedge clk) begin
        if(mem_write) begin
            mem[address[11:2]] <= write_data;
        end
    end
endmodule
