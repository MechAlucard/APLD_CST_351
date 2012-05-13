// Create Date: 05/13/2012 
// Design Name: SPI shift register
// Project Name: CST 351 – Lab 2
// Target Devices: EPM2210F324C3N
// Description: test bench for the keypad modules
 
`timescale 1 ns /100 ps
module shift_reg8_test;
reg			clk;
reg   load;
reg   si;
reg [7:0]  d;
wire  so;

shift_reg8 DUT0(
.clk(clk),
.d(d),
.so(so),
.load(load),
.si(si)
);

initial begin
  clk = 0;
  load = 0;
  si = 0;
  d = 0;
end
 always #20 clk = ~clk;
 
 initial begin
d = 5;
#10; 
load = 1;
#80
load = 0;
#400;
d = 14;
#10; 
load = 1;
#80
load = 0;
#400 $finish;
 end
 endmodule
 
