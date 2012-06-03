// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 06/04/2012 
// Design Name: coin_reg_test
// Module Name: coin_reg_test
// Project Name: CST 351 – Lab 3
// Target Devices: EPM2210F324C3N
// Description: tests adding and subtractin on the reg
`timescale 1 ns /100 ps
module coin_reg_test;
reg				reset;
reg				add;
reg				dollar;
reg				quarter;
reg				dime;
reg				nickel;
reg				gum;
reg				candy;
reg				cookies;
reg				chips;
wire	[7:0]	coins;


coin_reg DUT(
.reset(reset),
.add(add),
.dollar(dollar),
.quarter(quarter),
.dime(dime),
.nickel(nickel),
.gum(gum),
.candy(candy),
.cookies(cookies),
.chips(chips),
.coins(coins));

 initial begin
 reset = 0;
 add = 0;
 quarter = 0;
 dime = 0;
 nickel = 0;
 gum = 0;
 candy = 0;
 cookies = 0;
 chips = 0;
 dollar = 0;
 #40;
 end
 
 initial begin
 #40;
 quarter = 1;
 #40
 add = 1;
 #40;
 add = 0;
 quarter = 0;
 dime = 1;
 #40
 add = 1;
 #40;
 add = 0;
 dime = 0;
 #40;
 nickel = 1;
 #40
 add = 1;
 #40;
 add = 0;
 nickel = 0;
 #40;
 dollar = 1;
 #40
 add = 1;
 #40;
 add = 0;
 dollar = 0;
 gum = 1;
 #40
 add = 1;
 #40;
 add = 0;
 gum = 0;
 dollar = 1;
 #40
 add = 1;
 #40;
 add = 0;
 dollar = 0;
 chips = 1;
 #40
 add = 1;
 #40;
 add = 0;
 chips = 0;
 #40;
 dollar = 1;
 #40
 add = 1;
 #40;
 add = 0;
 dollar = 0;
 cookies = 1;
 #40
 add = 1;
 #40;
 add = 0;
 cookies = 0;
 #100;
 dollar = 1;
 #40
 add = 1;
 #40;
 add = 0;
 dollar = 0;
 candy = 1;
 #40
 add = 1;
 #40;
 add = 0;
 candy = 0;
 dime = 1;
 #40
 add = 1;
 #40;
 add = 0;
 dime = 0;
 #40;
 nickel = 1;
 #40
 add = 1;
 #40;
 add = 0;
 reset = 1;
 #100;
 $stop;
 end
 endmodule
