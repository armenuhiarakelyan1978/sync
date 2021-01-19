`timescale 1ns/1ns
module fifo(
	data_out,
	full,
	empthy,
	clk,
	rst,
	data_in,
        write,
        read);

parameter width = 4;
parameter height = 8;
parameter ptr_width = 3;


output [width-1:0] data_out;
output full;
output empthy;
input clk;
input rst;
input [width-1:0] data_in;
input write;
input read;

reg [ptr_width-1:0] read_ptr, write_ptr;
reg [ptr_width-1:0] ptr_diff;

reg [width-1:0] data_out;
reg [width-1:0] memory[height-1:0];

assign empthy = (ptr_diff == 0)?1'b1:1'b0;
assign full =   (ptr_diff == height)?1'b1:1'b0;



always@(posedge clk or posedge rst)

	
begin
if(rst)begin
	data_out <= 0;
	read_ptr <= 0;
	write_ptr <= 0;
	ptr_diff <=0;
end
else begin
	if(!empthy && read)begin
		data_out <= memory[read_ptr];
		read_ptr <= read_ptr + 1'b1;
		ptr_diff <= ptr_diff - 1'b1;
	end
	else
	if(!full && write)begin
		memory[write_ptr]<=data_in;
		write_ptr <= write_ptr + 1'b1;
		ptr_diff <= ptr_diff + 1'b1;
	end
end

end

endmodule
