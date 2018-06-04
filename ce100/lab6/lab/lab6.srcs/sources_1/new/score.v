`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2018 06:32:44 AM
// Design Name: 
// Module Name: score
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


//counter of 8 bits
//goes up or down depending on incr or decr
//outputs a 7 bit number with corresponding negative or not

module score(
    input incr,
    input decr,
    input clk,
    output neg,
    output [7:0] out
    );
    
    //carry shit
    wire ass, taint, shit;
    
    //actual number
    wire [7:0] lewd, lower;
    
    //upper 4 bits
    countUD4L low (.clk(clk), .up(incr), .down(decr), .ld(1'b0), .din(4'b0), 
        .utc(ass), .dtc(taint), .Q(lewd[3:0]));
        
    //lower 4 bits        
    countUD4L upper (.clk(clk), .up(ass&incr), .down(taint&decr), .ld(1'b0), .din(4'b0), .Q(lewd[7:4]));
    
    //if a neg number, bc in 2's compliment 1st bit will show some shit
    assign neg = lewd[7];
    
    //convert from 1's compliment 
    assign shit = &lewd;
    
    //intermdtiatary to hold actual number
    assign lower = ({7{lewd[7]}} ^ lewd) | {6'b0,shit};
    
    //actual number
    assign out = {1'b0, lower[6:0]};
    
    
    
endmodule
