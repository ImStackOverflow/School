`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2018 01:35:26 AM
// Design Name: 
// Module Name: hex7seg
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


//interface with 7 segment display
//optional negative sign display option

module hex7seg(
    input [3:0] n,//4 bit input number
    input neg,
    input e, //enable pin
    output [6:0] out // segment output
    
    );
    wire [6:0] seg;
    wire y, ny, x, z, w;
    assign y = n[0];
    assign ny = ~n[0];
    assign x = n[1];
    assign w = n[2];
    assign z = n[3];
    
    //negative sign option
    assign out = (~7'b1000000 & {7{neg}}) | {7{~neg}} & seg;
    
    //a led, 
    //min terms: 1, 4, 11, 13
    fux8to1 a (.in(~{1'b0,y,y,1'b0,1'b0,ny,1'b0,y}),.s({z,w,x}), .e(e), .out(seg[0]));
    
    //b led
    //min terms: 5, 6, 11, 12, 14, 15
    fux8to1 b (.in(~{1'b1,ny,y,1'b0,ny,y,1'b0,1'b0}),.s({z,w,x}), .e(e), .out(seg[1]));
    
    //c led
    //min terms: 2, 12, 14, 15
    fux8to1 c (.in(~{1'b1,ny,1'b0,1'b0,1'b0,1'b0,ny,1'b0}),.s({z,w,x}), .e(e), .out(seg[2]));
    
    //d led
    //min terms: 1, 4, 7, 10, 15
    fux8to1 d (.in(~{y,1'b0,ny,1'b0,y,ny,1'b0,y}),.s({z,w,x}), .e(e), .out(seg[3]));
    
    //e led
    //min terms: 1, 3, 4, 5, 7, 9
    fux8to1 ce (.in(~{1'b0,1'b0,1'b0,y,y,1'b1,y,y}),.s({z,w,x}), .e(e), .out(seg[4]));
    
    //f led
    //min terms: 1, 2, 3, 7, 13
    fux8to1 f (.in(~{1'b0,y,1'b0,1'b0,y,1'b0,1'b1,y}),.s({z,w,x}), .e(e), .out(seg[5]));
    
    //g led 
    //min terms: 0, 1, 7, 12
    fux8to1 g (.in(~{1'b0,ny,1'b0,1'b0,y,1'b0,1'b0,1'b1}),.s({z,w,x}), .e(e), .out(seg[6]));
    
    
endmodule
