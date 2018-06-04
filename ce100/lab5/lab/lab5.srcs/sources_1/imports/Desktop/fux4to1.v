`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2018 11:55:15 AM
// Design Name: 
// Module Name: fux4to1
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


//4 to 1 mux
//input 1 bit enable, 2 bit selector and 4 bit input
//output 1 bit according to input and selector bit

//input = single selector bit, 2 bit selector bus, and 4 bit input bus
//output = single bit

module fux4to1(
    input [1:0] s,
    input [3:0] i,
    input e,
    output out 
    );
    
    assign out = (~s[0]&~s[1]&i[0] | s[0]&~s[1]&i[1]
         | ~s[0]&s[1]&i[2] | s[0]&s[1]&i[3]) & e;
    
endmodule