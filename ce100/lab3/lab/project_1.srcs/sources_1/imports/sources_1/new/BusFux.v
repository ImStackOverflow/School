`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2018 12:13:08 PM
// Design Name: 
// Module Name: BusFux
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

//bussed mux
//takes in 2 busses in1 and in2
//outputes either entire bus 1 or bus 2

//input = 8bit bus
//output = 8bit bus


module BusFux(
    input [7:0] in1,
    input [7:0] in2,
    input s,
    output [7:0] out
    );
   
    assign out = ({8{s}} & in1) | ({8{~s}} & in2);
endmodule
