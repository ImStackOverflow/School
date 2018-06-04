// CMPE 100 
// This is a testbench for Lab 2.
// If the top level module in your Lab 2 project is named "top_lab2"
// and you used the suggested names for its inputs/outputs then
// then it will run without modification.  Otherwise follow the instructions
// in the comments marked "TODO" to modify this testbench to conform to your project.
`timescale 1ns/1ps

module fuckme();
   
    reg clkin;
    reg btnc;
    reg btnu;
    reg btnd;
    reg btnr;
    reg sw;
    wire [15:0] led;
    wire [3:0] an;
    wire [6:0] seg;

// TODO: replace "top_lab2" with the name of your top level Lab 2 module.
   topgun UUT (
        .clkin(clkin), .btnU(btnu), .btnD(btnd), .btnC(btnc), .btnR(btnr), .sw(sw),
        .led(led), .an(an), .seg(seg)
        );
// TODO: In the three lines above, make sure the pin names match the names
// used for the inputs/outputs of your top level module.   For example, if you
// used "cin" rather than "sw0", then replace ".sw0(sw0)" with ".cin(sw0)" 
     
  
    
    parameter PERIOD = 2;
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
   
           btnc=1'b0;
           btnu=1'b0;
           btnd=1'b0;
           btnr=1'b0;
           sw=1'b0;
           #1000
           
           btnc=1'b1;//start game
           #50
           btnc=1'b0;
           #500
           //start polling
           #1578
           btnd=1'b1;
           btnu=1'b1;
           #50 //end game
           btnd=1'b0;
           btnu=1'b0;
           
          
   
       end
endmodule	
