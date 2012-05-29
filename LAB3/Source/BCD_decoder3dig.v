module BCD_decoder3dig(
input		[7:0]	in,
output		[3:0]	dig1,
output		[3:0]	dig2,
output		[3:0]	dig3);
wire 		[7:0]	tens;
wire		[7:0]	hundreds;


assign dig1 = in % 10;
assign tens = in / 10;
assign dig2 = tens % 10;
assign hundreds = in / 100;
assign dig3 = hundreds % 10;

endmodule
