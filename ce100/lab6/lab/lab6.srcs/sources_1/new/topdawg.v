`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2018 06:48:15 AM
// Design Name: 
// Module Name: topdawg
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


module topdawg(
    input clkin,
    input btnR,
    input btnD,
    input btnL,
    output [6:0] seg,
    output [3:0] an,
    output led1,
    output led2
    );
    
    wire clk, digsel, qsec, incr, decr, reset, show, neg, flash, leftb, rightb;
    //on for half sec and full second respectivly dipshit
    wire halfsec, second;
    wire [3:0] sec, ring, n;
    wire [7:0] dipshit;
    wire [15:0] display;
    
    assign display = {sec, 4'b0000, dipshit};
    
    assign led1 = btnR;
    assign led2 = btnL;
    //assign segment on shit
    assign an = ~{show & ring[3] & (1'b1^(flash & halfsec)), ring[2]&neg, ring[1:0]};
    
    
    //need to do logic for second and halfsecond
    TIMEBITCH foat (.clk(clk), .adv(qsec), .halfsec(halfsec), .second(second), .reset(reset));
    
    //cock
    lab6_clks slowit (.clkin(clkin), .greset(btnD), .clk(clk), .digsel(digsel), .qsec(qsec));
    
    //state machine
    fuckingsteak beefbitch (.clk(clk), .btnl(btnL), .btnr(btnR), .incr(incr),
         .decr(decr), .show(show));

    //holds score
    score fuckyou (.incr(incr), .decr(decr), .clk(clk), .neg(neg), .out(dipshit));
    
    //holds 4 second timer
    edgeD rightness (.clk(clk), .sh(btnR), .it(rightb));
    edgeD leftness (.clk(clk), .sh(btnL), .it(leftb));
    
    countTIME dracula (.adv(second), .clk(clk), .reset(leftb|rightb), .flash(flash), .out(sec));
    
    //ring
    ringcounter ringonit (.adv(digsel), .clk(clk), .o(ring));
    
    //selector
    selector select (.count(display), .ring(ring), .digit(n));
    
    //segment converter
    hex7seg lickmydick (.n(n), .neg(ring[2]&neg), .e(1'b1), .out(seg));
    
endmodule
