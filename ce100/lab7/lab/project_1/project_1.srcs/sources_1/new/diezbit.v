`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2018 12:33:39 PM
// Design Name: 
// Module Name: diezbit
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

//10 bit counter
//resets to 0 on reset high

module diezbit(
    input clk,
    input reset,
    input incr,
    input decr,
    input [9:0] in,
    output [9:0] out
    );
    
    wire upit, downit, up, down;
    
    //only one input at a time
    assign up = incr & ~ decr;
    assign down = decr & ~ incr;
    
    countUD5L bottombitch (.clk(clk), .ld(reset), .din(in[4:0]), .down(down), 
        .up(up), .utc(upit), .dtc(downit), .Q(out[4:0]));
        
   countUD5L upbitch (.clk(clk), .ld(reset), .din(in[9:5]), .down(down&downit), 
                .up(up&upit), .Q(out[9:5]));
endmodule
