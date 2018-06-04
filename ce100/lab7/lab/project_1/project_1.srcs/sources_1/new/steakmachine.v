`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2018 12:56:44 AM
// Design Name: 
// Module Name: steakmachine
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


module steakmachine(
    input clk,
    input hit,
    input move,
    input win,
    input btnc,
    output gstart,
    output showtime,
    output reset,
    output iloss,
    output iwin,
    output fblue
    );
    
    //output lines
    wire idle, play, nothing;
    
    //input logic
    wire idlein, playin, nothingin, flashin;
    
    //input states
    assign idlein = btnc | idle&~move;
    assign playin = (idle&move | play*~hit&~win)&~btnc;    
    assign nothingin = (play&hit | nothing)&~btnc;
    assign flashin = (play&win | fblue)&~btnc;
    
    //output lines
    assign gstart = move;
    assign showtime = ~idle;
    assign reset = idle;
    assign iloss = play&hit;
    assign iwin = play&win;
    
    FDRE #(.INIT(1'b1) ) idlemydick (.C(clk), .R(1'b0), .CE(1'b1), .D(idlein), .Q(idle));
    
    FDRE #(.INIT(1'b0) ) playme (.C(clk), .R(1'b0), .CE(1'b1), .D(playin), .Q(play));
    
    FDRE #(.INIT(1'b0) ) nothingcame (.C(clk), .R(1'b0), .CE(1'b1), .D(nothingin), .Q(nothing));
    
    FDRE #(.INIT(1'b0) ) flashbluemen (.C(clk), .R(1'b0), .CE(1'b1), .D(flashin), .Q(fblue));
    
    

    
    
endmodule
