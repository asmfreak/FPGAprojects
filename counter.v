/// Модуль счётчика
module count #(
    // Ширина счётчика в битах
    parameter       COUNTER_SIZE            = 32
) (
    input   wire                      clk,
    input   wire                      reset_n,
    input   wire                      enable,
    input   wire [COUNTER_SIZE-1 : 0] match_value,
    
    output  wire [COUNTER_SIZE-1 : 0] count,
    output  wire                      match_occured,
    output  wire                      overflow
);
reg [COUNTER_SIZE-1 : 0] val;
always @ ( posedge clk ) begin
    if (!reset_n) begin
        val<=0;
    end else if (enable) begin
        val <= val + 1;
    end
end

initial begin
    val = 0;
end
assign count = val;
assign overflow = (val == 0);
assign match_occured = (val == match_value);


endmodule


