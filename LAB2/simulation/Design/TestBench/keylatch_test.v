// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Keypad latch testbench
// Project Name: CST 351 – Lab 2
// Target Devices: EPM2210F324C3N
// Description: test bench for the keypad modules
 
`timescale 1 ns /100 ps
module keylatch_test;
reg			clk;
reg [3:0]	row;
reg [1:0]	column;
wire [5:0]	key;
reg  SEN;

keylatch DUT0(
.clk(clk),
.row(row),
.column(column),
.key(key),
.SEN(SEN));

integer i;
integer j;

 initial begin
 clk = 0;
 row = 0;
 column = 0;
 SEN = 0;
 i = 0;
 j = 0;
 end
 always #20 clk = ~clk;
 
 initial begin
for(i=0;i<4;i=i+1)
  for(j=0;j<=15;j=j+1)
    begin
      SEN = 1;
      #40;
      row = j;
      column = i;
      #20;
      SEN = 0;
      #40;
    end
#5 $finish;
 end
 endmodule
 
