// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Keypad state machine testbench
// Project Name: CST 351 – Lab 2
// Target Devices: EPM2210F324C3N
// Description: test bench for the keypad controller
// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Keypad controller testbench
// Project Name: CST 351 – Lab 2
// Target Devices: EPM2210F324C3N
// Description: test bench for the keypad modules
 
`timescale 1 ns /100 ps
module state_test;
reg			clk;
reg   KEN;
wire  SEN;
wire  data_ena;

state DUT0(
.clk(clk),
.KEN(KEN),
.SEN(SEN),
.data_ena(data_ena));

initial begin
  clk = 0;
  KEN = 1;
end
 always #20 clk = ~clk;
 
 initial begin
#100 KEN = 0;
#80 KEN = 1;
#400 $finish;
 end
 endmodule
 
