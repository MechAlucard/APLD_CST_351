// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Mux Display
// Module Name: MUX_DISP
// Project Name: CST 351 – Lab 1
// Target Devices: EPM2210F324C3N
// Description: displays data in buffers to display
module MUX_DISP(
input [3:0]A,B,
input clk,
output com_1,com_2,
output seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G);
wire ena;
wire [1:0]counter;
wire [3:0]A_out,B_out,data;
initial begin
{seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G} = 0;
{com_1,com_2} = 0;
end
controller U1 (
.clk(clk),
.COM_1(com_1),
.COM_2(com_2),
.ena(ena),
.count(counter));

latch3_4bits U2 (
.A(A),
.B(B),
.clk(clk),
.ena(ena),
.A_out(A_out),
.B_out(B_out));

A4to1MUX U3 (
.A(A_out),
.B(B_out),
.sel(counter),
.out(data));

BCD_to_7seg U4 (
.A(data),
.seg_A(seg_A),
.seg_B(seg_B),
.seg_C(seg_C),
.seg_D(seg_D),
.seg_E(seg_E),
.seg_F(seg_F),
.seg_G(seg_G));


endmodule

// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: muxdisplay
// Module Name: controller
// Project Name: CST 351 – Lab 1
// Target Devices: EPM2210F324C3N
// Description: pulls collector low in sync with count
module controller(
input clk,
output [1:0] count,
output COM_1,COM_2,ena);
counter U1 (
.clk(clk),
.count(count));
decode_cnt U2 (
.count(count),
.ena(ena),
.COM_1(COM_1),
.COM_2(COM_2));


endmodule
// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Muxdisplay
// Module Name: latch3_4bits
// Project Name: CST 351 – Lab 1
// Target Devices: EPM2210F324C3N
// Description: latches data for the display
module latch3_4bits(
input [3:0]A,B,
input clk,ena,
output reg [3:0]A_out,B_out);

always @ (posedge clk)
begin
	if (!ena)
		begin
		{A_out,B_out}={A,B};
		end
	else
		begin
		{A_out,B_out}={A_out,B_out};
		end
end	
endmodule
// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Muxdisplay
// Module Name: A4to1MUX
// Project Name: CST 351 – Lab 1
// Target Devices: EPM2210F324C3N
// Description: puts out a digit based on count
module A4to1MUX(
input [3:0] A,B,
input [1:0] sel,
output reg [3:0] out);

always @ (sel)
begin
	case(sel)
		1: out = A;
		2: out = B;
		default: out = 1'bx;
	endcase
end
endmodule
// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Muxdisplay
// Module Name: BCD_to_7seg
// Project Name: CST 351 – Lab 1
// Target Devices: EPM2210F324C3N
// Description: decodes the key number to 7seg display
module BCD_to_7seg(
input [3:0]A,
output reg seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G
);
always @ (A)
begin
	case(A)
		0: {seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b1111110;
		1: {seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b0110000;
		2: {seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b1101101;
		3: {seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b1111001;
		4: {seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b0110011;
		5: {seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b1011011;
		6: {seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b1011111;
		7: {seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b1110000;
		8: {seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b1111111;
		9: {seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b1110011;
		10:{seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b1000001;
		11:{seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b0001001;
		12:{seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b0000001;
		13:{seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b0110111;
		14:{seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b1001111;
		15:{seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b0000000;
		default: {seg_A,seg_B,seg_C,seg_D,seg_E,seg_F,seg_G}= 7'b0000000;
	endcase
end

endmodule
// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Muxdisplay
// Module Name: counter
// Project Name: CST 351 – Lab 1
// Target Devices: EPM2210F324C3N
// Description: picks which segment to display 
module counter(
input clk,
output reg[1:0]count);
always @ (posedge clk)
begin
	case(count)
		0: count = 2'b01;
		1: count = 2'b10;
		2: count = 2'b11;
		3: count = 2'b00;
		default: count = 2'b00;
	endcase
end
endmodule 

// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Muxdisplay
// Module Name: decode_cnt
// Project Name: CST 351 – Lab 1
// Target Devices: EPM2210F324C3N
// Description: pulls down digit based on count
module decode_cnt(
input [1:0]count,
output reg ena,
output reg COM_1,COM_2);

always @ (count)
begin
	case(count)
		0: {COM_1,COM_2,ena} = 3'b110;
		1: {COM_1,COM_2,ena} = 3'b011;
		2: {COM_1,COM_2,ena} = 3'b101;
		default: {COM_1,COM_2,ena} = 3'b111;
	endcase
end

endmodule