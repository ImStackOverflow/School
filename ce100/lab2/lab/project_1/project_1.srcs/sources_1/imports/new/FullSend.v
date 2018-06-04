`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2018 12:00:27 PM
// Design Name: 
// Module Name: FullSend
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

//one full bit adder

module FullSend(
    input a,
    input b,
    input cin,
    output s,
    output cout
    );
    
    assign s = a ^ b ^ cin;
    assign cout = ((a ^ b) & cin) | (a & b);
   
endmodule
