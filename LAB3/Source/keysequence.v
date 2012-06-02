module key_sequence(
input	[5:0]			key,
input				keypress,
input				clr,
output	reg			gum,
output	reg			candy,
output	reg			cookies,
output	reg			chips,
output	reg			reset_out);
reg			[3:0]	key1;
reg			[3:0]	key2;
reg			[2:0]	state;
parameter			IDLE = 0,
					FIRST = 1,
					//SECOND = 2,
					END = 3,
					CLEAR = 4;
initial begin
	gum = 0;
	candy=0;
	chips = 0;
	cookies = 0;
	reset_out = 0;
	key1 = 0;
	key2=0;
	state = 0;
end	
always @ (posedge keypress or posedge clr)
begin
	if(clr)
	begin
		state = IDLE;
		key1 = 0;
		key2 = 0;
	end
	else
	case(state)
	IDLE:
	begin
		case(key)
		6'b000111:
		begin
		state = FIRST;
		key1 = 1;
		end
		6'b001101:
		begin
		state = FIRST;
		key1 =  3;
		end
		6'b011011:
		begin
		state = FIRST;
		key1 = 5;
		end
		6'b100111:
		begin
		state = FIRST;
		key1 = 7;
		end
		6'b110111:
		begin
		state = CLEAR;
		key1 = 0;
		end
		default:
		begin
		state = state;
		end
		endcase
	end
	FIRST:
	begin
		case(key)
		6'b001011:
		begin
			if(key1 == 1)
			begin
				key2 = 2;
				state = END;
			end
			else
			begin
				key2 = key2;
				state = IDLE;
			end
		end
		6'b010111:
		begin
			if(key1 == 3)
			begin
				key2 = 4;
				state = END;
			end
			else
			begin
				key2 = key2;
				state = IDLE;
			end
		end
		6'b011101:
		begin
			if(key1 == 5)
			begin
				key2 = 6;
				state = END;
			end
			else
			begin
				key2 = key2;
				state = IDLE;
			end
		end
		6'b101011:
		begin
			if(key1 == 7)
			begin
				key2 = 8;
				state = END;
			end
			else
			begin
				key2 = key2;
				state = IDLE;
			end
		end
		6'b110111:
		begin
			state = CLEAR;
			key1 = 0;
		end
		default:
		begin
			key2 = key2;
			state = state;
		end
		endcase
	end
//	SECOND:
//	begin
//	end
	END:
	begin
	case(key)
		6'b000111:
		begin
		state = FIRST;
		key1 = 1;
		end
		6'b001101:
		begin
		state = FIRST;
		key1 =  3;
		end
		6'b011011:
		begin
		state = FIRST;
		key1 = 5;
		end
		6'b100111:
		begin
		state = FIRST;
		key1 = 7;
		end
		6'b110111:
		begin
		state = CLEAR;
		key1 = key1;
		end
		default:
		begin
		state = state;
		end
		endcase
	end
	CLEAR:
	begin
		case(key)
		6'b000111:
		begin
		state = FIRST;
		key1 = 1;
		end
		6'b001101:
		begin
		state = FIRST;
		key1 =  3;
		end
		6'b011011:
		begin
		state = FIRST;
		key1 = 5;
		end
		6'b100111:
		begin
		state = FIRST;
		key1 = 7;
		end
		6'b110111:
		begin
		state = CLEAR;
		key1 = key1;
		end
		default:
		begin
		state = state;
		end
		endcase
	end
	default:
	begin
	end
	endcase
end
always @ (*)
begin
case(state)
	IDLE:
	begin
		candy = 0;
		cookies = 0;
		chips = 0;
		gum = 0;
		reset_out = 0;
	end
	FIRST:
	begin
		candy = 0;
		cookies = 0;
		chips = 0;
		gum = 0;
		reset_out = 0;
	end
	END:
	begin
		case({key1,key2})
		8'b00010010:
		begin
		candy = 1;
		cookies = 0;
		chips = 0;
		gum = 0;
		reset_out = 0;
		end
		8'b00110100:
		begin
		candy = 0;
		cookies = 0;
		chips = 1;
		gum = 0;
		reset_out = 0;
		end
		8'b01010110:
		begin
		candy = 0;
		cookies = 0;
		chips = 0;
		gum = 1;
		reset_out = 0;
		end
		8'b01111000:
		begin
		candy = 0;
		cookies = 1;
		chips = 0;
		gum = 0;
		reset_out = 0;
		end
		default
		begin
		candy = 0;
		cookies = 0;
		chips = 0;
		gum = 0;
		reset_out = 0;
		end
		endcase
	end
	CLEAR:
	begin
		candy = 0;
		cookies = 0;
		chips = 0;
		gum = 0;
		reset_out = 1;
	end
	default:
	begin
		candy = 0;
		cookies = 0;
		chips = 0;
		gum = 0;
		reset_out = 0;
	end
	endcase
end

endmodule
