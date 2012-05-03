module SPI_LCD_top(
input MISO,SCLK,data_ready,
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
.SCLK(SCLK));
endmodule

module SPI(
output MOSI,
input data_ready,
input MISO,
input[7:0] data_send,
output[7:0] data_recive,
input SCLK
);
reg [3:0]count;
reg GCLK,active;
shift_out_reg8 U1(
.d(data_send),
.out(data_recive),
.so(MOSI),
.load(data_ready),
.clk(SCLK),
.si(MISO));

always @ (posedge SCLK)
begin
	
	if(data_ready)
		active = 1;
	if(active)
	begin
		count = (count>7)? 3'b000 : count + 1;
		if(count == 7)
			{active} = 1'b0;
		else
			{active} = 1'b1;
	end
end

endmodule

module shift_out_reg8(
input [7:0] d,
output reg[7:0] out,
output so,
input load,clk,si);
reg [7:0]tmp;
always @(posedge clk or posedge load)
	begin
	   if (load)
		begin
			out <= tmp;
            tmp <= d;
        end
	   else
	      tmp <= {tmp[6:0], si};
	end
	   assign so = tmp[7];
endmodule

