module SPI_LCD_top(
(*chip_pin = "E17"*)output 			MOSI,
(*chip_pin = "G17"*)input			MISO,
(*chip_pin = "D17"*)output			SS,
(*chip_pin = "H18"*)output			SCLK,
(*chip_pin = "M18"*)inout			VCC,
(*chip_pin = "K18"*)inout			GND,
(*chip_pin = "J6"*) input			clkin,
(*chip_pin="D4,C2,D1,B4"*)input [4:1] keyrow,
(*chip_pin="J3,G4,F4,E4"*)output [3:0] keycolumn

);
wire 			w_clk_1K;
wire			w_press;
wire[7:0] 		w_data;
wire			w_data_ready;
wire			w_send;
wire [5:0]		key;
reg	[6:0]		address;

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
.data(w_data),
.key_press(w_press),
.address_key(address)
);

keypad Keyboard(
.clk(w_clk_1K),
.keyrow(keyrow),
.keycolumn(keycolumn),
.Dout(key),
.Data_ena(w_press)
);

ClockDivider divy(
.CLK(clkin),
.CLK_1K(w_clk_1K));

always @ (posedge w_press)
begin
	case(key)
	6'b000111:begin address =38; end//1
	6'b001011:begin address =40; end//2
	6'b001101:begin address =42; end//3
	6'b001110:begin address =65; end//up
	6'b010111:begin address =44; end//4
	6'b011011:begin address =46; end//5
	6'b011101:begin address =48; end//6
	6'b011110:begin address =68; end//down
	6'b100111:begin address =50; end//7
	6'b101011:begin address =52; end//8
	6'b101101:begin address =54; end//9
	6'b101110:begin address =61; end//2nd
	6'b110111:begin address =0; end//clear
	6'b111011:begin address =36; end//0
	6'b111101:begin address =56; end//help
	6'b111110:begin address =73; end//enter
	default:begin address = 56; end
	endcase
end

endmodule

