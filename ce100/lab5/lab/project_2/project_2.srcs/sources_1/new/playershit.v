`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2018 11:44:13 PM
// Design Name: 
// Module Name: playershit
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

//logic to calculate winner
//is always polling winner
//sample the output at time up to get the result
module playershit(
    input clk,
    input reset, //reset scoreboard
    input bu, //input for p1
    input bd,  //input for p2
    output q0, //bit corresponding to whether winner 1 is winning
    output q1 //bit corresponding to if p2 is winning
    );
    
   //actual player button pieces
   wire p1, p2, d1, d0;
    
    //proccess button so it only happens once
    FDRE #(.INIT(1'b0) ) button1 (.C(clk), .R(reset), .CE(1'b1), .D(bu|p1), .Q(p1));
    FDRE #(.INIT(1'b0) ) button2 (.C(clk), .R(reset), .CE(1'b1), .D(bd|p2), .Q(p2));
    
    
    //actual logic shit 
    //input for q1
    assign d1 = ~q1&~q0&p2&~p1 | ~q1&q0&p2 | ~q1&~q0&p2&p1 | q1&q0;
    //input for q2
    assign d0 = ~q1&~q0&~p2&p1 | q1&~q0&p1 | ~q1&~q0&p2&p1 | q1&q0;
    
    //flip flops that hold state data
    //also correspond to if player is up/winning
    FDRE #(.INIT(1'b0) ) player1 (.C(clk), .R(reset), .CE(1'b1), .D(d0), .Q(q0));
    FDRE #(.INIT(1'b0) ) player2 (.C(clk), .R(reset), .CE(1'b1), .D(d1), .Q(q1));
    
endmodule
