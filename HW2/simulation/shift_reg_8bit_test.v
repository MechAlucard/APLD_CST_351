`timescale 1 ns /100 ps
module shift_reg_8bit_test;
reg			CLK;
reg			ENA;
reg 		S_in;
wire [7:0]	Data_out;

shift_reg_8bit DUT2(
.CLK(CLK),
.ENA(ENA),
.S_in(S_in),
.Data_out(Data_out));
 initial begin
 CLK = 0;
 ENA = 1;
 end
 always #20 CLK = ~CLK;
 
 initial begin
 S_in = 1;
 #200
 S_in = 0;
 #100
 ENA = 0;
 #200
 S_in = 1;
 
#200 $finish;
 end
 endmodule
 