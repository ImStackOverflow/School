`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2018 06:28:21 AM
// Design Name: 
// Module Name: countTIME
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

//4 second counter
//output flash at 4 seconds
//feed in seconds on adv pin

module countTIME(
    input adv,
    input clk,
    input reset,
    output flash,
    output [3:0] out
    );
    
    wire whenIsaySo;
    //incriment on step and when less than 4
    assign whenIsaySo = ~out[2]&adv;
    assign flash = out[2];
    
    countUD4L countshit (.clk(clk), .up(whenIsaySo), .down(1'b0), .ld(reset), .din(4'b0), .Q(out));
endmodule
