module dispence(
input				reset,
input				clk,
input				gum,
input				candy,
input				cookies,
input				chips,
input				ack,
output	reg			hold,
input		[7:0]	coins,
output	reg			subtract,
output	reg			gum_dispence,
output	reg			candy_dispence,
output	reg			cookies_dispence,
output	reg			chips_dispence,
output	reg			done);
reg			[3:0]	state;
parameter			IDLE = 0,
					GUM = 1,
					CANDY = 2,
					COOKIES = 3,
					CHIPS = 4,
					SUB	= 5,
					DONE = 6,
					WAIT = 7;
initial begin
	subtract = 0;
	gum_dispence = 0;
	candy_dispence = 0;
	cookies_dispence = 0;
	chips_dispence = 0;
	done = 0;
end
always @ (posedge clk or posedge reset)
begin
	if(reset)
		state = IDLE;
	else
		case(state)
		IDLE:
		begin
			case({gum,candy,cookies,chips})
			4'b1000:state = GUM;
			4'b0100:state = CANDY;
			4'b0010:state = COOKIES;
			4'b0001:state = CHIPS;
			default: state = IDLE;
			endcase
		end
		GUM:
		begin
		if(coins >= 50)
			state = WAIT;
		else
			state = state;
		end
		CANDY:
		begin
		if(coins >= 75)
			state = WAIT;
		else
			state = state;
		end
		COOKIES:
		begin
		if(coins >= 65)
			state = WAIT;
		else
			state = state;
		end
		CHIPS:
		begin
		if(coins >= 85)
			state = WAIT;
		else
			state = state;
		end
		WAIT:
		begin
		if(ack)
			state = SUB;
		else
			state = state;
		end
		SUB:
		begin
			state = DONE;
		end
		DONE:
		begin
		state = IDLE;
		end
		default:
		begin
		state = IDLE;
		end
		endcase
end 
always @(*)
begin
	case(state)
		IDLE:
		begin
		subtract = 0;
		gum_dispence = 0;
		candy_dispence = 0;
		cookies_dispence = 0;
		chips_dispence = 0;
		done = 0;
		hold = 0;
		end
		GUM:
		begin
		subtract = 0;
		gum_dispence = 1;
		candy_dispence = 0;
		cookies_dispence = 0;
		chips_dispence = 0;
		done = 0;
		hold = 0;
		end
		CANDY:
		begin
		subtract = 0;
		gum_dispence = 0;
		candy_dispence = 1;
		cookies_dispence = 0;
		chips_dispence = 0;
		done = 0;
		hold = 0;
		end
		COOKIES:
		begin
		subtract = 0;
		gum_dispence = 0;
		candy_dispence = 0;
		cookies_dispence = 1;
		chips_dispence = 0;
		done = 0;
		hold = 0;
		end
		CHIPS:
		begin
		subtract = 0;
		gum_dispence = 0;
		candy_dispence = 0;
		cookies_dispence = 0;
		chips_dispence = 1;
		done = 0;
		hold = 0;
		end
		WAIT:
		begin
		subtract = 0;
		gum_dispence = gum_dispence;
		candy_dispence = candy_dispence;
		cookies_dispence = cookies_dispence;
		chips_dispence = chips_dispence;
		done = 0;
		hold = 1;
		end
		SUB:
		begin
		subtract = 1;
		gum_dispence = gum_dispence;
		candy_dispence = candy_dispence;
		cookies_dispence = cookies_dispence;
		chips_dispence = chips_dispence;
		done = 0;
		hold = 0;
		end
		DONE:
		begin
		subtract = 0;
		gum_dispence = 0;
		candy_dispence = 0;
		cookies_dispence = 0;
		chips_dispence = 0;
		done = 1;
		hold = 0;
		end
		default:
		begin
		subtract = 0;
		gum_dispence = 0;
		candy_dispence = 0;
		cookies_dispence = 0;
		chips_dispence = 0;
		hold = 0;
		end
		endcase
	
end
endmodule
