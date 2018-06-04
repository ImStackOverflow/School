`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2018 12:30:15 PM
// Design Name: 
// Module Name: fullsend
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

//full bit adder using muxes
//input single bits
//3 inputs a, b, carryin
//2 outputs sum and carry bit

module fullsend(
    input a,
    input b,
    input c,
    output sum,
    output cout
    );
    fux4to1 summed (.s({c,b}), .i({a, ~a, ~a, a}), .e(1), .out(sum)); //sum mux
    fux4to1 carry (.s({a,b}), .i({1'b1,c,c,1'b0}), .e(1), .out(cout)); //carry mux
endmodule
