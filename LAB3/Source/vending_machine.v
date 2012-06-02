module vending_machine(
input			cookies,
input			candy,
input			chips,
input			gum,
input			clk,
input			rst,
input			dollar,
input			quarter,
input			dime,
input			nickel,
output			d_cookies,
output			d_candy,
output			d_chips,
output			d_gum,
output			c_nickel,
output			c_dime,
output			c_quarter,
output			done,
output	[7:0]	coins);
reg		[8:0]	count;
reg				ret_clk;
wire	add_w;
wire	dollar_w;
wire	quarter_w;
wire	nickel_w;
wire	dime_w;
wire	trombe;
wire			alt_esin;
wire			disp_done_w;
wire			sub_w;
wire			hold_w;
reg				ack;
reg				coin_acept;
reg				final_beam;
reg 	[1:0]	state;
parameter		COIN_ADD = 0,
				COIN_DEC = 1,
				COIN_RET = 2;
initial begin
state = 0;
final_beam = 0;
ret_clk = 0;
count = 0;
ack = 0;
coin_acept = 0;
end
assign done = disp_done_w;
always @ (posedge clk)
begin
	case(state)
	COIN_ADD:
	begin
	if(rst)
		state = COIN_RET;
	else if(hold_w)
		state = COIN_DEC;
	else
		state = state;
	end
	COIN_DEC:
	begin
	if(disp_done_w | trombe)
		state = COIN_ADD;
	else
		state = state;
	end
	COIN_RET:
	begin
	if(alt_esin)
		state = state;
	else
		state = COIN_ADD;
	end
	default:
	state = state;
	endcase
end
always @ (*)
begin
	case(state)
	COIN_ADD:
	begin
	final_beam = 0;
	ack = 0;
	coin_acept = 0;
	end
	COIN_DEC:
	begin
	final_beam = 0;
	ack = 1;
	coin_acept = 1;
	end
	COIN_RET:
	begin
	final_beam = 1;
	ack = 0;
	coin_acept = 1;
	end
	default:
	begin
	final_beam = final_beam;
	coin_acept = coin_acept;
	ack = ack;
	end
	endcase
end

always @ (posedge clk)
begin
	if(count >= 500)
	begin
	count = 0;
	ret_clk = ~ret_clk;
	end
	else
	begin
	count = count+1;
	end
end


coin_reg U0(
.reset(trombe|alt_esin),
.add(add_w|sub_w),
.gum(d_gum),
.candy(d_candy),
.cookies(d_cookies),
.chips(d_chips),
.quarter(quarter_w),
.nickel(nickel_w),
.dime(dime_w),
.dollar(dollar_w),
.coins(coins));

coin_return U1(
.coins(coins),
.clk(ret_clk),
.start(final_beam|disp_done_w),
.reset(trombe),
.active(alt_esin),
.quarter_return(c_quarter),
.dime_return(c_dime),
.nickel_return(c_nickel),
.done(trombe)
);

coin_accepter U2(
.reset(final_beam|trombe|alt_esin|coin_acept),
.clk(clk),
.quarter_in(quarter),
.dime_in(dime),
.nickel_in(nickel),
.dollar_in(dollar),
.quarter_add(quarter_w),
.nickel_add(nickel_w),
.dime_add(dime_w),
.dollar_add(dollar_w),
.done(),
.add(add_w)
);

dispence U4(
.reset(final_beam|trombe|alt_esin),
.clk(clk),
.gum(gum),
.candy(candy),
.cookies(cookies),
.chips(chips),
.coins(coins),
.subtract(sub_w),
.gum_dispence(d_gum),
.candy_dispence(d_candy),
.cookies_dispence(d_cookies),
.chips_dispence(d_chips),
.done(disp_done_w),
.ack(ack),
.hold(hold_w)
);

endmodule
