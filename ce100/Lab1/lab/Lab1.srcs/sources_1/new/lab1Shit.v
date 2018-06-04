`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2018 01:02:13 PM
// Design Name: 
// Module Name: lab1Shit
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


module lab1Shit(
    input btnL,
    input btnR,
    output LD1,
    
    input btnU,
    output LD0,
    
    input SW0,
    input SW1,
    output LD2,
    
    input SW2,
    output LD3
    );
    
    //not
    assign LD0 = ~btnU;
    //and
    assign LD1 = btnL & btnR;
    //or
    assign LD2 = SW0 | SW1;
    //xor
    assign LD3 = SW0 ^ SW1 ^ SW2;
endmodule
