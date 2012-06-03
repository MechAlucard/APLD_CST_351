// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 06/04/2012 
// Design Name: Vending_machine_test
// Module Name: Vending_machine_test
// Project Name: CST 351 – Lab 3
// Target Devices: EPM2210F324C3N
// Description: tests the workings of the vending machine
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
wire			c_nickel;
wire			c_dime;
wire			c_quarter;
wire	[7:0]	coins;	
wire			done;
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
.c_nickel(c_nickel),
.c_dime(c_dime),
.c_quarter(c_quarter),
.coins(coins),
.done(done));
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
