module up_counter(clk, rst, in, counter);
input clk, rst;
input in;
wire in_sync;
output reg [1:0] counter;

oneshot u1(clk, rst, in, in_sync);
always @(posedge clk or negedge rst) begin
	if(!rst)
		counter <= 2'b00;
	else
		if(in_sync)
			if(counter == 2'b11)
				counter <= 2'b00;
			else
				counter <= counter + 1;
		else
			counter <= counter;
end
endmodule
