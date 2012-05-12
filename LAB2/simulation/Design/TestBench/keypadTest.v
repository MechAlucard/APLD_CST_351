`timescale 1 ns /100 ps
module keypadTest;
reg			clk;
reg [3:0]	keyrow;
wire [3:0]	keycolumn;
wire [5:0]	Dout;
wire		Data_ena;

keypad DUT2(
.clk(clk),
.keyrow(keyrow),
.keycolumn(keycolumn),
.Dout(Dout),
.Data_ena(Data_ena));
 initial begin
 clk = 0;
 keyrow = 0;
 end
 always #20 clk = ~clk;
 
 initial begin
 #1000
#200 keyrow = 4'b1000;
#200 keyrow = 4'b0000;
#200 keyrow = 4'b0010;
#200 keyrow = 4'b0000;
#200 keyrow = 4'b0010;
#200 keyrow = 4'b0000;
#200 keyrow = 4'b0001;
#5 $finish;
 end
 endmodule
 