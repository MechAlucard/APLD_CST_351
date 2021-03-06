`timescale 1 ns /100 ps
module ALUcard_test;
reg			clk;
reg			GO;
reg	[2:0]	opcode;
reg	[3:0]	data;
reg			reset;
wire [3:0]	result;
wire		cout;
wire		borrow;
wire		led_idle;
wire		led_wait;
wire		led_rdy;
wire		led_done;

ALUcard_top DUT1(
.clk(clk),
.GO(GO),
.opcode(opcode),
.data(data),
.result(result),
.reset(reset),
.cout(cout),
.borrow(borrow),
.led_idle(led_idle),
.led_wait(led_wait),
.led_rdy(led_rdy),
.led_done(led_done)
);
integer i;
 initial begin
 clk = 0;
 GO = 0;
 opcode = 0;
 data = 0;
 reset = 0;
 i = 0;
 end
 always #20 clk = ~clk;
 
 initial begin
 for(i = 0; i<8;i = i +1)
 begin
	opcode = i;
	data = 4;
	#40;
	GO = 1;
	#40;
	data = 3;
	#40
	GO = 0;
	wait(led_done == 1);
	data = 6;
	#40;
	GO = 1;
	#40;
	data = 7;
	#40
	GO = 0;
	#60;
 end
 reset = 1;
 #100
 $stop;
 end
 endmodule
 