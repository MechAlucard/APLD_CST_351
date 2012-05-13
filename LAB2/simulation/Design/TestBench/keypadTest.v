// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 04/17/2012 
// Design Name: Keypad controller testbench
// Project Name: CST 351 – Lab 2
// Target Devices: EPM2210F324C3N
// Description: test bench for the keypad modules
 
`timescale 1 ns /100 ps
module keypadTest;
reg			clk;
reg [3:0]	keyrow;
wire [3:0]	keycolumn;
wire [5:0]	Dout;
wire		Data_ena;
wire  KEN;
wire  SEN;
wire [1:0]  count;

keypad DUT0(
.clk(clk),
.keyrow(keyrow),
.keycolumn(keycolumn),
.Dout(Dout),
.Data_ena(Data_ena));

Key_read DUT1(
.row(keyrow),
.clk(clk),
.KEN(KEN),
.count(count),
.column(keycolumn));

state DUT2(
.clk(clk),
.KEN(KEN),
.SEN(SEN),
.data_ena(Data_ena));

keylatch DUT3(
.column(count),
.row(keyrow),
.clk(clk),
.key(Dout),
.SEN(SEN));
 initial begin
 clk = 0;
 keyrow = 0;
 end
 always #20 clk = ~clk;
 
 initial begin
#200 keyrow = 4'b1111;
#200 keyrow = 4'b1110;
#200 keyrow = 4'b1111;
#200 keyrow = 4'b1011;
#200 keyrow = 4'b1111;
#200 keyrow = 4'b1101;
#200 keyrow = 4'b1111;
#5 $finish;
 end
 endmodule
 