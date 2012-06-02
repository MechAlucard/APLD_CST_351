`timescale 1 ns /100 ps
module vending_machine_test;
reg			cookies;
reg			candy;
reg			chips;
reg			gum;
reg			clk;
reg			rst;
reg			dollar;
reg			quarter;
reg			dime;
reg			nickel;
wire			d_cookies;
wire			d_candy;
wire			d_chips;
wire			d_gum;
wire			c_nickel;
wire			c_dime;
wire			c_quarter;
wire	[7:0]	coins;	

vending_machine DUT(
.cookies(cookies),
.candy(candy),
.chips(chips),
.gum(gum),
.clk(clk),
.rst(rst),
.dollar(dollar),
.quarter(quarter),
.dime(dime),
.nickel(nickel),
.d_cookies(d_cookies),
.d_candy(d_candy),
.d_chips(d_chips),
.d_gum(d_gum),
.c_nickel(c_nickel),
.c_dime(c_dime),
.c_quarter(c_quarter),
.coins(coins));
always #10 clk = ~clk;
 initial begin
cookies = 0;
candy = 0;
chips = 0;
gum = 0;
clk = 0;
rst = 0;
dollar = 0;
quarter = 0;
dime = 0;
nickel = 0;
 #40;
 cookies = 1;
 #40;
 cookies = 0;
  #20;
 dollar = 1;
 #40;
 dollar = 0;
  #2000;
 quarter = 1;
 #20;
 quarter = 0;
 #100;
 dime = 1;
 #20;
 dime = 0;
 #100;
 nickel = 1;
  #20;
  nickel = 0;
   #100;
 dollar = 1;
 #20;
 dollar = 0;
 #2000;
 quarter = 1;
 #20;
 quarter = 0;
 #100;
dime = 1;
 #20;
 dime = 0;
 #100;
 nickel = 1;
  #20;
  nickel = 0;
   #100;
 dollar = 1;
 #20;
 dollar = 0;
 //rst = 1;
 #125000;
 candy = 1;
 #40;
 candy = 0;
 #2000;
 quarter = 1;
 #20;
 quarter = 0;
 #100;
dime = 1;
 #20;
 dime = 0;
 #100;
 nickel = 1;
  #20;
  nickel = 0;
   #100;
 dollar = 1;
 #20;
 dollar = 0;
  #500000;
 $stop;
 end
 endmodule
