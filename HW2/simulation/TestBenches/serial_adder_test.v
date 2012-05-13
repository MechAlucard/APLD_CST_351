`timescale 1 ns /100 ps
module serial_adder_test;
reg			CLK;
reg			a;
reg 		b;
wire 		Sum;
wire		c_out;

serial_adder DUT1(
.CLK(CLK),
.a(a),
.b(b),
.Sum(Sum),
.c_out(c_out));
 initial begin
 CLK = 0;
 a = 0;
 b = 0;
 end
 always #20 CLK = ~CLK;
 
 initial begin
 #10
 a = 1;
 b = 1;
 #200
 a = 1;
 b = 0;
 #100
 a = 0;
 b = 1;
 #200
 a = 0;
 b = 0;
 
#200 $finish;
 end
 endmodule
 