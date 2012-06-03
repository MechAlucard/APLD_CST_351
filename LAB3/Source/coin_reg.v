// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 06/04/2012 
// Design Name: Coin_reg
// Module Name: coin_reg
// Project Name: CST 351 – Lab 3
// Target Devices: EPM2210F324C3N
// Description: adds and subtracts coin and product values from the reg
module coin_reg(
input				reset,
input				add,
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
always @ (posedge reset or posedge add)
begin
	if(reset)
	begin
		coins = 0;
	end
	
	else if(add)
	begin
		casex({candy,cookies,chips,gum,quarter,dime,nickel,dollar})
		8'b10000000:coins = coins - 75;
		8'b01000000:coins = coins - 65;
		8'b00100000:coins = coins - 85;
		8'b00010000:coins = coins - 50;
		8'bxxxx1000:coins = coins + 25;
		8'bxxxx0100:coins = coins + 10;
		8'bxxxx0010:coins = coins + 5;
		8'bxxxx0001:coins = coins + 100;
		default:coins = coins;
		endcase
	end
end
endmodule
