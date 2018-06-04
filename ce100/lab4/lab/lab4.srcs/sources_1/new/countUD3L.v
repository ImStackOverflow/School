`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2018 11:55:47 AM
// Design Name: 
// Module Name: QUD3L
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


//fucking flip flop counter
//input the clock cycle to synchinoize flip flops
//up and down inputs are events to change counter
//either count up or down dumbass
//ld is option to load in binary num specified by din
//press up to enable up count, down to enable down count, load to load in din number
//utc is high on all bits equal 1, ie count to next bit bitchass
//dtc is high on all 0, i.e. count down previous bie bitchass
//Q is 3 bit output

module countUD3L(
    input clk, //input clock fucker
    input up, //count up
    input down, //count down
    input ld, //load option
    input [2:0] din, //input switches
    output utc, //output one when all flip flops high
    output dtc, //one when all the fuckers are 0
    output [2:0] Q //output number count
    );
    wire enable;
    //enable flip flop change when that shit wants to happen
    assign enable = up | down | ld;
    
    //high on all ones
    assign utc = up & (&Q);
    //high on all zeros and weed
    assign dtc = down& (~(|Q));
    
    //Q input logic
    //up count and down and overall count respectively bitch 
    wire [2:0] Du, Dd, D;
    
    //incrimenter logic
    //incriment lowest shit
    assign Du[0] = ~Q[0];
    //incriment 2nd bit shit
    assign Du[1] = Q[0]&~Q[1] | ~Q[0]&Q[1];
    //incriment msbitch shit
    assign Du[2] = ~Q[1]&Q[2] | ~Q[2]&Q[1]&Q[0] | Q[2]&Q[1]&~Q[0];
    
    //decrimenter logic
    //down on 0 bitch
    assign  Dd[0] = ~Q[0];
    //down on 1 bitch
    assign Dd[1] = ~Q[1]&~Q[0] | Q[1]&Q[0];
    //down on 2 bitch
    assign Dd[2] = Q[2]&Q[0] | Q[2]&Q[1]&~Q[0] | ~Q[2]&~Q[1]&~Q[0];
    
    //assign final ooutput as choosing between up or down bus or set switches
    assign D = {3{up}}&Du | {3{down}}&Dd | {3{ld}}&din;
    
    FDRE #(.INIT(1'b0) ) q0 (.C(clk), .R(0), .CE(enable), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0) ) q1 (.C(clk), .R(0), .CE(enable), .D(D[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0) ) q2 (.C(clk), .R(0), .CE(enable), .D(D[2]), .Q(Q[2]));
endmodule
