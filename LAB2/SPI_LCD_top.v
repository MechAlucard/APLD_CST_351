module SPI_LCD_top(
output MOSI,SS,
input MISO,
input[7:0] buffer_out,buffer_in,
input SCLK,send,reset
);
SPI U0(
.SCLK(SCLK),
.MOSI(MOSI),
.SS(SS),
.MISO(MISO),
.buffer_out(buffer_out),
.buffer_in(buffer_in),
.reset(reset));
endmodule

module SPI(
output MOSI,SS,
input MISO,
input[7:0] buffer_out,buffer_in,
input SCLK,send,reset
);
reg [3:0]count;
reg data_ready;
shift_out_reg8 U1(
.data_in(buffer_out),
.out(MOSI),
.load(send),
.clk(SCLK));

shift_in_reg8 U2(
.data_out(buffer_in),
.in(MISO),
.load(data_ready),
.clk(SCLK));
always @ (posedge SCLK or posedge reset)
begin
	if(reset)
		count = 4'b000;
	else
		count = (count>8)? 3'b000 : count + 1;
end
always @ (negedge SCLK)
begin
	if(count == 8)
		data_ready = 1'b1;
	else
		data_ready = 1'b0;
end

endmodule

module shift_out_reg8(
input [7:0] data_in,
output out,
input load,clk);
reg [7:0]data;
always @ (posedge load or posedge clk)
begin
	if(load)
		data <= data_in;
	if(clk)
		data[7:0] <= {data[6:0],1'b0};
end
assign out = data[7];
endmodule

module shift_in_reg8(
output reg [7:0] data_out,
input in, load,clk);
reg [7:0]data;
always @ (load)
begin
	data_out = data;
end
always @ (posedge clk)
begin
	data[7:0] = {data[6:0],in};
end
endmodule

