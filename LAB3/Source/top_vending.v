module top_vending(

(*chip_pin = "U15"*)input				dollar,
(*chip_pin = "V15"*)input				quarter,
(*chip_pin = "U14"*)input				dime,
(*chip_pin = "V14"*)input				nickel,
(*chip_pin = "U4"*)output				d_cookies,
(*chip_pin = "V4"*)output				d_candy,
(*chip_pin = "U5"*)output				d_chips,
(*chip_pin = "V5"*)output				d_gum,
(*chip_pin = "V13"*)output				c_quarter,
(*chip_pin = "U12"*)output				c_dime,
(*chip_pin = "V12"*)output				c_nickel,

(*chip_pin = "B14,B13,B12,B11,A10,B9,B8"*)output	[6:0] 		seg_out,
(*chip_pin = "B7,A5,A4"*)output	[2:0]		comm_out,
(*chip_pin = "E17"*)output 			MOSI,
(*chip_pin = "G17"*)input			MISO,
(*chip_pin = "D17"*)output			SS,
(*chip_pin = "H18"*)output			SCLK,
//(*chip_pin = "U4,V4,U5,V5,V12,U12,V13,U13"*)output	[7:0]		tetsu,
(*chip_pin = "M18"*)inout			VCC,
(*chip_pin = "K18"*)inout			GND,
(*chip_pin = "J6"*) input			clkin,
(*chip_pin="D4,C2,D1,B4"*)input [4:1] keyrow,
(*chip_pin="J3,G4,F4,E4"*)output [3:0] keycolumn);
//wire	[7:0]tetsu_w;
//assign tetsu = ~tetsu_w;
wire	[7:0]		coins_w;
wire	[5:0]		key_w;
wire				keypress_w;
wire				gum_w;
wire				candy_w;
wire				chips_w;
wire				cookies_w;
wire				scan_clk;
wire				c_quarter_w;
wire				c_dime_w;
wire				c_nickel_w;
wire				d_cookies_w;
wire				d_candy_w;
wire				d_gum_w;
wire				d_chips_w;
wire				dollar_w;
wire				quarter_w;
wire				dime_w;
wire				nickel_w;
wire				change_w;
wire				clr_pro;
wire	[3:0]		dig1_w;
wire	[3:0]		dig2_w;
wire	[3:0]		dig3_w;

assign {d_gum,d_candy,d_cookies,d_chips} = ~{d_gum_w,d_candy_w,d_cookies_w,d_chips_w};
assign {c_quarter,c_dime,c_nickel} = ~{c_quarter_w,c_dime_w,c_nickel_w};
assign {dollar_w,quarter_w,dime_w,nickel_w} = ~{dollar,quarter,dime,nickel};

vending_machine V1(
.cookies(cookies_w),
.candy(candy_w),
.chips(chips_w),
.gum(gum_w),
.clk(clkin),
.rst(change_w),
.dollar(dollar_w),
.quarter(quarter_w),
.dime(dime_w),
.nickel(nickel_w),
.d_cookies(d_cookies_w),
.d_chips(d_chips_w),
.d_gum(d_gum_w),
.d_candy(d_candy_w),
.c_quarter(c_quarter_w),
.c_dime(c_dime_w),
.c_nickel(c_nickel_w),
.done(clr_pro),
.coins(coins_w));

MUX_DISP disp(
.A(dig3_w),
.B(dig2_w),
.C(dig1_w),
.clk(scan_clk),
.com_1(comm_out[0]),
.com_2(comm_out[1]),
.com_3(comm_out[2]),
.seg_A(seg_out[0]),
.seg_B(seg_out[1]),
.seg_C(seg_out[2]),
.seg_D(seg_out[3]),
.seg_E(seg_out[4]),
.seg_F(seg_out[5]),
.seg_G(seg_out[6]));

BCD_decoder3dig dec(
.in(coins_w),
.dig1(dig1_w),
.dig2(dig2_w),
.dig3(dig3_w)
);
keypad keypad(
.clk(scan_clk),
.keyrow(keyrow),
.keycolumn(keycolumn),
.Dout(key_w),
.Data_ena(keypress_w)
);

key_sequence U3(
.key(key_w),
.keypress(keypress_w),
.clr(clr_pro),
.gum(gum_w),
.candy(candy_w),
.cookies(cookies_w),
.chips(chips_w),
.reset_out(change_w));

Clock_Divider clkdiv(
.CLK_in(clkin),
.Scan_clk(scan_clk),
.pwm_clk(),
.Baud_clk());

endmodule
