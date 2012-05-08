// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Keypad controller
// Module Name: keypad 
// Project Name: CST 351 – Lab 2
// Target Devices: EPM2210F324C3N
// Description: Top level module that uses the keypad to enter in data
 

//(*chip_pin="J6"*)input clkin,
//(*chip_pin="D4,C2,D1,B4"*)input [4:1] keyrow,
//(*chip_pin="J3,G4,F4,E4"*)output [3:0] keycolumn

module keypad(
input clk,
input [3:0] keyrow,
output [3:0] keycolumn,
output [3:0] Dout,
output Data_ena);
wire KEN,SEN;
wire [2:0] count;
wire [5:0] key;

Key_read u1(
.row(keyrow),
.clk(clk),
.KEN(KEN),
.count(count),
.column(keycolumn));

state u2(
.clk(clk),
.KEN(KEN),
.SEN(SEN),
.data_ena(Data_ena));

keylatch u3(
.column(count),
.row(keyrow),
.clk(clk),
.key(key),
.SEN(SEN));

keycode u4(
.key(key),
.out(Dout));

endmodule
// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: State Machine
// Module Name: state 
// Project Name: CST 351 – Lab 1
// Target Devices: EPM2210F324C3N
// Description: creates a state machine with control for when
// to latch the data from the keypad
module state(
input clk,KEN,
output reg SEN,data_ena);
reg [1:0] state,nstate;
parameter start=2'b00,read=2'b01,hold=2'b10,send=2'b11;
always @ (posedge clk)
begin
	state = nstate;
end
always @ (*)
case(state)
	start:begin
		{SEN,data_ena}=2'b00;
		if(KEN)
			nstate = start;
		else
			nstate = read;
		end
	read:begin
		{SEN,data_ena}=2'b10;
		nstate = hold;
		end
	hold:begin
		{SEN,data_ena}=2'b00;
		if(KEN)
			nstate = send;
		else
			nstate = hold;
		end
	send:begin
		{SEN,data_ena}=2'b01;
		nstate = start;
		end
	default:begin
		{SEN,data_ena}=2'b00;
		nstate = start;
		end
endcase

endmodule
// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Keypad Latch
// Module Name: keylatch
// Project Name: CST 351 – Lab 1
// Target Devices: EPM2210F324C3N
// Description: latches the keypads outputs
module keylatch(
input [1:0] column,
input [3:0] row,
input clk,SEN,
output reg [5:0] key);
always @ (posedge clk)
begin
if(SEN)
	key = {column,row};
else
	key=key;
end
endmodule

// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Keyencoder
// Module Name: keycode
// Project Name: CST 351 – Lab 1
// Target Devices: EPM2210F324C3N
// Description: translates keycodes to a number
module keycode(
input [5:0]key,
output reg [3:0]out);
always @ (key)
begin
	case(key)
	6'b000111:out=4'd1;
	6'b001011:out=4'd2;
	6'b001101:out=4'd3;
	6'b001110:out=4'd10;
	6'b010111:out=4'd4; 
	6'b011011:out=4'd5;
	6'b011101:out=4'd6;
	6'b011110:out=4'd11;
	6'b100111:out=4'd7;
	6'b101011:out=4'd8;
	6'b101101:out=4'd9;
	6'b101110:out=4'd12;
	6'b110111:out=4'd15;
	6'b111011:out=4'd0;
	6'b111101:out=4'd13;
	6'b111110:out=4'd14;
	default:out=4'd15;//clear	
	endcase
end
endmodule
// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Key read
// Module Name: Key_read
// Project Name: CST 351 – Lab 1
// Target Devices: EPM2210F324C3N
// Description: reads a key on lockout and outputs it
module Key_read(
input [3:0] row,
input clk,
output KEN,
output reg [1:0]count,
output reg [3:0]column);

assign KEN = &row;
always @ (posedge clk )//or posedge KEN)
begin
	if(KEN)
		begin
			count = count+1'b1;
		end
	else
		count = count;
end
always @ (count)
begin
	case(count)
		2'b00:column=4'b0111;
		2'b01:column=4'b1011;
		2'b10:column=4'b1101;
		2'b11:column=4'b1110;
		default:column=column;
	endcase
end

endmodule


endmodule

// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Frequency divider
// Module Name: f_div
// Project Name: CST 351 – Lab 1
// Target Devices: EPM2210F324C3N
// Description: divides the frequency
module f_divider(
input in,
output reg out);
reg [15:0]count;

always @ (posedge in)
begin
	count <= count + 1;
	if(count >= 50000)
		begin
		count <= 0;
		out <= ~out;
		end
	else
		begin
		out <= out;
		end
end

endmodule

