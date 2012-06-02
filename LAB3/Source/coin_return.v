module coin_return(
input		[7:0]	coins,
input				clk,
input				start,
input    			reset,
output	reg			active,
output	reg			done,
output	reg			quarter_return,
output	reg			dime_return,
output	reg			nickel_return);
reg			[7:0]	coin_count;
reg			[3:0]	state;
initial begin
	coin_count = 0;
	state = 0;
	active = 0;
	quarter_return = 0;
	dime_return = 0;
	nickel_return = 0;
	done = 0;
end
parameter			IDLE = 0,
					DEC_QUARTER = 1,
					DEC_DIME = 2,
					DEC_NICKEL = 3,
					WAIT = 4,
					DONE = 5;
always @ (posedge clk or posedge reset or posedge start)
begin
if(reset)
  state = IDLE;
else
	case(state)
		IDLE:
		begin
			coin_count = coin_count;
			if(start)
			begin
				coin_count = coins;
				state = WAIT;
			end
			else
				state = state;
		end
		WAIT:
		begin
			if(coin_count >= 25)
			begin
				state = DEC_QUARTER;
			end
			else if(coin_count >= 10)
			begin
				state = DEC_DIME;
			end
			else if(coin_count >=5)
			begin
				state = DEC_NICKEL;
			end
			else
			begin
				state = DONE;
			end
		end
		DEC_QUARTER:
		begin
			coin_count = coin_count - 25;
			state = WAIT;
		end
		DEC_DIME:
		begin
			coin_count = coin_count - 10;
			state = WAIT;
		end
		DEC_NICKEL:
		begin
			coin_count = coin_count - 5;
			state = WAIT;
		end
		DONE:
		begin
			state = IDLE;
		end
		default:
		begin
			state = IDLE;
			coin_count = 0;
		end
		endcase
end
always @ (*)
begin
	case(state)
	IDLE:
	begin
		active = 0;
		quarter_return = 0;
		dime_return = 0;
		nickel_return = 0;
		done = 0;
	end
	WAIT:
	begin
		active = 1;
		quarter_return = 0;
		dime_return = 0;
		nickel_return = 0;
		done = 0;
	end
	DEC_QUARTER:
	begin
		active = 1;
		quarter_return = 1;
		dime_return = 0;
		nickel_return = 0;
		done = 0;
	end
	DEC_DIME:
	begin
		active = 1;
		quarter_return = 0;
		dime_return = 1;
		nickel_return = 0;
		done = 0;
	end
	DEC_NICKEL:
	begin
		active = 1;
		quarter_return = 0;
		dime_return = 0;
		nickel_return = 1;
		done = 0;
	end
	DONE:
	begin
		active = 0;
		quarter_return = 0;
		dime_return = 0;
		nickel_return = 0;
		done = 1;
	end
	default:
	begin
		active = 0;
		quarter_return = 0;
		dime_return = 0;
		nickel_return = 0;
		done = 0;
	end
endcase
end

endmodule