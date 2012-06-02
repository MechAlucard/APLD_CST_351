`timescale 1 ns /100 ps
module BCD_decoder3dig_test;
reg			[7:0]	in;
wire		[3:0]	dig1;
wire		[3:0]	dig2;
wire		[3:0]	dig3;

BCD_decoder3dig DUT(
.in(in),
.dig1(dig1),
.dig2(dig2),
.dig3(dig3));

 initial begin
 in = 0;
 #40;
 end
 initial begin
 #100;
 in = 123;
 #100;
 in = 145;
 #100;
 in = 23;
 #100;
 in = 4;
 #100;
 $stop;
 end
 endmodule
