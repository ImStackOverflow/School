`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2018 12:02:06 PM
// Design Name: 
// Module Name: fux8to1
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

//8 bit mux
//input 1 bit enable, 
//1 bus of 8 bit width input, 
//and 1 bus of 3 bit width selector
//output is one bit

module fux8to1(
    input [7:0] in,
    input [2:0] s,
    input e,
    output out
    );
    
    wire m1, m2;
    
    fux4to1 mux1 (.s(s[1:0]), .i(in[3:0]), .e(1), .out(m1));
    fux4to1 mux2 (.s(s[1:0]), .i(in[7:4]), .e(1), .out(m2));
    assign out = (m1&~s[2] | m2&s[2])^e;
    
endmodule
