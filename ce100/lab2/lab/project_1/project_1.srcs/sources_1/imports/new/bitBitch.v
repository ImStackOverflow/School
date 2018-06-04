`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2018 12:10:27 PM
// Design Name: 
// Module Name: 3bitBitch
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

//3bit full adder
//7 bit input (2 3 bit numbers and a carry in)
//4 bit output (4 bit number)

module bitBitch(
    input cin,
    input a1,
    input a2,
    input a3,
    input b1,
    input b2,
    input b3,
    output s1,
    output s2,
    output s3,
    output s4
    );
    
    //carry out wires
    wire c1,c2;
    //first adder
    FullSend add1 (.a(a1), .b(b1), .cin(cin), .s(s1), .cout(c1));
    FullSend add2 (.a(a2), .b(b2), .cin(c1), .s(s2), .cout(c2));
    FullSend add3 (.a(a3), .b(b3), .cin(c2), .s(s3), .cout(s4));
    
endmodule
