`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2024 02:01:57
// Design Name: 
// Module Name: hazard_detection
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


module hazard_detection(input [4:0] rd,     //adresa RD in etapa EX
                        input [4:0] rs1,    //adresa RS1 in etapa ID
                        input [4:0] rs2,    //adresa RS2 in etapa ID
                        input MemRead,      //semnal control din etapa EX
                        output reg PCwrite, //semnal ce controleaza scrierea in reg PC
                        output reg IF_IDwrite,  //semnal ce controleaza scrierea in reg pipeline IF_ID
                        output reg control_sel);//semnal transmis spre unitatea de control
                        
    always@(*) begin 
        if (MemRead && ((rd == rs1)||(rd == rs2))) begin 
              PCwrite <= 1'b0;
              IF_IDwrite <= 1'b0;
              control_sel <= 1'b1;
        end
        else begin 
              PCwrite <= 1'b1;
              IF_IDwrite <= 1'b1;
              control_sel <= 1'b0;
        end  
    end
endmodule
