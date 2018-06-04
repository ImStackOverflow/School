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


//bit rotator
//input clock cycle and advancement counter
//output 4 bit bus with only one high bit

module ring(
    input adv,
    input clk, 
    output [3:0] o
    );

    //first bit
    FDRE #(.INIT(1'b0) ) q0 (.C(clk), .R(1), .CE(adv), .D(o[3]), .Q(o[0]));
    //second bit
    FDRE #(.INIT(1'b0) ) q1 (.C(clk), .R(0), .CE(adv), .D(o[0]), .Q(o[1]));
    //third bit
    FDRE #(.INIT(1'b0) ) q2 (.C(clk), .R(0), .CE(adv), .D(o[1]), .Q(o[2]));
    //third bit
    FDRE #(.INIT(1'b0) ) q3 (.C(clk), .R(0), .CE(adv), .D(o[2]), .Q(o[3]));
    
endmodule
