`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2018 02:33:57 PM
// Design Name: 
// Module Name: counterUD16L
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


//edge detector
//outputs a high signal for one clock cycle
//on input to sh of sequence 001
//output line on it

module edgeD(
    input clk, //clock
    input sh, //input
    output it //output high for 1 clock
    );

    wire o0, o1, o2;
    
    //first bit
    FDRE #(.INIT(1'b0) ) q0 (.C(clk), .R(0), .CE(~clk), .D(sh), .Q(o0));
    //second bit
    FDRE #(.INIT(1'b0) ) q1 (.C(clk), .R(0), .CE(~clk), .D(o0), .Q(o1));
    //third bit
    FDRE #(.INIT(1'b0) ) q2 (.C(clk), .R(0), .CE(~clk), .D(o1), .Q(o2));

   assign it = o0 & ~o1 & ~o2;
    
endmodule
