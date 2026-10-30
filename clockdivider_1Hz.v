

module clockdivider_1Hz(clock_in, clock_out);
input clock_in;
output reg clock_out=0;
reg [25:0] counter=26'd0;
always @(posedge clock_in) begin
    counter <= counter + 1;
    if (counter==26'd49999999) begin
        clock_out <= ~clock_out;
        counter <= 0;
    end
end
endmodule
