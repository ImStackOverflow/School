`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2018 12:14:15 PM
// Design Name: 
// Module Name: playa
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


//takes care of player position
//only move player on specific inputs and current state 

module playa(
    input clk,
    input up,
    input down,
    input left,
    input right,
    input change,
    input reset,
    output [9:0] horiz,
    output [9:0] vert
    );
    
    //takes care of horizontal movement
    wire l, r;
    //dictate when moving left is possible    
    assign r = right & change & horiz < 611;
    assign l = left & change & horiz > 11;

    diezbit horizon (.clk(clk), .reset(reset), .in(10'd11), .incr(r), .decr(l), .out(horiz));
    
    
    //takes care of up down movememnt
    wire u, d;
    //dictate when moving up good
    assign d = down & change & vert < 452;
    assign u = up & change & vert > 11;

    diezbit vertical (.clk(clk), .reset(reset), .in(10'd11), .incr(d), .decr(u), .out(vert));
    
    
    
endmodule
