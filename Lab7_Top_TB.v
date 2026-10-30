`timescale 1ns / 1ps

module Lab7_Top_TB;
 
 reg clk;
 reg btnC;
 
 wire [6:0] seg;
 wire [3:0] an;
 wire dp;
 wire [11:0] led;

 
 
 Lab7_Top uut (
    .clk(clk),
    .btnC(btnC),
    .seg(seg),
    .an(an),
    .dp(dp),
    .led(led)
 );

 initial clk = 1'b0;
 always #5 clk = ~ clk;   

 initial begin
       
       btnC = 1;
       #100 btnC = 0;
       
       #20000;
       
       btnC = 1;
       #100 btnC = 0;
       
       #45000;
       $finish;
 end

endmodule
