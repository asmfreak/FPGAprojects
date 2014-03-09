/// Модуль счётчика
module count #(
    // Ширина счётчика в битах
    parameter       COUNTER_SIZE            = 32,
    parameter       MAX                     = 32'b1111_1111_1111_1111_1111_1111_1111_1111
) (
    input   wire                      clk,
    input   wire                      reset_n,
    input   wire                      enable,
    input   wire [1:0]                counterMode,
    input   wire [COUNTER_SIZE-1 : 0] match_value,
    
    output  wire [COUNTER_SIZE-1 : 0] count,
    output  wire                      match_occured,
    output  wire                      overflow
);
wire dir;
assign dir = counterMode[0];
//0 - считаем в плюс
//1 - считаем в минус
wire ovfMode;
assign ovfMode = counterMode[1];
//0 - считаем от/до MAX
//1 - считаем от/до match_value

reg [COUNTER_SIZE-1 : 0] val;
always @ ( posedge clk or negedge reset_n) begin
    $display("val = %x",val);
    if (!reset_n) begin
        val <= 0;
    end else if (enable) begin
        if(overflow) val<=(dir)?((ovfMode)?(match_value):MAX):(0);
        else begin
            if(dir) val <= val - 1;
            else val <= val + 1;
        end
    end
end

initial begin
    val = 0;
end

assign count = val;
assign overflow = (dir)?(val==0):(ovfMode?(match_occured):(val == MAX));
assign match_occured = (val == match_value);

endmodule