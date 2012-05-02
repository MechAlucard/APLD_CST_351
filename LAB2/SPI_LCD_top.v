module SPI_LCD_top(
input MISO,send,SCLK,
output[7:0] data_recive,
input[7:0] data_send,
output MOSI
);
SPI U0(
.MOSI(MOSI),
.MISO(MISO),
.data_ready(data_ready),
.data_send(data_send),
.data_recive(data_recive),
.SCLK(SCLK),
.send(send));
endmodule

module SPI(
output MOSI,
output reg data_ready,
input MISO,
input[7:0] data_send,
output[7:0] data_recive,
input SCLK,send
);
reg [3:0]count;

shift_out_reg8 U1(
.d(data_send),
.so(MOSI),
.load(send),
.clk(SCLK),
.si(1'b0));

shift_in_reg8 U2(
.d(data_recive),
.si(MISO),
.load(data_ready),
.clk(SCLK));
always @ (posedge SCLK)
begin
	if(count > 8)
		count = 4'b000;
	else
		count = (count>8)? 3'b000 : count + 1;
	if(count == 8)
		data_ready = 1'b1;
	else
		data_ready = 1'b0;
end

endmodule

module shift_out_reg8(
input [7:0] d,
output so,
input load,clk,si);
reg [7:0]tmp;
always @(posedge clk)
	begin
	   if (load) 
              tmp <= d;
	   else
	      tmp <= {tmp[6:0], si};
	end
	   assign so = tmp[7];
endmodule

module shift_in_reg8(
output reg [7:0] d,
input si,load,clk);
reg [7:0]temp;
always @ (posedge clk)
begin
	if(load)
		d <= temp;
	else
		temp[7:0] <= {temp[6:0],si};
end
endmodule

