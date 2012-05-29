`timescale 1 ns /100 ps
module Clock_Divider_test;
reg				CLK_in;
//reg	[7:0]		Duty;
wire			Scan_clk;
wire			pwm_clk;
wire			Baud_clk;

Clock_Divider DUT(
.CLK_in(CLK_in),
//.Duty(Duty),
.Scan_clk(Scan_clk),
.pwm_clk(pwm_clk),
.Baud_clk(Baud_clk));

 initial begin
 CLK_in = 0;
 //Duty = 0;
 #40;
 end
 always #20 CLK_in = ~CLK_in;
 initial begin
 #7800000;
 #100;
 $stop;
 end
 endmodule
