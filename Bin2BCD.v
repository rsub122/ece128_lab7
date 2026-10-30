

module Bin2BCD(clk, rst, bin_in, bcd_out, done);
input clk, rst;
input [11:0] bin_in;
output reg [15:0] bcd_out = 0;
output reg done = 0;

parameter IDLE = 0, SHIFT = 1, ADD3 = 2, FINISH = 3;
reg [1:0] state = IDLE;

reg [11:0] bin_reg = 0;
reg [15:0] bcd_reg = 0;
reg [11:0] old_bin = 0;
reg [3:0] shift_count = 0;

always @(posedge clk) begin
    if (rst) begin
        state <= IDLE;
        bcd_out <= 0;
        old_bin <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                done <= 0;
                if (bin_in != old_bin) begin   
                    bin_reg <= bin_in;
                    old_bin <= bin_in;
                    bcd_reg <= 0;
                    shift_count <= 0;
                    state <= SHIFT;
                end
            end

            SHIFT: begin
                
                bcd_reg <= {bcd_reg[14:0], bin_reg[11]};
                bin_reg <= bin_reg << 1;
                shift_count <= shift_count + 1;
                if (shift_count == 11)
                    state <= FINISH;
                else
                    state <= ADD3;
            end

            ADD3: begin
                if (bcd_reg[3:0] > 4)
                    bcd_reg[3:0] <= bcd_reg[3:0] + 3;
                if (bcd_reg[7:4] > 4)
                    bcd_reg[7:4] <= bcd_reg[7:4] + 3;
                if (bcd_reg[11:8] > 4)
                    bcd_reg[11:8] <= bcd_reg[11:8] + 3;
                if (bcd_reg[15:12] > 4)
                    bcd_reg[15:12] <= bcd_reg[15:12] + 3;
                state <= SHIFT;
            end

            FINISH: begin
                bcd_out <= bcd_reg;
                done <= 1;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
