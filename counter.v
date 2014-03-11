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
    
    output  reg  [COUNTER_SIZE-1 : 0] count,
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

//reg [COUNTER_SIZE-1 : 0] val;
always @ ( posedge clk or negedge reset_n) begin
    $display("val = %x",count);
    if (!reset_n) begin
        count<=0;
    end else if (enable) begin
        if(overflow) begin
            if(dir)
                if(ovfMode)begin
                    count<=match_value;
                end else
                    count<=MAX;
            else 
                count<=0;
        end else begin
            $display("clk");
            if(dir) count <= count - 1;
            else count <= count + 1;
        end
    end
end

initial begin
    count<=0;
end

//assign count = val;
assign overflow = (dir)?(count==0):(ovfMode?(match_occured):(count == MAX));
assign match_occured = (count == match_value);

endmodule