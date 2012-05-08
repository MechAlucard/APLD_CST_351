// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 05/07/2012 
// Design Name: Controller
// Module Name: Controller 
// Project Name: CST 351 � Lab 2.5
// Target Devices: EPM2210F324C3N
// Description: creates a state machine to control the spi display
//sends data from a rom to the display then sends data on each key press
module Controller(
input				clk,
output reg			dataRdy,
input				transEna,
output reg [7:0]	data
);
//ROM
reg[7:0] rom1 [0:36];
initial
begin
	$readmemh("ROMULAN.txt",rom1);
end

reg [3:0]		state;
reg [5:0]		address;

parameter 		s_start = 0,
				s_send_data = 1,
				s_next = 2,
				s_end = 3;
				
always @ (negedge clk)
begin
	case(state)
	s_start: begin state = s_send_data; address = 0; end
	s_send_data:begin state = s_next; address = address;end
	s_next:
	begin
		if(transEna)
		begin
			if(address == 6'd37)begin state = s_end; address = address; end
			else begin state = s_send_data; address = address +1; end
		end
		else begin state = state; address = address; end
	end
	s_end: begin state = state; address = address; end
	default: state = s_start;
	endcase
end
always @ (*)
begin
	case(state)
	s_start:begin data = rom1[address]; dataRdy = 0; end
	s_send_data:begin data = rom1[address]; dataRdy = 1; end
	s_next:begin data = rom1[address]; dataRdy = 0; end
	s_end:begin	data = rom1[address]; dataRdy = 0; end
	default:begin data = rom1[address]; dataRdy = 0; end
	endcase
end

endmodule
