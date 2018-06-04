`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2018 12:21:03 AM
// Design Name: 
// Module Name: playerbitch
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


//takes care of player
//reset to begining on reset input
//input the buttons, endframe rendering, and current animation pixel position
//also input the current red output and a qsec input that is high for a quarter second
//output the state of the green player and its upper left coordinates

module playerbitch(
    input clk,
    input qsec,
    input up,
    input down,
    input reset,
    input left,
    input right,
    input endframe,
    input [9:0] horizposition,
    input [9:0] vertposition,
    input [3:0] red,
    output [3:0] green,
    output [9:0] bitchHoriz,
    output [9:0] bitchVert,
    output win
    );
    
    //let player move or not
    wire good, hit, dead, fuckingme;
    
    //player upper left corner coordinate
    playa fuckingposition (.clk(clk), .up(up), .down(down), .left(left), .right(right), 
        .change(good), .reset(reset), .horiz(bitchHoriz), .vert(bitchVert));
        
        
   //animation bit of frame actually in player coordinates 
   assign fuckingme = (horizposition <= bitchHoriz + 16 & horizposition >= bitchHoriz) & 
                    (vertposition <= bitchVert + 16 & vertposition >= bitchVert);
   
    //player is hit by red shit
    assign hit = fuckingme & |red;
                 
    //keep information that player hit a block and got fucked
    FDRE #(.INIT(1'b0) ) shot (.C(clk), .R(reset), .CE(1'b1), .D(hit|dead), .Q(dead));             
    
    //can move on endframe signal and player isnt dead
    assign good = endframe & ~dead;
    
    //green is high if annimation bit is within player coordinates
    assign green = {4{fuckingme ^ (fuckingme & qsec & dead)}};
    
    assign win = bitchHoriz >= 10'd595 & bitchVert >= 10'd435;
    
endmodule
