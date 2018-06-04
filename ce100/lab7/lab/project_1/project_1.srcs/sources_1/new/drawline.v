`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2018 07:29:13 PM
// Design Name: 
// Module Name: drawline
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

//input gamestart signal from game state machine
//endframe shit
//orientation to draw type of line
//reset to 

module drawline(
    input clk,
    input [7:0] gap, //variable gap length
    input hsec, //half second timer for flash
    input gamestart, //begin movement of lines
    input endframe, //only move on frame ending
    input orientation, // 0 for up down, 1 other shit
    input reset, //reset player and go to idle state
    input [9:0] horizon, //animation horizontal
    input [9:0] vert, //animation vertical
    input [9:0] startx, //beginning position
    input [9:0] starty, //beginning position fucking y
    input [3:0] player, //green line, is active when animation is currently in player area
    input [3:0] border, //same idea as player suppress shit when animation drawing border
    output [3:0] red, //output line
    output hit
    );
    
    //current point position of line
    wire [9:0] mex, mey;
    
    //state machine shit
    wire edger, edgel, hitplayer, idle, incr, decr;
    
    russia redstate (.clk(clk), .reset(reset), .gamestart(gamestart), .eright(edger), .eleft(edgel), .hit(hitplayer),
        .idle(idle), .incr(incr), .decr(decr), .flash(hit));
    

    //position shit    
    diezbit horizontalshit (.clk(clk), .reset(idle), .in(startx), .incr(incr & orientation & endframe),
        .decr(decr & orientation & endframe), .out(mex));
     
    diezbit verticalshit (.clk(clk), .reset(idle), .in(starty), .incr(incr & ~orientation & endframe),
        .decr(decr & ~orientation & endframe), .out(mey));
    
    
    //actual line itself
    //just a solid line for base drawing
    //line up is a vertical line, lineright is fucking left to right
    wire lineup, lineright;
    
    //true for when horizontal is within border width
    assign lineup = horizon <= mex + 10 & horizon > mex & ~orientation;
    
    //true for when vertical of animation within width of border
    assign lineright = vert <= mey+10 & vert > mey & orientation;
    
    
    // in idle
    wire stablevert, stablehoriz;
    //just a stable line
    assign stablehoriz = lineright & idle;
    //just a stable fucking line
    assign stablevert = lineup & idle;
    
    
    
    //compute when it hits the edge
    assign edgel = (mey <= 10) | (mex <= 10);
    assign edger = (mey + gap >= 453 & ~orientation) | (mex + gap  >= 618 & orientation);
    
    
    //game is in action draw red
    wire movingvert, movinghoriz;
    //insert gap moving up and down
    assign movingvert = lineup & ~idle & ~((mey < vert) & (mey +gap > vert));
    //insert gap moving left to right
    assign movinghoriz = lineright & ~idle & ~((mex < horizon) & (mex + gap > horizon ));
    
    wire playa;
    //high when animation line is on player
    assign playa = |player;
    //moving horiz only goes high when animation bit is within the line shit, not including gap
    //if player is high and moving vert is high, animation bit is trying to animate both green and red 
    //ie player green and line red are in same position on screen animation bit
    //ergo it was fucking hit
    assign hitplayer = playa & (movingvert | movinghoriz);
    
    //red shit active when any of these fuckers is active
    wire rojo = stablehoriz | stablevert | movingvert | movinghoriz;
    
    //put all that shit together
    assign red = {4{(rojo ^ (rojo & hit & hsec)) & ~|border}}; 

endmodule
