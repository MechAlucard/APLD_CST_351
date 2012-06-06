`timescale 1 ns /100 ps
module top_HW3_test;
reg			[3:0]	A;
reg			[3:0]	B;
reg					Scan_CLK;
reg			[7:0]	BCI;
reg					CLK;
wire		[2:1]	COM;
wire		[6:0]	SEG;

top_HW3 DUT(
.A(A),
.B(B),
.Scan_CLK(Scan_CLK),
.BCI(BCI),
.CLK(CLK),
.COM(COM),
.SEG(SEG));

initial begin
A = 0;
B = 0;
Scan_CLK = 0;
BCI = 0;
CLK = 0;
end
always #500000 Scan_CLK = ~Scan_CLK;
always #500 CLK = ~CLK;
initial begin
A = 5;
B = 3;
BCI = 2;
#2500000;
A = 2;
B = 8;
BCI = 240;
#2500000;
A = 4;
B = 7;
BCI = 145;
$stop;
end
endmodule
