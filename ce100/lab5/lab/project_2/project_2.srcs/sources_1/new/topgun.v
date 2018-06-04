`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2018 01:52:06 AM
// Design Name: 
// Module Name: topgun
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


module topgun(
    input clkin,
    input btnR,
    input btnU,
    input btnC,
    input btnD,
    input sw,
    output [15:0] led,
    output [3:0] an,
    output dp,
    output [6:0] seg
    );
    wire countleds, clk, digsel, qsec, timeup, countdown, load;
    
    //time to show in middle 2 segments of display
    wire [7:0] tiempo;
    //clock
    lab5_clks slowit (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel), .qsec(qsec));
    
    //state machine
    //StateoftheUnion (.btnU(btnU), .btnD(btnD), .btnC(btnC), .timeup(timeup), .lastled(led[15]), .countdown(countdown),
                     //.clk(clk), .showtime(), .load(load), .showscore(countleds), .countleds(), .incscore(), .winner());
    
    //shift leds
    LEDshifter shift (.reset(led[15]), .clk(clk), .enable(qsec), .led(led));
    
    //time counter
    //fuckingTIME (.start(load), .go(countdown), .clk(clk), .tiempo(tiempo), .timeup(timeup));
    
    //show shit on segments
    //fuckingdisplay (.digsel(digsel), .clk(clk), .inshit(), .seg(seg));
endmodule
