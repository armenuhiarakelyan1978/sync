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


output [width-1:0] data_out;
output reg full;
output reg empthy;
input clk;
input rst;
input [width-1:0] data_in;
input write;
input read;

reg [height-1:0] read_ptr, write_ptr;

reg [width-1:0] data_out;
reg [width-1:0] memory[height-1:0];

//assign empthy = (ptr_diff == 0)?1'b1:1'b0;
//assign full =   (ptr_diff == height)?1'b1:1'b0;



always@(posedge clk or posedge rst)

	
begin
if(rst)begin
	data_out <= 0;
	read_ptr <= 0;
	write_ptr <= 0;
	full <=0;
	empthy <= 0;
end
else begin
 
	if( write )begin
		memory[write_ptr]<=data_in;
		if(write_ptr!=height)
		write_ptr <= write_ptr + 1'b1;
	        else 
			full <=1;
             
	end

	if(read )begin
		data_out <= memory[read_ptr];
		if(read_ptr != height)
		read_ptr <= read_ptr + 1'b1;
	        else
                   empthy <= 1;
	end

end

end

endmodule
