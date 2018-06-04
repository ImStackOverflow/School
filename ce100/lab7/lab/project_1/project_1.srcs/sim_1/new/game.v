// CMPE 100 
// This is a testbench for Lab 2.
// If the top level module in your Lab 2 project is named "top_lab2"
// and you used the suggested names for its inputs/outputs then
// then it will run without modification.  Otherwise follow the instructions
// in the comments marked "TODO" to modify this testbench to conform to your project.
`timescale 1ns/1ps

module game();
   
    reg clkin; //clk
    reg hit;
    reg move;
    reg win;
    reg btnc;
    wire gstart;
    wire showtime;
    wire reset;
    wire iloss;
    wire iwin;
    wire fblue;

// TODO: replace "top_lab2" with the name of your top level Lab 2 module.
   steakmachine UUT (
        .clk(clkin), .hit(hit), .move(move), .win(win), .btnc(btnc), .gstart(gstart),
        .showtime(showtime), .reset(reset), .iloss(iloss), .iwin(iwin), .fblue(fblue)
        );
// TODO: In the three lines above, make sure the pin names match the names
// used for the inputs/outputs of your top level module.   For example, if you
// used "cin" rather than "sw0", then replace ".sw0(sw0)" with ".cin(sw0)" 
     
    initial
    begin
    move = 1'b0;
    btnc = 1'b0;
    hit = 1'b0;
    win = 1'b0;
    
	
    #100
    //start moving fuckers
    
    move = 1'b1;
    #20
    move = 1'b0;
    #30
    hit = 1'b1;
    #100
    hit = 1'b0;
    btnc = 1'b1;
    #30
    btnc = 1'b0;
    #40
    move = 1'b1;
    #100
    move = 1'b0;
    #10
    win = 1'b1;
    #100
    win = 1'b0;
    btnc = 1'b1;
    #30
    btnc = 1'b0;
    
    
    
    end
    
    parameter PERIOD = 10;
     parameter real DUTY_CYCLE = 0.5;
     parameter OFFSET = 2;
 
     initial    // Clock process for clkin
     begin
         #OFFSET
           clkin = 1'b1;
         forever
         begin
             #(PERIOD-(PERIOD*DUTY_CYCLE)) clkin = ~clkin;
         end
     end
     
    initial
    begin
      // add your stimuli here
      // to set signal foo to value 0 use
      // foo = 1'b0;
      // to set signal foo to value 1 use
      // foo = 1'b1;
      //always advance time my multiples of 100ns
      // to advance time by 100ns use the following line
      #100;
     end
endmodule	
