`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2018 02:33:57 PM
// Design Name: 
// Module Name: counterUD16L
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
    input clkin, //clk
    input btnR, //reset fpga
    input btnU, //up count by 1
    input btnD, //down count by 1
    input btnC, //continuous count till FFFC-FFFF
    input btnL, //load switch values
    input [15:0] sw, //switch input corresponding to 16 bit num
    output [6:0] seg, //output to segment display 
    output dp, //decimal point 
    output [3:0] an, //segment annode
    output [15:0] led //leds on board
    );

    //clk is system clock
    //up is up button edge detector
    //dw is down button edge detector
    //utc is output from 16 bit counter
    //dtc is output from 16 bit counter
    wire clk, up, up1, dw, ld, utc, dtc, digsel;

    //out is output from 16 bit counter
    wire [15:0] out;
    
    //ring is output from ring bit rotator
    //digit is output from selector and input to hex7seg
    wire [3:0] rot, digit;

    //up is high if btnU edge detector or btnc is pressed 
    //until upper 14 bits are 1, then only btnU works
    assign up = up1 | (btnC & ~(&{out[15:2]}));

    //assign output leds
    assign led = out;

    //assign decimal point logic
    assign dp = 1'b1^(rot[3] & utc | rot[0] & dtc);

    //slows down system clock
    lab4_clks slowit (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel));
    
    //edge detector for up button
    edgeD upE (.clk(clk), .sh(btnU), .it(up1));
    //edge detector for down button
    edgeD dwE (.clk(clk), .sh(btnD), .it(dw));

    //16 bit counter
    counterUD16L main (.up(up), .dw(dw), .ld(btnL), 
                       .cock(clk), .sw(sw), .out(out), .utc(utc), .dtc(dtc));
    //bit rotator
    ringcounter fuck (.adv(digsel), .clk(clk), .o(rot));
    assign an = ~rot;
    
    //digit selector from counter output
    selector u (.count(out), .ring(rot), .digit(digit));
    //7 segment display interpreter
    hex7seg disp (.n(digit), .e(1), .seg(seg));
    
endmodule
