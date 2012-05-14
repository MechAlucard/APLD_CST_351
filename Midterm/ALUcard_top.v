module ALUcard_top(
input	[2:0]		opcode,
input	[3:0]		data,
input				GO,
input				clk,
input				reset,
output	[3:0]		result,
output				cout,
output				borrow,
output				led_idle,
output				led_wait,
output				led_rdy,
output				led_done);
wire  [3:0] A_w;
wire  [3:0] B_w;
ALU_State U1(
.clk(clk),
.GO(GO),
.reset(reset),
.led_idle(led_idle),
.led_wait(led_wait),
.led_rdy(led_rdy),
.led_done(led_done));

Shift_in U2(
.data(data),
.load(GO),
.A(A_w),
.B(B_w));

ALU U3(
.opcode(opcode),
.A(A_w),
.B(B_w),
.result(result),
.cout(cout),
.borrow(borrow));

endmodule
module ALU_State(
input      	clk,
input			   	GO,
input		   		reset,
output	reg	 led_idle,
output	reg		led_wait,
output	reg 	led_rdy,
output	reg		led_done);
reg		[3:0]		state;
initial begin
  led_idle = 0;
  led_wait = 0;
  led_rdy = 0;
  led_done = 0;
  state = 0;
end
parameter			IDLE = 0;
parameter			LOAD = 1;
parameter			DONE = 2;
parameter			READY = 3;
always @ (posedge clk or posedge reset)
begin
	if(reset)
		state = IDLE;
	else
		case(state)
		IDLE:
		begin
			if(GO)
				state = LOAD;
			else
				state = state;
		end
		LOAD:
		begin
			state = READY;
		end
		READY:
		begin
			state = DONE;
		end
		DONE:
		begin
			if(GO)
				state = LOAD;
			else
				state = state;
		end
		default:
		begin
			state = state;
		end
		endcase
end
always @ (*)
begin
	case(state)
	IDLE:
	begin
		led_idle = 1;
		led_wait = 0;
		led_rdy = 0;
		led_done = 0;
	end
	LOAD:
	begin
		led_idle = 0;
		led_wait = 1;
		led_rdy = 0;
		led_done = 0;
	end
	DONE:
	begin
		led_idle = 0;
		led_wait = 0;
		led_rdy = 0;
		led_done = 1;
	end
	READY:
	begin
		led_idle = 0;
		led_wait = 0;
		led_rdy = 1;
		led_done = 0;
	end
	default:
	begin
		led_idle = 0;
		led_wait = 0;
		led_rdy = 0;
		led_done = 0;
	end
	endcase
end
endmodule

module Shift_in(
input	[3:0]		      data,
input				          load,
output	reg  [3:0]		A,
output	reg  [3:0]		B);
initial begin
  A = 0;
  B = 0;
end
always @ (posedge load)
begin
	A = data;
end
always @ (negedge load)
begin
	B = data;
end
endmodule

module ALU(
input	[2:0]		opcode,
input	[3:0]		A,
input	[3:0]		B,
output	reg [3:0]		result,
output	reg			cout,
output	reg		borrow);
initial begin
  result = 0;
  cout = 0;
  borrow = 0;
end
parameter			ADD = 0;
parameter			SUBTRACT = 1;
parameter			NOTa = 2;
parameter			NOTb = 3;
parameter			AND	 = 4;
parameter			OR = 5;
parameter			XOR = 6;
parameter			XNOR = 7;
always @ (*)
begin
	case(opcode)
	ADD:
	begin
		{cout,result} = A+B;
		borrow = 0;
	end
	SUBTRACT:
	begin
		{borrow,result} = A-B;
		cout = 0;
	
	end
	NOTa:
	begin
		result = ~A;
		{cout,borrow} = 0;
	end
	NOTb:
	begin
		result = ~B;
		{cout,borrow} = 0;
	end
	AND:
	begin
		result = A & B;
		{cout,borrow} = 0;
	end
	OR:
	begin
		result = A | B;
		{cout,borrow} = 0;
	end
	XOR:
	begin
		result = A ^ B;
		{cout,borrow} = 0;
	end
	XNOR:
	begin
		result = ~(A ^ B);
		{cout,borrow} = 0;
	end
	default:
	begin
		result = result;
		{cout,borrow} = {cout,borrow};
	end
	endcase
end
endmodule
