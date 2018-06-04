`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2018 12:31:52 PM
// Design Name: 
// Module Name: FuckingSegment
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

//module for interfacing with 7 segment bullshit
//input a 4 bit number (n1-n4)
//get out corresponding ground connections (a-g)
//hookup input bits then output segment bits dumbass
//its intverted
//ie flips the output bits to 0 when led segment should be on, 1 when it should be off


module FuckingSegment(
    input n1,
    input n2,
    input n3,
    input n4,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g
    );
    
    //0 ~n4 & ~n3 & ~n2 & ~n1 
    //1 ~n4 & ~n3 & ~n2 & n1
    //2 ~n4 & ~n3 & n2 & ~n1
    //3 ~n4 & ~n3 & n2 & n1
    //4 ~n4 & n3 & ~n2 & ~n1
    //5 ~n4 & n3 & ~n2 & n1
    //6 ~n4 & n3 & n2 & ~n1
    //7 ~n4 & n3 & n2 & n1
    //8 n4 & ~n3 & ~n2 & ~n1
    //9 n4 & ~n3 & ~n2 & n1
    //a n4 & ~n3 & n2 & ~n1
    //b n4 & ~n3 & n2 & n1
    //c n4 & n3 & ~n2 & ~n1
    //d n4 & n3 & ~n2 & n1
    //e n4 & n3 & n2 & ~n1
    //f  n4 & n3 & n2 & n1
    
    //segment a
    //turns off for 1,4,B,D
    assign a = (~n4 & ~n3 & ~n2 & n1) + (~n4 & n3 & ~n2 & ~n1) + (n4 & ~n3 & n2 & n1) + (n4 & n3 & ~n2 & n1);
    
    //segment b
    //turns off for 5,6,B,C,E,F
    assign b = (~n4 & n3 & ~n2 & n1) + (~n4 & n3 & n2 & ~n1) + (n4 & ~n3 & n2 & n1) + (n4 & n3 & ~n2 & ~n1) + (n4 & n3 & n2 & ~n1) + (n4 & n3 & n2 & n1);
    
    //segment c
    //turns off for 2,C,E,F
    assign c = (~n4 & ~n3 & n2 & ~n1) + (n4 & n3 & ~n2 & ~n1) + (n4 & n3 & n2 & ~n1) + (n4 & n3 & n2 & n1);
    
    //segment d
    //turns off for 1,4,7,A,F
    assign d = (~n4 & ~n3 & ~n2 & n1) + (~n4 & n3 & ~n2 & ~n1) + (~n4 & n3 & n2 & n1) + (n4 & ~n3 & n2 & ~n1) + (n4 & n3 & n2 & n1);
    
    //segment e
    //turns off for 1,3,4,5,7,9
    assign e = (~n4 & ~n3 & ~n2 & n1) + (~n4 & ~n3 & n2 & n1) + (~n4 & n3 & ~n2 & ~n1) + (~n4 & n3 & ~n2 & n1) + (~n4 & n3 & n2 & n1) + (n4 & ~n3 & ~n2 & n1);
    
    //segment f
    //turns off for 1,2,3,7,D
    assign f =  (~n4 & ~n3 & ~n2 & n1) + (~n4 & ~n3 & n2 & ~n1) + (~n4 & ~n3 & n2 & n1) + (~n4 & n3 & n2 & n1) + (n4 & n3 & ~n2 & n1);
    
    //segment g
    //turns off for 0,1,7,C
    assign g =  (~n4 & ~n3 & ~n2 & ~n1 ) + (~n4 & ~n3 & ~n2 & n1) + (~n4 & n3 & n2 & n1) + (n4 & n3 & ~n2 & ~n1);
    
    
endmodule
