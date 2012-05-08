module ClockDivider(
input CLK,
output reg CLK_1K
);

reg[14:0] count;

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