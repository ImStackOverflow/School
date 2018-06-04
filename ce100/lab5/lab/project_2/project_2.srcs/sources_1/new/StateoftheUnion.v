`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2018 01:10:56 PM
// Design Name: 
// Module Name: StateoftheUnion
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


module StateoftheUnion(
    input btnU, //player 1
    input btnD, //player2
    input btnC, //go
    input timeup, //timeup for game
    input lastled, //start actual game
    input clk, //sync clock bitch
    output showtime, //show the playing time at begining
    output load, //load in some fucking time
    output showscore, //show the score of the shit
    output countleds, //enable leds
    output incscore, //high for 1 clock cycle to incriment score
    output countdown, //keep counting down game
    output [1:0] winner //bus to hold winner in [p2,p1]
    
    );
    //states: 0= idle, 1=count, 2=play, 3=change
    wire[3:0] state, D;
    //
    wire q0, q1;
    FDRE #(.INIT(1'b0) ) idle (.C(clk), .R(0), .CE(clk), .D(D[0]), .Q(state[0]));
    //countdown
    FDRE #(.INIT(1'b0) ) GETFUCKINGREADY (.C(clk), .R(0), .CE(clk), .D(D[1]), .Q(state[1]));
    FDRE #(.INIT(1'b0) ) playgame (.C(clk), .R(0), .CE(clk), .D(D[2]), .Q(state[2]));
    FDRE #(.INIT(1'b0) ) changescore (.C(clk), .R(0), .CE(clk), .D(D[3]), .Q(state[3]));
    //take snapshot of score in transition out of play game state
    FDRE #(.INIT(1'b0) ) player1 (.C(clk), .R(0), .CE(D[3]), .D(q0), .Q(winner[0]));
    FDRE #(.INIT(1'b0) ) player2 (.C(clk), .R(0), .CE(D[3]), .D(q1), .Q(winner[1]));
    playershit game (.clk(clk), .reset(D[1]), .bu(btnU), .bd(btnD), .q0(q0), .q1(q1));
    //stay in idle while btnc hasent been pressed
    assign D[0] = ~btnC & state[0] | state[3];
    
    //stay in count down while the last led isnt done 
    assign D[1] = state[0] & btnC | state[1] & ~lastled;
    
    //stay in game play until time is up
    assign D[2] = state[1] & lastled | state[2] & ~timeup;
    
    //set change score for one cycle to incriment the player
    assign D[3] = state[2] & timeup;
    
    //do certain things per state
    assign showscore = state[0];
    assign load = state[1];
    assign showtime = state[1];
    assign countleds = state[1];
    assign countdown = state[2];
    assign incscore = state[3];


endmodule
