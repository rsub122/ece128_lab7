
module UpCounter(clk, rst, count);
input clk, rst;
output reg [11:0] count = 0;

always @(posedge clk or posedge rst) begin
    if (rst)
        count <= 12'd0;
    else if (count == 12'd4095)
        count <= 12'd0;
    else
        count <= count + 1'b1;
end

endmodule
