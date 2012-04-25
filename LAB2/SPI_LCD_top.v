module SPI_LCD_top(
);
endmodule

module SPI(
output SCLK,MOSI,SS,
input MISO,
input[8:0] buffer,
input clkin,send
);

endmodule

module shift_out_reg8(
input [7:0] data_in,
output out,
input load,clk);
reg [7:0]data;
always @ (posedge load)
begin
	data = data_in;
end
always @ (posedge clk)
begin
	data[7:0] = {data[6:0],1'b0};
end
assign out = data[7];
endmodule

module shift_in_reg8(
output [7:0] data_out,
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

