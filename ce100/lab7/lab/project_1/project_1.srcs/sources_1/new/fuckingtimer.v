`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2018 10:26:06 PM
// Design Name: 
// Module Name: fuckingtimer
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


//entire display module
//takes care of time and shit
//just hook up to clk and signals
//output win/loss event for single clock cycle to change counter

module fuckingtimer(
    input clk,
    input digsel,
    input second,
    input reset, //reset timer 
    input showtime, //high to show time, low to show score
    input win, //game won, incriment score
    input loss, //game loss incriment fucking loser
    output [3:0] an,
    output [6:0] cathode
    );
    
    
    //wires to hold time and score 
    wire [15:0] timed, scored;
    
    //ring counter fucking ring and number to fucking show
    wire [3:0] ring, number;
    
    //the whole fucking time shit
    wire [15:0] theshit;
    
    
    
    assign theshit = (({16{showtime}} & timed) | {16{~showtime}} & scored);
    assign an = ~((ring & {4{showtime}}) | (ring & 4'b1001 & {4{~showtime}}));
    
    hex7seg converter (.n(number), .e(1'b1), .seg(cathode));
    
    ringcounter ringshit (.adv(digsel), .clk(clk), .o(ring));
    
    selector selectthisdick (.count(theshit), .ring(ring), .digit(number));
    
    
    //////////////////////////////////
    /////////// TIME AND SHIT ////////
    //////////////////////////////////
    
    wire [4:0] lowersec, highsec, lowmin, highmin;
    wire upit, upit2, upit3;


    //incriment every second
    countUD5L bottomsecond (.clk(clk), .up(second), .down(1'b0), .ld(upit | reset), .din(5'd0), .Q(lowersec));
    
    //incriment when gets to 9 and second hits
    assign upit = (lowersec[3:0] == 4'd10);
    countUD5L topsecond (.clk(clk), .up(upit), .down(1'b0), .ld(upit2 | reset), .din(5'd0), .Q(highsec));
    
    //incriment when gets to minute and upit hits
    assign upit2 = (highsec == 5'd7);
    countUD5L bottommin (.clk(clk), .up(upit2), .down(1'b0), .ld(upit3 | reset), .din(5'd0), .Q(lowmin));
   
   //you get the fucking idea
    assign upit3 = (lowmin == 5'd10);
    countUD5L topmin (.clk(clk), .up(upit3), .down(1'b0), .ld(1'b0 | reset), .din(5'd0), .Q(highmin));
    
    assign timed = {highmin[3:0], lowmin[3:0], highsec[3:0], lowersec[3:0]};
    
    
    /////////////////////////////////////
    ///////////// SCORE AND SHIT/////////
    /////////////////////////////////////
    
    wire [3:0] fuckingwin, fuckingloss;
    
    wire [15:0] scored;
    
    countUD5L fuckingloser (.clk(clk), .up(win), .down(1'b0), .ld(1'b0), .din(5'd0), .Q(fuckingloss));
    countUD5L fuckingwinner (.clk(clk), .up(loss), .down(1'b0), .ld(1'b0), .din(5'd0), .Q(fuckingwin));
    
    assign scored = {fuckingloss[3:0], 8'd0, fuckingwin[3:0]}; 
    
endmodule
