`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2018 12:56:48 PM
// Design Name: 
// Module Name: topoffmydick
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


 module topoffmydick(
    input clkin,
    input btnC,
    input btnU,
    input btnL, 
    input btnR,
    input btnD,
    input [6:0] sw,
    output [6:0] seg,
    output [3:0] an,
    output [3:0] vgaRed,
    output [3:0] vgaBlue,
    output [3:0] vgaGreen,
    output [6:0] led,
    output Hsync,
    output Vsync
    );
    
    //create qsec timer
    wire hsec, reset, sec;
    
    //gap width of lines
    wire [7:0] gap;
    
    //fucking statemachine shit
    wire showtime, reset, move, gs, hit, win, loss, incrwin, flashblue;
    
    //animation bits
    wire Horizsync, VertSync, endframe, showshit;
        
    //vga shit
    wire [3:0] red, green, blue;
    
    //screen position shit
    wire [9:0] horizon, vert;

    
    ////////////////////////////////
    //////// OVERHEAD /////////////
    //////////////////////////////
    
    //reset game to initial cond if btnC is pressed
    assign led = sw;
    assign gap = {4'd0, sw[6:4]} * 7'd32 + 7'd16;
    //clock module
    wire clk, digsel;
    lab7_clks not_so_slow (.clkin(clkin), .greset(sw[0]), .clk(clk), .digsel(digsel));

    //syncs pixel showing
    sync shit (.clk(clk), .r(red), .g(green), .b(blue), .vr(vgaRed), .vb(vgaBlue), .vg(vgaGreen), .show(showshit));
        
    timeshit fuckingtime (.clk(clk), .endframe(endframe), .hsec(hsec), .sec(sec));
        
        
    //////////////////////////////
    //////// STATE MACHINE //////
    /////////////////////////////
    assign move = btnU | btnD | btnL | btnR;
    
    steakmachine Toplevelshit (.clk(clk), .hit(hit), .move(move), .win(win), .btnc(btnC),
        .gstart(gs), .showtime(showtime), .reset(reset), .iloss(loss), .iwin(incrwin), .fblue(flashblue));
        
        
        
    //////////////////////////////
    //////// SCREEN ANIMATION////
    /////////////////////////////

        
    //gives pixel position        
    dickplay foeplay (.clk(clk), .horizontal(horizon), .vertical(vert), .hsync(Hsync),
        .vsync(Vsync), .showshit(showshit), .endframe(endframe));
    
    
            
    //////////////////////////////////
    ////// BORDER INFORMATION ///////
    ////////////////////////////////
    
    //show blue border
    //drive correct lines high on specific inputs
    border crossing (.horizontal(horizon), .qsec(hsec), .flash(flashblue), .vert(vert), .blue(blue));
    
    
    //////////////////////////////////
    ////// TIMER SHIT /////////////  
    /////////////////////////////////
    
    fuckingtimer AHHHHH (.clk(clk), .digsel(digsel), .second(sec), .reset(reset), .showtime(showtime), 
        .win(incrwin), .loss(loss), .an(an), .cathode(seg));
    
    //////////////////////////////////
    ////// BARRIER SHIT /////////////  
    /////////////////////////////////
    
    wire [13:0] redoctober, gethit;
    
    assign red = {3{|redoctober}};
    //for the state machine
    assign hit = |gethit;
    
    //vertical

    drawline fuckingline (.clk(clk), .hsec(hsec), .gamestart(gs), .gap(gap), .endframe(endframe),
        .orientation(1'b0), .reset(reset), .horizon(horizon), .vert(vert), .startx(10'd158),
        .starty(10'd78), .player(green), .border(blue), .red(redoctober[0]), .hit(gethit[0]));
        
    drawline fuckingline1 (.clk(clk), .hsec(hsec), .gamestart(gs), .gap(gap), .endframe(endframe),
        .orientation(1'b0), .reset(reset), .horizon(horizon), .vert(vert), .startx(10'd208),
        .starty(10'd128), .player(green), .border(blue), .red(redoctober[1]), .hit(gethit[1]));
    
    drawline fuckingline2 (.clk(clk), .hsec(hsec), .gamestart(gs), .gap(gap), .endframe(endframe),
        .orientation(1'b0), .reset(reset), .horizon(horizon), .vert(vert), .startx(10'd258),
        .starty(10'd178), .player(green), .border(blue), .red(redoctober[2]), .hit(gethit[2]));
        
      
    drawline fuckingline3 (.clk(clk), .hsec(hsec), .gamestart(gs), .gap(gap), .endframe(endframe),
        .orientation(1'b0), .reset(reset), .horizon(horizon), .vert(vert), .startx(10'd308),
        .starty(10'd228), .player(green), .border(blue), .red(redoctober[4]), .hit(gethit[3]));
        
      
    drawline fuckingline4 (.clk(clk), .hsec(hsec), .gamestart(gs), .gap(gap), .endframe(endframe),
        .orientation(1'b0), .reset(reset), .horizon(horizon), .vert(vert), .startx(10'd408),
        .starty(10'd278), .player(green), .border(blue), .red(redoctober[5]), .hit(gethit[4]));
        
      
    drawline fuckingline5 (.clk(clk), .hsec(hsec), .gamestart(gs), .gap(gap), .endframe(endframe),
        .orientation(1'b0), .reset(reset), .horizon(horizon), .vert(vert), .startx(10'd458),
        .starty(10'd328), .player(green), .border(blue), .red(redoctober[6]), .hit(gethit[5]));
        
      
    drawline fuckingline6 (.clk(clk), .hsec(hsec), .gamestart(gs), .gap(gap), .endframe(endframe),
        .orientation(1'b0), .reset(reset), .horizon(horizon), .vert(vert), .startx(10'd358),
        .starty(10'd378), .player(green), .border(blue), .red(redoctober[7]), .hit(gethit[6]));
            
      
      
      //horizontal
      
      drawline FUCKINGKILLME (.clk(clk), .hsec(hsec), .gamestart(gs), .gap(gap), .endframe(endframe),
          .orientation(1'b1), .reset(reset), .horizon(horizon), .vert(vert), .startx(10'd158),
          .starty(10'd78), .player(green), .border(blue), .red(redoctober[8]), .hit(gethit[7]));
          
      drawline FUCKINGKILLME1 (.clk(clk), .hsec(hsec), .gamestart(gs), .gap(gap), .endframe(endframe),
          .orientation(1'b1), .reset(reset), .horizon(horizon), .vert(vert), .startx(10'd208),
          .starty(10'd128), .player(green), .border(blue), .red(redoctober[9]), .hit(gethit[8]));
      
      drawline FUCKINGKILLME2 (.clk(clk), .hsec(hsec), .gamestart(gs), .gap(gap), .endframe(endframe),
          .orientation(1'b1), .reset(reset), .horizon(horizon), .vert(vert), .startx(10'd258),
          .starty(10'd178), .player(green), .border(blue), .red(redoctober[10]), .hit(gethit[9]));
          
        
      drawline FUCKINGKILLME3 (.clk(clk), .hsec(hsec), .gamestart(gs), .gap(gap), .endframe(endframe),
          .orientation(1'b1), .reset(reset), .horizon(horizon), .vert(vert), .startx(10'd308),
          .starty(10'd228), .player(green), .border(blue), .red(redoctober[11]), .hit(gethit[10]));
          
        
      drawline FUCKINGKILLME4 (.clk(clk), .hsec(hsec), .gamestart(gs), .gap(gap), .endframe(endframe),
          .orientation(1'b1), .reset(reset), .horizon(horizon), .vert(vert), .startx(10'd358),
          .starty(10'd278), .player(green), .border(blue), .red(redoctober[12]), .hit(gethit[11]));
          
        
      drawline FUCKINGKILLME5 (.clk(clk), .hsec(hsec), .gamestart(gs), .gap(gap), .endframe(endframe),
          .orientation(1'b1), .reset(reset), .horizon(horizon), .vert(vert), .startx(10'd408),
          .starty(10'd328), .player(green), .border(blue), .red(redoctober[13]), .hit(gethit[12]));
          
        
      drawline FUCKINGKILLME6 (.clk(clk), .hsec(hsec), .gamestart(gs), .gap(gap), .endframe(endframe),
          .orientation(1'b1), .reset(reset), .horizon(horizon), .vert(vert), .startx(10'd58),
          .starty(10'd378), .player(green), .border(blue), .red(redoctober[14]), .hit(gethit[13]));
        
    
    //////////////////////////////////
    ////// PLAYER INFORMATION ///////
    ////////////////////////////////
    
    //player position
    wire [9:0] playerX, playerY;
    
    playerbitch lauracroft (.clk(clk), .qsec(hsec), .up(btnU), .down(btnD), .left(btnL), .right(btnR),
        .reset(reset), .endframe(endframe), .horizposition(horizon), .vertposition(vert), .red(red), 
        .green(green), .bitchHoriz(playerX), .bitchVert(playerY), .win(win));
    
endmodule
