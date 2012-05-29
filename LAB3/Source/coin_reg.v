module coin_reg(
input				reset,
input				add,
input				sub,
input				dollar,
input				quarter,
input				dime,
input				nickel,
input				gum,
input				candy,
input				cookies,
input				chips,
output	reg	[7:0]	coins);
initial begin
coins = 0;
end
always @ (posedge reset or posedge add or posedge sub)
begin
	case({reset,add,sub})
	3'b000:coins = coins;
	3'b100:coins = 0;
	3'b010:
	begin
		case({quarter,dime,nickel,dollar})
		4'b1000:coins = coins + 25;
		4'b0100:coins = coins + 10;
		4'b0010:coins = coins + 5;
		4'b0001:coins = coins + 100;
		default:coins = coins;
		endcase
	end
	3'b001:
	begin
		case({candy,cookies,chips,gum})
		4'b1000:coins = coins - 75;
		4'b0100:coins = coins - 65;
		4'b0010:coins = coins - 85;
		4'b0001:coins = coins - 50;
		default:coins = coins;
		endcase
	end
	default:coins = 0;
	endcase
end
endmodule
