module Serial_Adder_top(
input [7:0]		Data_A,
input [7:0]		Data_B,
input			CLK,
input			Start,
output [7:0]	Sum,
output			Cout,
output			Done
);
wire			a_w;
wire			b_w;
wire			sum_w;
wire			load_w;
shift_in_8bit U1(
.Data_A(Data_A),
.Data_B(Data_B),
.CLK(CLK_w),
.Load(load_w),
.A(a_w),
.B(b_w));

serial_adder U2(
.a(a_w),
.b(b_w),
.CLK(CLK_w),
.Sum(sum_w),
.c_out(Cout),
.CLR(Start));

shift_reg_8bit U3(
.S_in(sum_w),
.CLK(CLK_w),
.Data_out(Sum),
.CLR(Start));

control U4(
.CLK(CLK),
.Start(Start),
.Done(Done),
.CLK_out(CLK_w),
.Load(load_w));
endmodule
module control(
input 			CLK,
input			Start,
output	reg		Done,
output	reg 	CLK_out,
output	reg		Load
);
reg	[3:0]		count;
reg [2:0]		state;
initial begin
state = 0;
count = 0;
Done = 0;
Load = 0;
CLK_out = 0;
end
parameter 		Idle = 0,
				Loading = 1,
				Shifting = 2;
always @ (posedge CLK)
begin
	case(state)
	Idle:
	begin
		if(Start)
			state = Loading;
		else
			state = state;
		count = 0;
	end
	Loading:
	begin
		state = Shifting;
	end
	Shifting:
		if(count < 8)
		begin
			count = count +1;
			state = state;
		end
		else
		begin
			count = count;
			state = Idle;
		end
	default: state = Idle;
	endcase
end
always @ (*)
begin
	case(state)
	Idle:{CLK_out,Done,Load} = 3'b010;
	Loading:{CLK_out,Done,Load} = 3'b001;
	Shifting:{CLK_out,Done,Load} = {CLK,2'b00};
	default:{CLK_out,Done,Load} = 3'b010;
	endcase
end
endmodule
module serial_adder(
input			a,
input			b,
input			CLK,
input   CLR,
output reg		Sum,
output reg		c_out
);
reg				c_in;
initial begin
c_in = 0;
c_out = 0;
Sum = 0;
end
always @ (negedge CLK or posedge CLR)
begin
  if(CLR)
      {c_out,Sum} = 0;
  else
  begin
	{c_out,Sum} = a + b + c_in;
	c_in =c_out;
	end
end
endmodule


module shift_reg_8bit(
input	       		S_in,
input          		CLK,
input           CLR,
output reg [7:0]    Data_out
);
initial begin Data_out = 0; end
always @ (negedge CLK or posedge CLR)
begin
  if(CLR)
    Data_out = 0;
  Data_out = {S_in,Data_out[7:1]};
end  
endmodule

module shift_in_8bit(
input [7:0]		Data_A,
input [7:0]		Data_B,
input			CLK,
input			Load,
output 		A,
output 		B
);
reg [7:0]		Data_A_reg;
reg	[7:0]		Data_B_reg;
initial begin  
Data_A_reg = 0;
Data_B_reg = 0;
end

always @ (negedge CLK or posedge Load)
begin
	if(Load)
	begin
		{Data_A_reg,Data_B_reg} = {Data_A,Data_B};
	end
	else
	begin
		{Data_A_reg,Data_B_reg} = {1'b0,Data_A_reg[7:1],1'b0,Data_B_reg[7:1]};
	end
end
assign {A,B} = {Data_A_reg[0],Data_B_reg[0]};
endmodule 
