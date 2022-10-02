module vending(clk, rst, in_A, in_B, in_C, out, STATE);
input clk, rst;
input in_A, in_B, in_C;
output reg out;
output reg [2:0] STATE;
reg [2:0] NEXT_STATE;
wire A, B, C; // 원샷회로의 결과
parameter  S0 = 3'b000,
			S50 = 3'b001,
			S100 = 3'b010,
			S150 = 3'b011,
			S200 = 3'b100;

oneshot U1(clk, rst, in_A, A);
oneshot U2(clk, rst, in_B, B);
oneshot U3(clk, rst, in_C, C);

always @(posedge clk or negedge rst) begin // 상태천이 회로
    if(!rst)
        STATE <= S0;
    else
        STATE <= NEXT_STATE; 
end

always  @(*) begin
    if(!rst)
        NEXT_STATE <= S0;
    else
    	NEXT_STATE <= STATE;
    	out <= 0;
    	case(STATE)
    		S0 : begin
    			if(A == 1) NEXT_STATE <= S50;
    			else if(B == 1) NEXT_STATE <= S100;
    		end
    		S50 : begin
    			if(A == 1) NEXT_STATE <= S100;
    			else if(B == 1) NEXT_STATE <= S150;
    		end
    		S100 : begin
    			if(A == 1) NEXT_STATE <= S150;
    			else if(B == 1) NEXT_STATE <= S200;
    		end
    		S150 : begin
    			if(A == 1) NEXT_STATE <= S200;
    			else if(B == 1) NEXT_STATE <= S200;
    		end
    		default : begin
    			if(C == 1) begin
    				NEXT_STATE <= S0;
    				out <= 1;
    			end
    		end
    	endcase
end
endmodule
