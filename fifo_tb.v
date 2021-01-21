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
integer i;



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
	for( i = 0; i<5; i=i+1)
@(negedge clk) data_in = data_in + 1;
end
initial
begin

	#15;  write = 1; read = 0;
         #80; write = 0; read = 1;

	#250; read = 0; write = 0;
	#350; read = 0; write = 1;

	#420; write = 1; read = 1;
	#480; write = 0;
end
initial
begin
	$dumpfile("fifo_tb.vcd");
	$dumpvars();
end

endmodule
