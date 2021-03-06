// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Clockdivider testbench
// Project Name: CST 351 � Lab 2
// Target Devices: EPM2210F324C3N
// Description: test bench for clock divider
`timescale 1 ns /100 ps //timeunit = 1ns, precision = 1/10ns
module ClockDividerTest();
reg			CLK;
wire		CLK_1K;

//design to simulate
ClockDivider DUT1(
.CLK(CLK),
.CLK_1K(CLK_1K));

//reset and clock section
initial
	begin
	#1CLK = 0;
	end
always #20 CLK = ~CLK;//50MHz CLK

initial begin
wait(CLK_1K == 0);
wait(CLK_1K == 1);
wait(CLK_1K == 0);
wait(CLK_1K == 1);
wait(CLK_1K == 0);
$finish;
end
endmodule
