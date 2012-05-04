module SPI(
input		MISO,
output		MOSI,
output		SS,
output		SCLK,
input		clk,
input		send,
output		data_ready
input[7:0]	send_data);
wire 		load_w;
wire		clock_w;

shift_reg8 U0(
.d(send_data),
.out(),
.so(MOSI),
.load(load_w),
.clk(clock_w),
.si(MISO));

SPI_State(
.clk(clk),
.send(send),
.SS(SS),
.SCLK(clock_w),
.load(load_w),
.data_ready(data_ready));


endmodule

module SPI_State(
input		clk,
input		send,
output reg	SS,
output reg	SCLK,
output reg	load,
output reg	data_ready);

parameter	[1:0]	IDLE = 2'd0,
					LOAD = 2'd1,
					SHIFT = 2'd2,
					WAIT = 2'd3;
reg [1:0] 	state;
reg [3:0]	count;
always @ (posedge clk)
begin
	case(state)
	IDLE:
	begin
		if(send && data_ready)
			state = LOAD;
		else
			state = IDLE;
	end
	LOAD:
	begin
		state = SHIFT;
		count = 8;
	end
	SHIFT:
	begin
		if(count >0)
		begin
			count = count - 1;
			state = SHIFT;
		end
		else
			state = WAIT;
	end
	WAIT:
	begin
		state = IDLE;
	end
	default:state = IDLE;
	endcase
end
always @ (*)
begin
	case(state)
	IDLE:{load,SS,data_ready,SCLK} = 4'b0111;
	LOAD:{load,SS,data_ready,SCLK} = 4'b1001;
	SHIFT:{load,SS,data_ready,SCLK} = {3'b010,clk};
	WAIT: {load,SS,data_ready,SCLK} = 4'b0001;
	default:{load,SS,data_ready,SCLK} = {load,CS,data_ready,1'b1};
	endcase
end
endmodule

module shift_reg8(
input [7:0] 	d,
output reg[7:0] out,
output 			so,
input 			load,
				clk,
				si
);
reg [7:0]tmp;
always @(negedge clk)
	begin
	   if (load)
		begin
            tmp <= d;
        end
	   else
	      tmp <= {tmp[6:0], si};
	end
	   assign so = tmp[7];
endmodule

