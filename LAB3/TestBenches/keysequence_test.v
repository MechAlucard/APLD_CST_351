// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 06/04/2012 
// Design Name: keysequence_test
// Module Name: keysequence
// Project Name: CST 351 – Lab 3
// Target Devices: EPM2210F324C3N
// Description: tests the sequence detector
`timescale 1 ns /100 ps
module keysequence_test;
reg		[5:0]		key;
reg					keypress;
reg					clr;
wire				gum;
wire				candy;
wire				cookies;
wire				chips;
wire				reset_out;

key_sequence DUT(
.key(key),
.keypress(keypress),
.clr(clr),
.gum(gum),
.candy(candy),
.cookies(cookies),
.chips(chips),
.reset_out(reset_out));

 initial begin
 key = 0;
 keypress = 0;
 clr = 0;
 #40;
 end
 
 initial begin
 key = 6'b110111;
 #40;
 keypress = 1;
 #40;
 keypress = 0;
 
 key = 6'b000111;
 #40;
 keypress = 1;
 #40;
 keypress = 0;
 
 key = 6'b001011;
 #40;
 keypress = 1;
 #40;
 keypress = 0;
 
 key = 6'b001101;
 #40;
 keypress = 1;
 #40;
 keypress = 0;
 
 key = 6'b110101;
 #40;
 keypress = 1;
 #40;
 keypress = 0;
 
 key = 6'b001101;
 #40;
 keypress = 1;
 #40;
 keypress = 0;
 
 key = 6'b010111;
 #40;
 keypress = 1;
 #40;
 keypress = 0;
 
 key = 6'b110111;
 #40;
 keypress = 1;
 #40;
 keypress = 0;
 
 $stop;
 end
 endmodule
