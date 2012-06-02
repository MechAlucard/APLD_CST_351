`timescale 1 ns /100 ps
module coin_return_test;
reg		[7:0]  coins;
reg			     	clk;
reg     				start;
reg         reset;
wire		     	active;
wire	     		quarter_return;
wire		      dime_return;
wire			     nickel_return;


coin_return DUT(
.coins(coins),
.clk(clk),
.start(start),
.reset(reset),
.active(active),
.quarter_return(quarter_return),
.dime_return(dime_return),
.nickel_return(nickel_return));

 initial begin
 clk = 0;
 coins = 0;
 start = 0;
 reset = 0;
 #40;
 end
 always #20 clk = ~clk;
 
 initial begin
 $monitor("active = %b\nQuarter = %b\nDime = %b\nNickel = %b\n",active,quarter_return,dime_return,nickel_return);
 coins = 145;
 start = 1;
 wait(active == 1);
 start = 0;
 wait(active == 0);
 coins = 155;
 start = 1;
 wait(active == 1);
 start = 0;
 wait(active == 0);
 coins = 185;
 start = 1;
 wait(active == 1)
 #80;
 reset = 1;
 #100;
 $stop;
 end
 endmodule
