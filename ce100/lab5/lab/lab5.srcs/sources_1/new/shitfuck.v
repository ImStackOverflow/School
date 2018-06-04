`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2018 11:42:39 PM
// Design Name: 
// Module Name: shitfuck
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

//interface to make shit last
//flip flops that remain high on single burst input

module shitfuck(
    input reset,
    input up,
    input down,
    input incu,
    input incd,
    input clk,
    output ubtn,
    output dbtn,
    output flashu,
    output flashd
    );
    
    
    wire btnu, btnd;
    
    FDRE #(.INIT(1'b0) ) uppity (.C(clk), .R(reset), .CE(~clk), .D(up), .Q(btnu));
    
    FDRE #(.INIT(1'b0) ) downsy (.C(clk), .R(reset), .CE(~clk), .D(down), .Q(btnd));
    
    FDRE #(.INIT(1'b0) ) upbutton (.C(clk), .R(reset), .CE(~clk), .D(btnu|ubtn), .Q(ubtn));

    FDRE #(.INIT(1'b0) ) downbutton (.C(clk), .R(reset), .CE(~clk), .D(btnd|dbtn), .Q(dbtn));

    FDRE #(.INIT(1'b0) ) flashitup (.C(clk), .R(reset), .CE(~clk), .D(incu|flashu), .Q(flashu));

    FDRE #(.INIT(1'b0) ) flashitdown (.C(clk), .R(reset), .CE(~clk), .D(incd|flashd), .Q(flashd));


    
endmodule
