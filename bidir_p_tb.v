`timescale 1ns/1ns
`include "bidir_p.v"

module bidir_p_tb;
reg en;
reg clk;
wire [4:0] bidir;
reg rst;
reg [4:0]bidir_r;

bidir_p io(.clk(clk),
	.en(en), .rst(rst), .bidir(bidir));

initial
begin
	clk = 0;
	forever #3 clk = ~clk;
end

initial
begin
	en = 1; bidir_r = 5;rst = 1;
	#2 en = 0; rst = 0;
	# 4 en = 1;
	#60 bidir_r = 6;en = 0;
	#5 en = 1; 
	#70 en = 0;
	bidir_r = 15;
	#10 en=1;  
end

assign bidir =(en==0)?bidir_r:5'bz;
initial
begin
	$dumpfile("bidir_p_tb.vcd");
	$dumpvars();
	#280 $finish;
end
endmodule
