`timescale 1ns/1ns
module fifo_tb;
parameter width = 4;
parameter height = 8;

wire [width-1:0] data_out;
wire empthy, full;
reg [width-1:0] data_in;
reg clk;
reg rst;
reg write, read;




fifo #(.width(width), .height(height)) fifo_i(
.data_out(data_out), .full(full),
.empthy(empthy), .read(read),
.write(write), .clk(clk), .rst(rst),
.data_in(data_in));

initial
begin
	clk = 0;
	forever #3 clk = ~clk;
end

initial
begin
	#1500 $finish;
end

initial
begin
	#10;rst = 1;
	#30;rst = 0;
	#420;rst = 1;
	#460;rst = 0;

end
initial
begin
        data_in = 1;
	for(integer i = 0; i<10; i=i+1)
	 data_in = data_in + 1;
end
initial
fork
	#80; write = 1;
	#180; write = 0;

	#250; read = 1;
	#350; read = 0;

	#420; write = 1;
	#480; write = 0;
join
initial
begin
	$dumpfile("fifo_tb.vcd");
	$dumpvars();
end

endmodule
