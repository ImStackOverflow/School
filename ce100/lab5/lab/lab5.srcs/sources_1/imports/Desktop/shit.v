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


module shit(
	input clk,
	input btnc,
	input btnu,
	input btnd,
	input led,
	input tup,
	output reset,
	output incu,
	output incd,
	output showscore,
	output runit, 
	output ldtime,
	output showtime
	);


    //inputs
    wire idlein, countin, pollin, p1in, p2in, penis1in, penis2in, bothin;
    
    //outputs
    wire idle, count, poll, p1, p2, penis1, penis2, both;
    
    assign idlein  = idle&~btnc | tup & (poll | penis1 | penis2 | both);
    assign countin = idle&btnc | count&~led;
    assign pollin = count&led | poll&~btnu&~btnd&~tup;
    assign p1in = (btnu&~btnd&~tup)&(p1 | poll);
    assign p2in = (~btnu&btnd&~tup)&(p2 | poll);
    assign penis1in = p1&tup | ~tup&(penis1 | p2&btnu&btnd);
    assign penis2in = p2&tup | ~tup&(penis2 | p1&btnu&btnd);
    assign bothin = ~tup&(both | poll&btnu&btnd);


    //actual fucking outputs fucking shit fuck guck 
    assign reset = count&led;
    assign showscore = idle;
    assign incu = tup&(penis1 | both);
    assign incd = tup&(penis2 | both);
    assign ldtime = idle&~btnc;
    assign showtime = count&~led;
    assign runit = poll | p1 | p2 | penis1 | penis2 | both; 


	FDRE #(.INIT(1'b1) ) idledick (.C(clk), .R(0), .CE(~clk), .D(idlein), .Q(idle));


	FDRE #(.INIT(1'b0) ) countdick (.C(clk), .R(0), .CE(~clk), .D(countin), .Q(count));


	FDRE #(.INIT(1'b0) ) polldick (.C(clk), .R(0), .CE(~clk), .D(pollin), .Q(poll));
	
    
    FDRE #(.INIT(1'b0) ) p1dick (.C(clk), .R(0), .CE(~clk), .D(p1in), .Q(p1));


    FDRE #(.INIT(1'b0) ) p2dick (.C(clk), .R(0), .CE(~clk), .D(p2in), .Q(p2));


    FDRE #(.INIT(1'b0) ) penis1dick (.C(clk), .R(0), .CE(~clk), .D(penis1in), .Q(penis1));
    
    
    FDRE #(.INIT(1'b0) ) penis2dick (.C(clk), .R(0), .CE(~clk), .D(penis2in), .Q(penis2));


    FDRE #(.INIT(1'b0) ) bothdick (.C(clk), .R(0), .CE(~clk), .D(bothin), .Q(both));

endmodule
