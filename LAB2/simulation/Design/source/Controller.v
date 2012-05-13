// Oregon Institute of Technology 
// Engineer: Tyler Martin
// Create Date: 05/07/2012 
// Design Name: Controller
// Module Name: Controller 
// Project Name: CST 351 – Lab 2.5
// Target Devices: EPM2210F324C3N
// Description: creates a state machine to control the spi display
//sends data from a rom to the display then sends data on each key press
module Controller(
input				clk,
output reg			dataRdy,
input				transEna,
output reg [7:0]	data,
input 		[6:0]	address_key,
input				key_press
);
//ROM
reg[7:0] rom1 [0:77];
initial
begin
	$readmemh("ROMULAN.txt",rom1);
end

reg [3:0]		state;
reg [6:0]		address;
parameter 		s_start = 0,
				s_ready = 1,
				s_send_data = 2,
				s_next = 3,
				s_key_wait = 4;
initial begin
  dataRdy = 0;
  data = 0;
  state = 0;
  address = 0;
end
always @ (negedge clk)
begin
	case(state)
		s_start: begin state = s_send_data; address = 0; end
		s_send_data:
			begin 
			state = s_next;
			address = address;
			end
		s_next:
		begin
			if(transEna)
			begin
				if(rom1[address+1] == 0)begin state = s_key_wait; address = address; end
				else begin state = s_send_data; address = address +1; end
			end
			else begin state = state; address = address; end
		end
		s_key_wait: 
		begin 
			if(key_press)
				begin
				state = s_send_data; 
				address = address_key; 
				end
			else
				begin
				state = state;
				address = address;
				end
		end
			default:begin state = s_start; address = address; end
	endcase				
end				
always @ (*)
begin
	case(state)
	s_send_data:begin data = rom1[address]; dataRdy = 1; end
	default:begin data = rom1[address]; dataRdy = 0; end
	endcase
end

endmodule
