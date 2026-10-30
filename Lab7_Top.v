

module Lab7_Top(clk, btnC, seg, an, dp, led);
input clk;
input btnC;
output [6:0] seg;
output [3:0] an;
output dp;
output [11:0] led;

wire rst;
wire clk_1Hz;
wire [11:0] count;
wire [15:0] bcd;
wire done;

assign rst = btnC;
assign dp = 1'b1;        
assign led = count;

clockdivider_1Hz   u1(.clock_in(clk), .clock_out(clk_1Hz));
UpCounter          u2(.clk(clk_1Hz), .rst(rst), .count(count));
Bin2BCD            u3(.clk(clk), .rst(rst), .bin_in(count), .bcd_out(bcd), .done(done));
multi_digit_driver u4(.clk(clk), .rst(rst), .bcd_in(bcd), .seg_anode(an), .seg_cathode(seg));

endmodule
