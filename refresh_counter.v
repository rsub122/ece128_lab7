

module refresh_counter(clk, rst, sel);
input clk, rst;
output reg [1:0] sel = 0;

reg [16:0] g_count = 0;   

always @(posedge clk) begin
    if (rst) begin
        g_count <= 0;
        sel <= 0;
    end
    else if (g_count == 17'd99999) begin
        g_count <= 0;
        sel <= sel + 1;
    end
    else
        g_count <= g_count + 1;
end

endmodule
