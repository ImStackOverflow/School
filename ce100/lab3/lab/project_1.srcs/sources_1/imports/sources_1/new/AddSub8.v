`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2018 01:01:28 PM
// Design Name: 
// Module Name: addShit
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

//8 bit full adder
//input 2 8 bit bus numbers and subtraction option
//output 1 8 bit bus number and overflow bit
module AddSub8(
    input [7:0] A, //number 1
    input [7:0] B, //number 2
    input sub, //sub function
    output [7:0] S, //sum number 
    output ovfl //overflow bit
    );
    
    wire [7:0] BR; //correctly inverted or not B input
    wire c1, c2, c3, c4, c5, c6, c7, c8; //carry wires
    
    //the inverse of B if needed to do 2's compliment
    //xor is inverting if needed
    assign BR = ({8{sub}} ^ B);
    
    fullsend b1(.a(A[0]), .b(BR[0]), .c(sub), .sum(S[0]), .cout(c1));
    fullsend b2(.a(A[1]), .b(BR[1]), .c(c1), .sum(S[1]), .cout(c2));
    fullsend b3(.a(A[2]), .b(BR[2]), .c(c2), .sum(S[2]), .cout(c3));
    fullsend b4(.a(A[3]), .b(BR[3]), .c(c3), .sum(S[3]), .cout(c4));
    fullsend b5(.a(A[4]), .b(BR[4]), .c(c4), .sum(S[4]), .cout(c5));
    fullsend b6(.a(A[5]), .b(BR[5]), .c(c5), .sum(S[5]), .cout(c6));
    fullsend b7(.a(A[6]), .b(BR[6]), .c(c6), .sum(S[6]), .cout(c7));
    fullsend b8(.a(A[7]), .b(BR[7]), .c(c7), .sum(S[7]), .cout(c8));
    assign ovfl = (A[7] & B[7]&~S[7]) | (~A[7]&~B[7]&S[7]) | (~A[7] & ~B[7] & c8);
    
    
endmodule
