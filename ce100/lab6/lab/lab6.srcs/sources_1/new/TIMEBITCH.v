`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2018 01:24:34 PM
// Design Name: 
// Module Name: TIMEBITCH
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


//counter that incriments on adv

module TIMEBITCH(
    input clk,
    input adv,
    input reset,
    output halfsec,
    output second
    );
    
    wire q0, q1, d1, fuck, shit;
    
    assign d1 = ~q1&q0 | q1&~q0;
    
    //first bit of counter
    FDRE #(.INIT(1'b1) ) quart0 (.C(clk), .R(1'b0), .CE(adv), .D(~q0), .Q(q0));
    
    
    //fuckking second
    FDRE #(.INIT(1'b0) ) quart1 (.C(clk), .R(1'b0), .CE(adv), .D(d1), .Q(q1));
    
       //halfsec on 01 or 11
       //constant output for halfsec
     assign halfsecin = ~q1&q0 | q1&q0;
     
     //second on 11
     assign secondin = q1&q0;
    
    //state flop for half sec
    FDRE #(.INIT(1'b0) ) halfshell (.C(clk), .R(reset), .CE(~clk), .D(halfsecin|fuck), .Q(fuck));
    
    //edge detector for sec
    FDRE #(.INIT(1'b0) ) sex (.C(clk), .R(1'b0), .CE(~clk), .D(secondin), .Q(shit));

    
    
    //only high for singel cock cycle
    assign second = ~shit&secondin;
    assign halfsec = shit;
endmodule
