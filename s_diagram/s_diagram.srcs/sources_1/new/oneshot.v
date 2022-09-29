module oneshot(clk, rst, in, in_trig);
input clk, rst;
input in;
output reg in_trig;
reg in_reg;
always @(posedge clk or negedge rst)
begin
    if(!rst) begin
        in_reg <= 1'b0;
        in_trig <= 1'b0;
    end
    else begin
        in_reg <= in;
        in_trig <= in & ~in_reg;
    end
end
endmodule
