`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2018 06:15:21 AM
// Design Name: 
// Module Name: fuckingsteak
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


//fucking statemachine nutsack for the turkey bitches

module fuckingsteak(
    input clk, //fucking clock dipshit
    input btnl, //left sensor
    input btnr, //right sensor
    output incr, //incriment count
    output decr, //decriment count
    output reset, //reset 4 sec timer
    output show //show 4 sec timer
    );
    
    //output
    wire idle, right, left, rtl, ltr;
    
    //input fucker 
    wire idlein, rightin, leftin, rtlin, ltrin;
    
    assign idlein = ~btnl&~btnr;
    assign rightin = ~btnl&btnr&(idle | right | rtl);
    assign rtlin = btnl&(right | rtl);
    assign leftin = btnl&~btnr&(idle | left | ltr);
    assign ltrin = btnr&(left | ltr);
    
    
    //fucking up the output bitch
    assign decr = rtl&~btnl&~btnr;
    assign incr = ltr&~btnl&~btnr;
    assign reset = idle | right&btnl | rtl&~btnl&btnr | left&btnr | ltr&btnl&~btnr;
    assign show = ~idle;
    
    FDRE #(.INIT(1'b1) ) idling (.C(clk), .R(0), .CE(~clk), .D(idlein), .Q(idle));
    FDRE #(.INIT(1'b0) ) TRIGGEREDr (.C(clk), .R(0), .CE(~clk), .D(rightin), .Q(right));
    FDRE #(.INIT(1'b0) ) TRIGGEREDl (.C(clk), .R(0), .CE(~clk), .D(leftin), .Q(left));
    FDRE #(.INIT(1'b0) ) tighttoleft (.C(clk), .R(0), .CE(~clk), .D(rtlin), .Q(rtl));
    FDRE #(.INIT(1'b0) ) lefttotight (.C(clk), .R(0), .CE(~clk), .D(ltrin), .Q(ltr));
endmodule
