// Create Date: 05/13/2012 
// Design Name: SPI state
// Project Name: CST 351 – Lab 2
// Target Devices: EPM2210F324C3N
// Description: test bench for the SPI state machine
 
`timescale 1 ns /100 ps
module SPI_State_test;
reg			clk;
reg   data_ready;
wire  SS;
wire  SCLK;
wire  load;
wire  INT;

SPI_State DUT0(
.clk(clk),
.data_ready(data_ready),
.SS(SS),
.SCLK(SCLK),
.load(load),
.INT(INT)
);

initial begin
  clk = 0;
  data_ready = 0;
end
 always #20 clk = ~clk;
 
 initial begin
data_ready = 1;
#80;
data_ready = 0;
#800 $finish;
 end
 endmodule
 