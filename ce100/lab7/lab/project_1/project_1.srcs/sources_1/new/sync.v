`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2018 01:11:47 PM
// Design Name: 
// Module Name: sync
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

//synchronizes all input for display shit

module sync(
    input [3:0] r,
    input [3:0] g,
    input [3:0] b,
    input show,
    output [3:0] vr,
    output [3:0] vg,
    output [3:0] vb,
    input clk
    );
    
    wire [3:0] red, green, blue;
    
    //show shit filter
    assign red = {4{show}} & r;
    assign green = {4{show}} & g;
    assign blue = {4{show}} & b;
   
    
    //sync red shit
    FDRE #(.INIT(1'b0) ) r0 (.C(clk), .R(1'b0), .CE(1'b1), .D(red[0]), .Q(vr[0]));
    FDRE #(.INIT(1'b0) ) r1 (.C(clk), .R(1'b0), .CE(1'b1), .D(red[1]), .Q(vr[1]));
    FDRE #(.INIT(1'b0) ) r2 (.C(clk), .R(1'b0), .CE(1'b1), .D(red[2]), .Q(vr[2]));
    FDRE #(.INIT(1'b0) ) r3 (.C(clk), .R(1'b0), .CE(1'b1), .D(red[2]), .Q(vr[3]));
    
        
    //sync green shit
    FDRE #(.INIT(1'b0) ) g0 (.C(clk), .R(1'b0), .CE(1'b1), .D(green[0]), .Q(vg[0]));
    FDRE #(.INIT(1'b0) ) g1 (.C(clk), .R(1'b0), .CE(1'b1), .D(green[1]), .Q(vg[1]));
    FDRE #(.INIT(1'b0) ) g2 (.C(clk), .R(1'b0), .CE(1'b1), .D(green[2]), .Q(vg[2]));
    FDRE #(.INIT(1'b0) ) g3 (.C(clk), .R(1'b0), .CE(1'b1), .D(green[2]), .Q(vg[3]));
    
    
    //sync blue shit
    FDRE #(.INIT(1'b0) ) b0 (.C(clk), .R(1'b0), .CE(1'b1), .D(blue[0]), .Q(vb[0]));
    FDRE #(.INIT(1'b0) ) b1 (.C(clk), .R(1'b0), .CE(1'b1), .D(blue[1]), .Q(vb[1]));
    FDRE #(.INIT(1'b0) ) b2 (.C(clk), .R(1'b0), .CE(1'b1), .D(blue[2]), .Q(vb[2]));
    FDRE #(.INIT(1'b0) ) b3 (.C(clk), .R(1'b0), .CE(1'b1), .D(blue[2]), .Q(vb[3]));
    
    
        
    
endmodule
