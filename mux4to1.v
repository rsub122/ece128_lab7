
module mux4to1(sel, bcd_in, digit);
input [1:0] sel;
input [15:0] bcd_in;
output reg [3:0] digit;

always @(*) begin
    case (sel)
        2'b00: digit = bcd_in[3:0];     
        2'b01: digit = bcd_in[7:4];     
        2'b10: digit = bcd_in[11:8];    
        2'b11: digit = bcd_in[15:12];   
        default: digit = 4'b0000;
    endcase
end

endmodule
