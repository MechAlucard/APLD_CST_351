module top_vending(
input				cookies,
input				candy,
input				chips,
input				gum,
input				clk,
input				rst,
input				dollar,
input				quarter,
input				dime,
input				nickel,
output				d_cookies,
output				d_candy,
output				d_chips,
output				d_gum,
output				c_quarter,
output				c_dime,
output				c_nickel,
output	[6:0] 		seg_out,
output	[2:0]		comm_out,
(*chip_pin = "E17"*)output 			MOSI,
(*chip_pin = "G17"*)input			MISO,
(*chip_pin = "D17"*)output			SS,
(*chip_pin = "H18"*)output			SCLK,
(*chip_pin = "M18"*)inout			VCC,
(*chip_pin = "K18"*)inout			GND,
(*chip_pin = "J6"*) input			clkin,
(*chip_pin="D4,C2,D1,B4"*)input [4:1] keyrow,
(*chip_pin="J3,G4,F4,E4"*)output [3:0] keycolumn);
wire	[7:0]		coins_w;
wire				sub_w;
wire				add_w;
wire				quarter_w;
wire				dime_w;
wire				nickel_w;
wire				reset_coin_w;
wire				return_coin_w;
wire	[5:0]		key_w
wire				keypress_w;
wire				gum_sub_w;
wire				candy_sub_w;
wire				cookies_sub_w;
wire				chips_sub_w;
wire				gum_w;
wire				candy_w;
wire				chips_w;
wire				cookies_w;
MUX_DISP(
.A(dig3_w),
.B(dig2_w),
.C(dig1_w),
.clk(),
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
wire	[3:0]	dig1_w;
wire	[3:0]	dig2_w;
wire	[3:0]	dig3_w;
BDC_decoder3dig(
.in(coins_w),
.dig1(dig1_w),
.dig2(dig2_w),
.dig3(dig3_w)
);
keypad keypad(
.clk(),
.keyrow(keyrow),
.keycolumn(keycolumn),
.Dout(key_w),
.Data_ena(keypress_w)
);

coin_reg U0(
.reset(reset_coin_w|rst),
.add(add_w),
.sub(sub_w),
.gum(gum_sub_w),
.candy(candy_sub_w),
.cookies(cookies_sub_w),
.chips(chips_sub_w),
.quarter(quarter_w),
.nickel(nickel_w),
.dime(dime_w),
.coins(coins_w)
);

coin_return U1(
.coins(coins_w),
.clk(),
.start(make_change_w),
.reset(rst),
.active(),
.done(reset_coin_w),
.quarter_return(c_quarter),
.dime_return(c_dime),
.nickel_return(c_nickel));

coin_accepter U2(
.reset(rst),
.clk()
.quarter_in(quarter),
.dime_in(dime),
.nickel_in(nickel),
.dollar_in(dollar),
.quarter_add(quarter_w),
.nickel_add(nickel_w),
.dime_add(dime_w),
.nickel_add(nickel_w),
.done(),
.add(add_w));

key_sequence U3(
.key(key_w),
.keypress(keypress_w),
.clr(rst),
.gum(gum_w),
.candy(candy_w),
.cookies(cookies_w),
.chips(chips_w),
.reset_out(make_change_w));

dispence U4(
.reset(rst),
.clk(),
.gum(gum_w),
.candy(candy_w),
.cookies(cookies_w),
.chips(chips_w),
.coins(coins_w),
.subtract(sub_w),
.gum_dispence(d_gum),
.candy_dispence(d_candy),
.cookies_dispence(d_cookies),
.chips_dispence(d_chips),
.done(make_change_w)
);
wire make_change_w;
endmodule
