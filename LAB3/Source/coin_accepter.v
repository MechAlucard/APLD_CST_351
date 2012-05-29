module coin_accepter(
input				reset,
input				clk,
input				quarter_in,
input				dime_in,
input				nickel_in,
input				dollar_in,
output	reg			quarter_add,
output	reg			dime_add,
output	reg			nickel_add,
output	reg			dollar_add,
output	reg			done,
output	reg			add);
reg		[3:0]		state;
initial begin
	quarter_add = 0;
	dime_add = 0;
	nickel_add = 0;
	add = 0;
	state = 0;
	done = 0;
end

parameter			IDLE = 0,
					ADD25 = 1,
					ADD10 = 2,
					ADD5 = 3,
					ADD = 4,
					ADD100 = 5,
					DONE = 6;
					
always @ (posedge clk or posedge quarter_in or posedge dime_in or posedge nickel_in or posedge reset)
begin
	if(reset)
		state = IDLE;
	else
		case(state)
		IDLE:
		begin
			case({quarter_in,dime_in,nickel_in,dollar_in})
			4'b1000:state = ADD25;
			4'b0100:state = ADD10;
			4'b0010:state = ADD5;
			4'b0001:state = ADD100;
			default state = IDLE;
			endcase
		end
		ADD25:
		begin
		if(quarter_in)
			state = state;
		else
			state = ADD;
		end
		ADD10:
		begin
		if(dime_in)
			state = state;
		else
			state = ADD;
		end
		ADD5:
		begin
		if(nickel_in)
			state = state;
		else
			state = ADD;
		end
		ADD100:
		begin
		if(dollar_in)
			state = state;
		else
			state = ADD;
		end
		ADD:
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
always @ (*)
begin
	case(state)
	IDLE:
	begin
		quarter_add = 0;
		dime_add = 0;
		nickel_add = 0;
		dollar_add = 0;
		add = 0;
		done = 0;
	end
	ADD25:
	begin
		quarter_add = 1;
		dime_add = 0;
		nickel_add = 0;
		dollar_add = 0;
		add = 0;
		done = 0;
	end
	ADD10:
	begin
		quarter_add = 0;
		dime_add = 1;
		nickel_add = 0;
		dollar_add = 0;
		add = 0;
		done = 0;
	end
	ADD5:
	begin
		quarter_add = 0;
		dime_add = 0;
		nickel_add = 1;
		dollar_add = 0;
		add = 0;
		done = 0;
	end
	ADD100:
	begin
		quarter_add = 0;
		dime_add = 0;
		nickel_add = 0;
		dollar_add = 1;
		add = 0;
		done = 0;
	end
	ADD:
	begin
		quarter_add = quarter_add;
		dime_add = dime_add;
		nickel_add = nickel_add;
		dollar_add = dollar_add;
		add = 1;
		done = 0;
	end
	DONE:
	begin
		quarter_add = 0;
		dime_add = 0;
		nickel_add = 0;
		dollar_add = 0;
		add = 0;
		done = 1;
	end
	default:
	begin
		quarter_add = quarter_add;
		dime_add = dime_add;
		nickel_add = nickel_add;
		dollar_add = dollar_add;
		add = add;
		done = done;
	end
	endcase
end			
endmodule
