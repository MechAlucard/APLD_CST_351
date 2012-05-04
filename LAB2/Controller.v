module Controller(
input		clk,
output		dataRdy,
input		transEna,
output [7:0]Data,
input [7:0]	char,
input		charEna
);
//ROM
reg[7:0] rom1 [0:38];
begin
	$readmemh("ROMULAN.txt",rom1);
end

reg [3:0]		state
reg [4:0]		address

parameter 		s_start = 0,
				s_send_data = 1,
				s_next = 2;
always @ (posedge SCLK)
begin
	case(state)
	s_start: begin state = s_send_data; address = 0; end
	s_send_data:begin state = s_next; address = address;end
	s_next:begin
		if(transEna)
		begin
			if(address >= 5'd38)begin state = s_start; address = address; end
			else begin state = s_send_data; address = address +1; end
			else begin state state; address = address; end
		end
	default: state = s_start;
	endcase
end
always @ (*)
begin
	case(state)
	s_start:begin data = rom1[address]; dataRdy = 0; end
	s_send_data:begin data = rom1[address]; dataRdy = 1; end
	s_next:begin data = rom1[address]; dataRdy = 0; end
	default: data = rom1[address]; dataRdy = 0; end
	endcase
end

endmodule
