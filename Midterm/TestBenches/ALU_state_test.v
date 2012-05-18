`timescale 1 ns /100 ps
module ALU_state_test;
reg			clk;
reg			GO;
reg			reset;
wire		led_idle;
wire		led_wait;
wire		led_rdy;
wire		led_done;

ALU_State U1(
.clk(clk),
.GO(GO),
.reset(reset),
.led_idle(led_idle),
.led_wait(led_wait),
.led_rdy(led_rdy),
.led_done(led_done));

 initial begin
 clk = 0;
 GO = 0;
 reset = 0;
 end
 always #20 clk = ~clk;
 
 initial begin
 #40;
 GO = 1;
 #40;
 GO = 0;
 #300;
 reset = 1;
 #100
 reset = 0;
 $stop;
 end
 endmodule