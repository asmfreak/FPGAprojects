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
wire [1:0]mode;
reg up_n;
reg ovf_mode;
assign mode[0] = up_n;
assign mode[1] = ovf_mode;

initial begin
    clk=0;
    reset_n=1;
    enable=0;
    ovf_mode=1;
    up_n=1;
    match_value=25;
    #5 enable=1;
    
    //#400 $finish; 
end

always begin
    #5 clk = ~clk;
end


count #(bin) c(clk,reset_n,enable,mode , match_value, oCounter, match, ovf);

initial
begin
  $dumpfile("out.vcd");
  $dumpvars(0,counterTest);
end


initial
$monitor("time ",$stime," clk",clk," reset",reset_n, " enable", enable, " counter", oCounter, " match",match?"yes":"no"," ovf",ovf );

endmodule