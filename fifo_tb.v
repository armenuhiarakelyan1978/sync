`timescale 1ns/1ns
module fifo_tb;
parameter width = 4;
parameter height = 8;
parameter ptr_width = 3;

wire [width-1:0] data_out;
wire empthy, full;
reg [width-1:0] data_in;
reg clk;
reg rst;
reg write, read;

wire [11:0] f0,f1,f2,f3,f4,f5,f6,f7;

assign f0 = fifo_i.memory[0];
assign f1 = fifo_i.memory[1];
assign f2 = fifo_i.memory[2];
assign f3 = fifo_i.memory[3];
assign f4 = fifo_i.memory[4];
assign f5 = fifo_i.memory[5];
assign f6 = fifo_i.memory[6];
assign f7 = fifo_i.memory[7];



fifo #(.width(width), .height(height), .ptr_width(ptr_width)) fifo_i(
.data_out(data_out), .full(full),
.empthy(empthy), .read(read),
.write(write), .clk(clk), .rst(rst),
.data_in(data_in));

always
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
	#80; data_in = 1;
	forever #10 data_in = data_in + 1;
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
