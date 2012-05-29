module Clock_Divider(
input				CLK_in,
//input	[7:0]		Duty,
output				Scan_clk,
output				pwm_clk,
output				Baud_clk);
keyscan_div U1(
.CLK_in(CLK_in),
.ena(1),
.CLK_out(Scan_clk));

PWM_unit U2(
//.Duty(Duty),
.CLK_in(CLK_in),
.ena(1),
.PWM_out(pwm_clk));

Baud_clk U3(
.CLK_in(CLK_in),
.ena(1),
.CLK_out(Baud_clk));
endmodule

module keyscan_div(
input			CLK_in,
input			ena,
output	reg		CLK_out);
reg	[11:0] count;
initial begin
count = 0;
CLK_out = 0;
end
always @ (posedge CLK_in)
begin
	if(ena)
	begin
		count = count + 1;
		if(count >= 2500)
		begin
			count = 0;
			CLK_out = ~CLK_out;
		end
	end
	else
		begin
			count = count;
			CLK_out = CLK_out;
	end
end
endmodule

module PWM_unit(
//input [7:0]			Duty,
input				CLK_in,
input				ena,
output	reg			PWM_out);
reg	[7:0]			ramp;
reg	[14:0]			count;
reg					CLK_w;
initial begin
count = 0;
ramp = 0;
PWM_out = 0;
CLK_w = 0;
end
//divide clk to 1275Hz
always @ (posedge CLK_in)
begin
	count = count + 1;
	if(count >= 19607)
	begin
		count = 0;
		PWM_out = ~PWM_out;//CLK_w = ~CLK_w;
	end
	else
	begin
		count = count;
		CLK_w = CLK_w;
	end
end
/*
always @ (posedge CLK_w)
begin
	if(~ena)
	begin
		ramp = 0;
		PWM_out = 0;
	end
	else
	begin
		ramp <= ramp +1;
		PWM_out <=(Duty>ramp);
	end
end
*/
endmodule

module Baud_clk(
input		CLK_in,
input		ena,
output	reg	CLK_out);
reg [8:0]	count;
initial begin
count = 0;
CLK_out = 0;
end
always @ (posedge CLK_in)
begin
	if(~ena)
	begin
	count = count;
	CLK_out = CLK_out;
	end
	else
	begin
	count = count + 1;
	end
	if(count >= 163)
	begin
	count = 0;
	CLK_out = ~CLK_out;
	end
	else
	begin
	count = count;
	CLK_out = CLK_out;
	end
end
endmodule
 
