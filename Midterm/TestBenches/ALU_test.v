`timescale 1 ns /100 ps
module ALU_test;
reg	[2:0]	opcode;
reg	[3:0]	A;
reg [3:0] B;
wire [3:0]	result;
wire		cout;
wire		borrow;

ALU U3(
.opcode(opcode),
.A(A),
.B(B),
.result(result),
.cout(cout),
.borrow(borrow));
integer i;
 initial begin
 opcode = 0;
 A = 0;
 B = 0;
 i = 0;
 end
 
 initial begin
 for(i = 0; i<8;i = i +1)
 begin
	opcode = i;
	A = 4;
	B = 3;
	#40
	A = 6;
	B = 7;
	#40;
 end
 #100
 $stop;
 end
 endmodule
 

