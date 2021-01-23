`timescale 1ns/1ns
module fifo_tb;
parameter width = 4;
parameter height = 8;

wire [width-1:0] data_out;
wire empty, full;
reg [width-1:0] data_in;
reg clk;
reg rst;
reg write, read;
integer i;



fifo #(.width(width), .height(height)) fifo_i(
	.data_out(data_out), .full(full),
	.empty(empty), .read(read),
	.write(write), .clk(clk), .rst(rst),
	.data_in(data_in));

initial
begin
	clk = 0;
	forever #3 clk = ~clk;
end


initial
begin
	#05;rst = 1;
	#12;rst = 0;

end
initial
begin

	#15;  write = 1; read = 0;
	data_in = 0;
	for( i = 0; i<10; i=i+1)
		@(posedge clk) data_in = i;
	#50; write = 0; read = 1;
	#70; read = 0; write = 1; 
	#1;rst = 1;
	#2; rst = 0; write = 1;
	data_in =1;
	#1; data_in =~data_in;
	#5; read = 1; write = 0;
	#30; write = 1; read = 0;
	#50; read = 1; write = 0;
	#60 $finish;
end
initial
begin
	$dumpfile("fifo_tb.vcd");
	$dumpvars();
end

endmodule
