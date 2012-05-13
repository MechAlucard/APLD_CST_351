`timescale 1 ns /100 ps //timeunit = 1ns, precision = 1/10ns
module shift_in_8bit_test();
reg [7:0]     Data_A;
reg [7:0]     Data_B;
reg           CLK;
reg           Load;
wire          A;
wire          B;

//design to simulate
shift_in_8bit DUT1(
.Data_A(Data_A),
.Data_B(Data_B),
.CLK(CLK),
.Load(Load),
.A(A),
.B(B)
);

//reset and clock section
initial
	begin
	#1CLK = 0;
	Data_A = 0;
	Data_B = 0;
	Load = 0;
	end
always #20 CLK = ~CLK;//50MHz CLK

initial begin
#1 Data_A = 5;
#1 Data_B = 15;
#1 Load = 1;
#80 Load = 0;
#2000;
$finish;
end
endmodule

