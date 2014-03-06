module counterTest();
parameter bin = 32;
//inputs
reg  clk;
reg  reset_n;
reg  enable;
reg  [bin-1 : 0] match_value;
//outputs
wire [bin-1 : 0] oCounter; 
wire match;
wire ovf;

initial begin
    clk=0;
    reset_n=1;
    enable=0;
    match_value=25;
    #5 enable=1;
    #400 $finish; 
end

always begin
    #1 clk = ~clk;
end


count #(bin) c(clk,reset_n,enable, match_value, oCounter, match, ovf);

initial
begin
  $dumpfile("out.vcd");
  $dumpvars(0,counterTest);
end


initial
$monitor($stime, clk,, reset_n, enable, oCounter,match,ovf );

endmodule