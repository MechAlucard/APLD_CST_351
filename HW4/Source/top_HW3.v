module top_HW3(
input	[3:0]	A,B,
input			Scan_CLK,
output	[2:1]	COM,
output	[6:0]	SEG,
input	[7:0]	BCI,
input			CLK);
wire	[2:1]	COM_w;
wire			ENA;
MUX_DISP MD1(
.A(A),
.B(B),
.clk(Scan_CLK),
.com_1(COM_w[1]),
.com_2(COM_w[2]),
.seg_A(SEG[0]),
.seg_B(SEG[1]),
.seg_C(SEG[2]),
.seg_D(SEG[3]),
.seg_E(SEG[4]),
.seg_F(SEG[5]),
.seg_G(SEG[6]));
PWM PW1(
.CLK(CLK),
.BCI(BCI),
.OUT(ENA));
assign COM = ENA ? COM_w : 2'b11;

endmodule
