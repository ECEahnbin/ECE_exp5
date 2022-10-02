module updown(clk, rst, in, counter);
input clk, rst, in;
wire in_sync;
output reg [2:0] counter;
reg STATE; // 0 : UP_STATE, 1 : DOWN_STATE

oneshot u1(clk, rst, in ,in_sync); // oneshot
always @(posedge clk or negedge rst) begin // state에 따른 실행
    if(!rst)
        counter <= 0;
    else begin
    	if(STATE == 0) begin// UP_STATE
    		if(in_sync == 1)
    			counter <= counter + 1;
    		else
    			counter <= counter;
    	end
    	else begin// DOWN_STATE
    		if(in_sync == 1)
    			counter <= counter - 1;
    		else
    			counter <= counter;
    	end
    end
end

always @(*) begin // STATE 결정
	if(!rst)
		STATE <= 0;
	else begin
		STATE <= STATE;
		if(counter == 3'b111)
			STATE <= 1;
		else if(counter == 3'b000)
			STATE <= 0;
	end
end

endmodule
