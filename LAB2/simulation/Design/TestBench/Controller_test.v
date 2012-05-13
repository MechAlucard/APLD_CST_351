// Create Date: 05/13/2012 
// Design Name: SPI controller
// Project Name: CST 351 – Lab 2
// Target Devices: EPM2210F324C3N
// Description: test bench for the SPI controller
 
`timescale 1 ns /100 ps
module Controller_test;
reg			clk;
reg   transEna;
reg  [7:0] address_key;
reg   key_press;
wire  [7:0] data;
wire  dataRdy;

Controller DUT0(
.clk(clk),
.transEna(transEna),
.address_key(address_key),
.key_press(key_press),
.data(data),
.dataRdy(dataRdy)
);

initial begin
  clk = 0;
  transEna = 0;
  address_key = 0;
  key_press = 0;
end
 always #20 clk = ~clk;
 
 initial begin
address_key = 8;
 #80 transEna = 1;
 #80 transEna = 0;
 #200 key_press = 1;
 #80 key_press = 0;
 #400 transEna = 1;
 #80  transEna = 0;
#400 $finish;
 end
 endmodule
 