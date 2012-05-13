`timescale 1 ns /100 ps
module serial_adder_top_test;
reg			CLK;
reg	[7:0]	Data_A;
reg [7:0]	Data_B;
reg			Start;
wire [7:0]	Sum;
wire		Cout;
wire		Done;

Serial_Adder_top DUT1(
.CLK(CLK),
.Data_A(Data_A),
.Data_B(Data_B),
.Start(Start),
.Sum(Sum),
.Cout(Cout),
.Done(Done)
);
 initial begin
 CLK = 0;
 Data_A = 0;
 Data_B = 0;
 Start = 0;
 end
 always #20 CLK = ~CLK;
 
 initial begin
 Data_A = 5;
 Data_B = 4;
 #40
 Start = 1;
 wait(Done == 0)
 Start = 0;
 wait(Done == 1)
 #40
 Data_A = 15;
 Data_B = 18;
 Start = 1;
 wait(Done == 0)
 Start = 0;
 wait(Done == 1)
 #40
 Data_A = 12;
 Data_B = 4;
 #40
 Start = 1;
 wait(Done == 0)
 Start = 0;
 wait(Done == 1)
 
#200 $finish;
 end
 endmodule
 