`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2018 12:42:46 PM
// Design Name: 
// Module Name: ringcounter
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


//rotates a single high bit accross 4 bits

module ringcounter(
    input adv,
    input clk, 
    output [3:0] o
    );

    //first bit
    FDRE #(.INIT(1'b1) ) q0 (.C(clk), .R(1'b0), .CE(adv), .D(o[3]), .Q(o[0]));
    //second bit
    FDRE #(.INIT(1'b0) ) q1 (.C(clk), .R(1'b0), .CE(adv), .D(o[0]), .Q(o[1]));
    //third bit
    FDRE #(.INIT(1'b0) ) q2 (.C(clk), .R(1'b0), .CE(adv), .D(o[1]), .Q(o[2]));
    //third bit
    FDRE #(.INIT(1'b0) ) q3 (.C(clk), .R(1'b0), .CE(adv), .D(o[2]), .Q(o[3]));
    
endmodule

