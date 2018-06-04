`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2018 01:19:40 PM
// Design Name: 
// Module Name: countUD5L
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
//Q is 5 bit output

module countUD5L(
    input clk, //clock
    input up, //up event
    input down, //down event
    input ld, //load in switch event 
    input [4:0] din, //switch preset
    output utc, //shits all one
    output dtc, //shits all 0
    output [4:0] Q //output shit
    );
    
    wire enable;
    //enable flip flop change when that shit wants to happen
   assign enable = up | down | ld;
       
   //high on all ones
   assign utc = up & (&Q);
    //high on all zeros and weed
    assign dtc = down & (~(|Q));
        
    //Q input logic
    //up count and down and overall count input respectively bitch 
    wire [4:0] Du, Dd, D;
    
    //incrimenter logic
    //incriment lowest shit
    assign Du[0] = ~Q[0];
    //incriment 2nd bit shit
    assign Du[1] = Q[0]&~Q[1] | ~Q[0]&Q[1];
    //incriment 3rd shit
    assign Du[2] = Q[2]&(~(&Q[1:0])) | ~Q[2]&(&Q[1:0]);
    //incriment 4th shit
    assign Du[3] = Q[3]&(~(&Q[2:0])) | ~Q[3]&(&Q[2:0]);
    //incriment 5th shit
    assign Du[4] = Q[4]&(~(&Q[3:0])) | ~Q[4]&(&Q[3:0]);
    
    
    //decrimenter logic
    //down on 0 bitch
    assign  Dd[0] = ~Q[0];
    //down on 1 bitch
    assign Dd[1] = ~Q[1]&~Q[0] | Q[1]&Q[0];
    
    //one if i'm one and theres another one after me, i.e. a one to absorb the subtraction
    // or if were all zero in which case reset to all
    //down on 2 bitch
    assign Dd[2] = Q[2]&(|(Q[1:0])) | ~(|Q[2:0]);
    //down on 3 bitch
    assign Dd[3] = Q[3]&(|(Q[2:0])) | ~(|Q[3:0]);
    //down on 4 bitch    
    assign Dd[4] = Q[4]&(|(Q[3:0])) | ~(|Q[4:0]);
    //assign final ooutput as choosing between up or down bus or set switches
    assign D = {5{up}}&Du | {5{down}}&Dd | {5{ld}}&din;
    
    FDRE #(.INIT(1'b0) ) q0 (.C(clk), .R(1'b0), .CE(enable), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0) ) q1 (.C(clk), .R(1'b0), .CE(enable), .D(D[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0) ) q2 (.C(clk), .R(1'b0), .CE(enable), .D(D[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0) ) q3 (.C(clk), .R(1'b0), .CE(enable), .D(D[3]), .Q(Q[3]));
    FDRE #(.INIT(1'b0) ) q4 (.C(clk), .R(1'b0), .CE(enable), .D(D[4]), .Q(Q[4]));
endmodule
