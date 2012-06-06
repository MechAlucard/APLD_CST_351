// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 06/04/2012 
// Design Name: Pluse width modulator
// Module Name: PWM.v
// Project Name: CST 351 – Homework 3
// Target Devices: EPM2210F324C3N
// Description: sends out a pulse width
module PWM(
input			CLK,
input	[7:0] 	BCI,
output	reg		OUT);
reg		[7:0]	count;
initial begin
count = 0;
OUT = 0;
end
always @ (posedge CLK)
begin
	if(count <= BCI)
	begin
		OUT = 1;
	end
	else
	begin
		OUT = 0;
	end
	count = count +1;
end
endmodule
