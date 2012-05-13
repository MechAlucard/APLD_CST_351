`timescale 1 ns /100 ps
module control_test;
reg			CLK;
reg			Start;
wire		Done;
wire		CLK_out;
wire		Load;

control DUT1(
.CLK(CLK),
.Start(Start),
.Done(Done),
.CLK_out(CLK_out),
.Load(Load)
);
 initial begin
 CLK = 0;
 Start = 0;
 end
 always #20 CLK = ~CLK;
 
 initial begin
 #20
 Start = 1;
 wait(Done == 0);
 Start = 0;
 wait(Done == 1);
 #50
 Start = 1;
 wait(Done == 0);
 Start = 0;
 wait(Done == 1);
 #100
 $finish;
 end
 endmodule
 