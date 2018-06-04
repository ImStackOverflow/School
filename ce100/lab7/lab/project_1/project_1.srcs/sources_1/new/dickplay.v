`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2018 12:44:31 PM
// Design Name: 
// Module Name: dickplay
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

//display module
//horizonatal and vertical counter to represent screen pos bitch
//hsync and vsync output high as specified
//endframe high for one clock cycle to show finished rendering one frame

module dickplay(
    input clk,
    output [9:0] horizontal,
    output [9:0] vertical,
    output hsync,
    output vsync,
    output endframe,
    output showshit
    );
    
    wire hreset, vreset;
    assign showshit = (horizontal <= 639 & vertical <= 479);
    
    //horizontal counter
    //hsync low between 655, 750
    //reset counter when reach edge at 799
    assign hsync = ~(horizontal >= 655 & horizontal <= 750);
    assign hreset = (horizontal == 799);
    diezbit horizon (.clk(clk), .incr(1'b1 ^ hreset), .decr(1'b0), .in(10'd0), .reset(hreset), .out(horizontal));
    
    //vertical counter
    //vsync low between 655, 750
    //reset counter when reach edge at 799
    assign vsync = ~(vertical >= 489 & vertical <= 490);
    assign vreset = (vertical == 524);
    diezbit vertdick (.clk(clk), .incr(hreset), .decr(1'b0), .in(10'd0), .reset(vreset), .out(vertical));
    edgeD edgeplay (.clk(clk), .in(vsync), .out(endframe));
    
endmodule
