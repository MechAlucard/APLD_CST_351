`timescale 1 ns /100 ps
module top_vending_test;
reg		clk;
reg		rst;
reg		dollar;
reg		quarter;
reg		dime;
reg		nickel;
wire	cooikes;
wire	candy;
wire	chips;
wire	gum;
wire	c_dime;
wire	c_nickel;
wire	c_quarter;
reg	[4:1]	keyrow;
wire	[3:0] keycolumn;

top_vending DUT(
.clk(clk),
.rst(rst),
.dollar(dollar),
.quarter(quarter),
.dime(dime),
.d_cookies(cookies),
.d_candy(candy),
.d_gum(gum),
.d_chips(chips),
.c_quarter(c_quarter),
.c_dime(c_dime),
.c_nickel(c_nickel),
.keyrow(keyrow),
.keycolumn(keycolumn));
initial begin

 
 $stop;
 end
 endmodule
