`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2018 11:54:27 AM
// Design Name: 
// Module Name: top
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


module top(
    input SW0, //cin
    input SW1, //a0
    input SW2, //a1
    input SW3, //a2
    input SW4, //b0
    input SW5, //b2
    input SW6, //b3
     
    //NIXIE TUBE SHIT
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG,
    output an0,
    output an1,
    output an2,
    output an3
    );
    //SUM BITS
    wire sum1, sum2, sum3, sum4;
    
    //3 bit adder
    bitBitch adder (.cin(SW0), .a1(SW1), .a2(SW2), .a3(SW3), .b1(SW4), .b2(SW5),
            .b3(SW6), .s1(sum1), .s2(sum2), .s3(sum3), .s4(sum4));
            
    //TUBE DISPLAY
    assign an0 = 0;
    assign an1 = 1;
    assign an2 = 1;
    assign an3 = 1;         
    FuckingSegment nixie (.n1(sum1), .n2(sum2), .n3(sum3), .n4(sum4), .a(CA), 
            .b(CB), .c(CC), .d(CD), .e(CE), .f(CF), .g(CG));
endmodule
