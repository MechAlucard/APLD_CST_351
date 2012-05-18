`timescale 1 ns /100 ps
module Shift_in_test;
reg			GO;
reg	[3:0]	data;
wire [3:0]  A;
wire  [3:0] B;
Shift_in U2(
.data(data),
.load(GO),
.A(A),
.B(B));

 initial begin
 GO = 0;
 data = 0;
 end
 
 initial begin
 data = 5;
 #10;
 GO = 1;
 #10;
 data = 8;
 #10;
 GO = 0;
 #10
 $stop;
 end
 endmodule
 
