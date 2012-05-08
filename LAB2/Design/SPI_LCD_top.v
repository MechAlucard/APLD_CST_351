module SPI_LCD_top(
(*chip_pin = "E17"*)output 			MOSI,
(*chip_pin = "G17"*)input			MISO,
(*chip_pin = "D17"*)output			SS,
(*chip_pin = "H18"*)output			SCLK,
(*chip_pin = "M18"*)inout			VCC,
(*chip_pin = "K18"*)inout			GND,
(*chip_pin = "J6"*) input			clkin
);
wire 			w_clk_1K;
wire[7:0] 		w_data;
wire			w_data_ready;
wire			w_send;
assign {VCC,GND} = 2'b10;

SPI spi(
.MISO(MISO),
.MOSI(MOSI),
.SS(SS),
.SCLK(SCLK),
.clk(w_clk_1K),
.data_ready(w_send),
.send_data(w_data),
.INT(w_data_ready));

Controller control(
.clk(w_clk_1K),
.dataRdy(w_send),
.transEna(w_data_ready),
.data(w_data)
);

ClockDivider divy(
.CLK(clkin),
.CLK_1K(w_clk_1K));

endmodule
