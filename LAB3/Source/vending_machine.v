// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 06/04/2012 
// Design Name: vending_machine
// Module Name: vending_machine
// Project Name: CST 351 – Lab 3
// Target Devices: EPM2210F324C3N
// Description: module to control and wrap up the state machines
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
output			c_nickel,
output			c_dime,
output			c_quarter,
output	reg		done,
output	[7:0]	coins);
reg		[10:0]	count;
reg				ret_clk;
wire			add_w;
wire			dollar_w;
wire			quarter_w;
wire			nickel_w;
wire			dime_w;
wire			sub_w;
reg				accept_rst;
reg				return_rst;
reg				start_ret;
wire			hold;
reg				ack;
reg				master_rst;
wire			dec_done;
wire			ret_done;	
wire			active;	
reg		[2:0]	state;
initial begin
ret_clk = 0;
count = 0;
state = 0;
accept_rst =0;
return_rst =0;
start_ret =0;
ack = 0;
master_rst =0;
end
parameter		START = 0,
				RESET = 1,
				COIN_IN = 2,
				VEND = 3,
				CHANGE = 4,
				DONE = 5;
always @ (negedge clk)
begin
	case(state)
	START:
		state = RESET;
	RESET:
		state = COIN_IN;
	COIN_IN:
		if(rst)
			state = CHANGE;
		else if(hold)
			state = VEND;
		else
			state = state;
	VEND:
		if(dec_done)
			state = CHANGE;
		else
			state = state;
	CHANGE:
		if(ret_done)
			state = DONE;
		else
			state = state;
	DONE:
		state = START;
	default:
		state = START;
	endcase
end
always @ (*)
begin
	case(state)
	START:
	begin
	start_ret = 0;
	return_rst = 0;
	accept_rst = 0;
	ack = 0;
	master_rst = 0;
	done = 0;
	end 
	RESET:
	begin
	start_ret = 0;
	return_rst = 0;
	accept_rst = 0;
	ack = 0;
	master_rst = 1;
	done = 0;
	end
	COIN_IN:
	begin
	start_ret = 0;
	return_rst = 1;
	accept_rst = 0;
	ack = 0;
	master_rst = 0;
	done = 0;
	end
	VEND:
	begin
	start_ret = 0;
	return_rst = 0;
	accept_rst = 1;
	ack = 1;
	master_rst = 0;
	done = 0;
	end
	CHANGE:
	begin
	start_ret = 1;
	return_rst = 0;
	accept_rst = 1;
	ack = 0;
	master_rst = 0;
	done = 0;
	end
	DONE:
	begin
	start_ret = 0;
	return_rst = 0;
	accept_rst = 0;
	ack = 0;
	master_rst = 0;
	done = 1;
	end
	default:
	begin
	start_ret = 0;
	return_rst = 0;
	accept_rst = 0;
	ack = 0;
	master_rst = 0;
	done = 0;
	end
	endcase
end
always @ (posedge clk)
begin
	if(count >= 2000)
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
.reset(master_rst),
.add(add_w|sub_w),
.gum(gum),
.candy(candy),
.cookies(cookies),
.chips(chips),
.quarter(quarter_w),
.nickel(nickel_w),
.dime(dime_w),
.dollar(dollar_w),
.coins(coins));

coin_return U1(
.coins(coins),
.clk(ret_clk),
.start(start_ret),
.reset(return_rst|master_rst),
.active(active),
.quarter_return(c_quarter),
.dime_return(c_dime),
.nickel_return(c_nickel),
.done(ret_done)
);

coin_accepter U2(
.reset(accept_rst|master_rst),
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
.reset(rst|master_rst),
.clk(clk),
.gum(gum),
.candy(candy),
.cookies(cookies),
.chips(chips),
.coins(coins),
.subtract(sub_w),
.done(dec_done),
.ack(ack),
.hold(hold)
);
endmodule

