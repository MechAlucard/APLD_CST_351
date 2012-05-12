// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 05/07/2012 
// Design Name: SPI
// Module Name: SPI 
// Project Name: CST 351 – Lab 2.4
// Target Devices: EPM2210F324C3N
// Description: basic SPI interface for outputing data
// sends data on the negative edge of the clock and samples on the positive edge

module SPI(
input		MISO,
output		MOSI,
output		SS,
output		SCLK,
input		clk,
input		data_ready,
output		INT,
input[7:0]	send_data
);
wire 		load_w;

shift_reg8 U0(
.d(send_data),
.so(MOSI),
.load(load_w),
.clk(clk),
.si(MISO));

SPI_State U1(
.clk(clk),
.SS(SS),
.SCLK(SCLK),
.load(load_w),
.data_ready(data_ready),
.INT(INT));


endmodule
// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 05/07/2012 
// Design Name: SPI
// Module Name: SPI_State 
// Project Name: CST 351 – Lab 2.4
// Target Devices: EPM2210F324C3N
// Description: state machine for sending serial data
// Idle provides the intial state, 
// load sets the SS and tells the shift register to load
// shifting occurs 9 times to compleatly shift out the data
// then the state machine waits for a keypress
// upon a key press data is shifted out unitl the end of dat has been reached
module SPI_State(
input		clk,
output reg	SS,
output reg	SCLK,
output reg	load,
input		data_ready,
output reg 	INT);

parameter	[1:0]	IDLE = 2'd0,
					LOAD = 2'd1,
					SHIFT= 2'd2,
					WAIT = 2'd3;
reg [1:0] 	state;
reg [3:0]	count;
always @ (posedge clk)
begin
	case(state)
	IDLE:
	begin
		count = 0;
		if(data_ready)begin state = LOAD; end
		else begin state = state; end
	end
	LOAD:
	begin 
		state = SHIFT; count = 0;
	end
	SHIFT:
	begin
		if(~count[3])begin count = count + 1; state = state; end
		else begin state = WAIT; end
	end
	WAIT:begin count = 8; state = IDLE; end
	default:begin state = IDLE; count = 0; end
	endcase
end
always @ (*)
begin
	case(state)
	IDLE:	{load,SS,INT,SCLK} = 4'b0111;
	LOAD:	{load,SS,INT,SCLK} = 4'b1001;
	SHIFT:	{load,SS,INT,SCLK} ={3'b000,clk};
	WAIT: 	{load,SS,INT,SCLK} = 4'b0001;
	default:{load,SS,INT,SCLK} = 4'b0101;
	endcase
end
endmodule
// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 05/07/2012 
// Design Name: SPI
// Module Name: shift_reg8 
// Project Name: CST 351 – Lab 2.4
// Target Devices: EPM2210F324C3N
// Description: basic 8 bit shift register with synchonus load
module shift_reg8(
input [7:0] 	d,
output reg		so,
input 			load,
				clk,
				si
);
reg [7:0]tmp;
always @(negedge clk)
	begin
		so = tmp[7];
		if (load)begin tmp = d;end
		else begin tmp = {tmp[6:0], 1'b0};end
	end
endmodule

