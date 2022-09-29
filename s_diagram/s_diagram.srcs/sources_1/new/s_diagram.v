module s_diagram(clk, rst, in_1, in_0, out, state);
input clk, rst;
input in_1, in_0;
wire in_trig_1, in_trig_0;
output reg [1:0] state;
reg [1:0] next_state;
output reg out;
parameter  S0 = 2'b00,
			S1 = 2'b01,
			S2 = 2'b10,
			S3 = 2'b11;

oneshot U1(clk, rst, in_1, in_trig_1); // 입력버튼에 대해 원샷회로
oneshot U2(clk, rst, in_0, in_trig_0);

always @(posedge clk or negedge rst) begin // State Transition
	if(!rst) begin
		state <= S0;
	end
	else begin
		state <= next_state;
	end
end	

always @(*) begin // output과 next_state
	if(!rst) begin
		out <= 0;
		next_state <= S0;
	end
	else begin
		next_state <= state;
		case(state)
			S0 : begin
				if(in_trig_0 == 1) begin
					next_state <= S0;
					out <= 0;
				end
				else if(in_trig_1 == 1) begin
					next_state <= S1;
					out <= 0;
				end					
			end
			S1 : begin
				if(in_trig_0 == 1) begin
					next_state <= S0;
					out <= 1;
				end
				else if(in_trig_1 == 1) begin
					next_state <= S3;
					out <= 0;
				end					
			end
			S2 : begin
				if(in_trig_0 == 1) begin
					next_state <= S0;
					out <= 1;
				end
				else if(in_trig_1 == 1) begin
					next_state <= S2;
					out <= 0;
				end					
			end
			S3 : begin
				if(in_trig_0 == 1) begin
					next_state <= S0;
					out <= 1;
				end
				else if(in_trig_1 == 1) begin
					next_state <= S2;
					out <= 0;
				end					
			end
		endcase
	end
end
endmodule
