`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2024 01:30:00
// Design Name: 
// Module Name: ALU
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


module ALU(input [3:0] ALUop,       //ALUinput, selecteaza operatia
           input [31:0] ina,inb,    //operanzii care iau parte la operatie
           output zero,             //semnal ce verifica daca rezultatul = 0
           output reg [31:0] out);  //rezultatul
           
    always@(ALUop, ina, inb) begin 
        case(ALUop)
            4'b0000: out <= ina & inb;          //si
            4'b0001: out <= ina | inb;          //sau
            4'b0010: out <= ina + inb;          //adunare
            4'b0011: out <= ina ^ inb;          //xor
            4'b0100: out <= ina << inb[4:0];    //shift stanga
            4'b0101: out <= ina >> inb[4:0];    //shift dreapta
            4'b0110: out <= ina - inb;          //scadere
            4'b0111: out <= ($unsigned(ina) < $unsigned(inb)) ? 32'b1 : 32'b0; //comparatie < 
            4'b1000: out <= (ina < inb) ? 32'b1 : 32'b0;                       //comparatie <
            4'b1001: out <= ina >>> inb[4:0];   //shift dreapta aritmetic
            default: out <= 32'b0;
        endcase 
    end        
    
    assign zero = (out==32'b0)? 1'b1 : 1'b0;
endmodule
