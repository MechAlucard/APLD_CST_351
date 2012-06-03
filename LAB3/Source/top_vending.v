// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 06/04/2012 
// Design Name: top_vending
// Module Name: top_vending
// Project Name: CST 351 – Lab 3
// Target Devices: EPM2210F324C3N
// Description: final top level of the vending machine
module top_vending(

(*chip_pin = "U15"*)input				dollar,
(*chip_pin = "V15"*)input				quarter,
(*chip_pin = "U14"*)input				dime,
(*chip_pin = "V14"*)input				nickel,

(*chip_pin = "U4"*)output	reg			d_cookies,
(*chip_pin = "V4"*)output	reg			d_candy,
(*chip_pin = "U5"*)output	reg			d_chips,
(*chip_pin = "V5"*)output	reg			d_gum,

(*chip_pin = "V13"*)output				c_quarter,
(*chip_pin = "U12"*)output				c_dime,
(*chip_pin = "V12"*)output				c_nickel,

/*
(*chip_pin = "K18"*)output				c_quarter,
(*chip_pin = "M18"*)output				c_dime,
(*chip_pin = "H18"*)output				c_nickel,
*/
(*chip_pin = "B14,B13,B12,B11,A10,B9,B8"*)output	[6:0] 		seg_out,
(*chip_pin = "B7,A5,A4"*)output	[2:0]		comm_out,
//(*chip_pin = "E17"*)output 			MOSI,
//(*chip_pin = "G17"*)input			MISO,
//(*chip_pin = "D17"*)output			SS,
//(*chip_pin = "H18"*)output			SCLK,
//(*chip_pin = "U4,V4,U5,V5,V12,U12,V13,U13"*)output	[7:0]		led,
//(*chip_pin = "M18"*)inout			VCC,
//(*chip_pin = "K18"*)inout			GND,
(*chip_pin = "J6"*) input			clkin,
(*chip_pin="D4,C2,D1,B4"*)input [4:1] keyrow,
(*chip_pin="J3,G4,F4,E4"*)output [3:0] keycolumn);
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
wire				clk_vend;
//assign {d_gum,d_candy,d_cookies,d_chips} = ~{gum_w,candy_w,cookies_w,chips_w};
assign {c_quarter,c_dime,c_nickel} = ~{c_quarter_w,c_dime_w,c_nickel_w};
assign {dollar_w,quarter_w,dime_w,nickel_w} = ~{dollar,quarter,dime,nickel};
//wire	[7:0] led_w;
//assign led = ~led_w;

always @ (negedge keypress_w or posedge clr_pro)
begin
	if(clr_pro)
		{d_gum,d_candy,d_cookies,d_chips} = 4'b1111;
	else
		{d_gum,d_candy,d_cookies,d_chips} = ~{gum_w,candy_w,cookies_w,chips_w};
end

vending_machine V1(
.cookies(cookies_w),
.candy(candy_w),
.chips(chips_w),
.gum(gum_w),
.clk(scan_clk),
.rst(change_w),
.dollar(dollar_w),
.quarter(quarter_w),
.dime(dime_w),
.nickel(nickel_w),
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
.Baud_clk(clk_vend));

endmodule
