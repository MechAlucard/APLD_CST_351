// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Keypad key read test bench
// Project Name: CST 351 – Lab 2
// Target Devices: EPM2210F324C3N
// Description: test bench for the keypad key reading module
`timescale 1 ns /100 ps
module Key_read_Test;
reg			clk;
reg [3:0]	row;
wire [3:0]	column;
wire  KEN;
wire [1:0]  count;
integer i;
Key_read DUT0(
.row(row),
.clk(clk),
.column(column),
.KEN(KEN),
.count(count));
initial begin
  row = 0;
  clk = 0;
  i = 0;
end
always #20 clk = ~clk;
initial begin
    for(i = 0; i<=16; i = i +1)
    begin
      #80 row = 4'b1111;
      #80 row = i;
    end
      $finish;
end
endmodule
