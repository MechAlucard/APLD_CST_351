// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: ClockDivider
// Module Name: ClockDivider 
// Project Name: CST 351 – Lab 2
// Target Devices: EPM2210F324C3N
// Description: Divides the frequency from 50Mhz to 1KHz
 
module ClockDivider(
input CLK,
output reg CLK_1K
);

reg[14:0] count;
initial begin CLK_1K = 0; count = 0;end
always@(posedge CLK)
begin
	if(count == 25000)
		count = 0;
	else
		count = count + 15'd1;
end

always@(negedge CLK)
begin
	if(count == 25000)
		CLK_1K = ~CLK_1K;
	else
		CLK_1K = CLK_1K;
end


endmodule