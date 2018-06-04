`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2018 07:13:41 PM
// Design Name: 
// Module Name: russia
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

//moore state machine for line movement shit
//all outputs are held high for duration of state

module russia(
    input clk,
    input reset,
    input gamestart,
    input eright,
    input eleft,
    input hit,
    output idle,
    output incr,
    output decr,
    output flash
    );
    
    
    //inputs
    wire idlein, incrin, decrin, stopin;
   
    
    //idle state
    assign idlein = idle&~gamestart | reset;
    FDRE #(.INIT(1'b1) ) ides (.C(clk), .R(1'b0), .CE(1'b1), .D(idlein), .Q(idle));
    
    //incriment shit
    assign incrin = (idle&gamestart | decr&eleft | incr&~eright&~hit) & ~reset;
    FDRE #(.INIT(1'b0) ) moveincr (.C(clk), .R(1'b0), .CE(1'b1), .D(incrin), .Q(incr));
    
    //decriment shit
    assign decrin = (incr&eright&~hit | decr&~eleft&~hit) & ~reset;
    FDRE #(.INIT(1'b0) ) movedecr (.C(clk), .R(1'b0), .CE(1'b1), .D(decrin), .Q(decr));
    
    assign stopin = (incr&hit | decr&hit | flash) & ~reset;
    FDRE #(.INIT(1'b0) ) flashme (.C(clk), .R(1'b0), .CE(1'b1), .D(stopin), .Q(flash));
    
endmodule
