

module multi_digit_driver(clk, rst, bcd_in, seg_anode, seg_cathode);
input clk, rst;
input [15:0] bcd_in;
output [3:0] seg_anode;
output [6:0] seg_cathode;

wire [1:0] sel;
wire [3:0] digit;

refresh_counter   u1(.clk(clk), .rst(rst), .sel(sel));
decoder2to4       u2(.sel(sel), .anode(seg_anode));
mux4to1           u3(.sel(sel), .bcd_in(bcd_in), .digit(digit));
BCDtoSevenSegment u4(.data(digit), .seg(seg_cathode));

endmodule
