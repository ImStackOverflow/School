`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2018 12:06:28 AM
// Design Name: 
// Module Name: fuckingdisplay
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


module fuckingdisplay(
    input digsel,
    input clk,
    input [15:0] inshit,
    input [6:0] seg
    ); 
    wire [3:0] shit, whore;
    //ring counter feeds into selector
    ringcounter ring (.adv(digsel), .clk(clk), .o(shit));
    //selector takes input feed that fucking shit into hex7seg
    selector fuck (.count(inshit), .ring(shit), .digit(whore));
    //hex7seg shit
    hex7seg AHHHH (.n(whore), .e(1'b1), .seg(seg));
    
endmodule
