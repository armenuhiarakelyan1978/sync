module fifo(
	data_out,
	full,
	empty,
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
output empty;
input clk;
input rst;
input [width-1:0] data_in;
input write;
input read;

reg [height-1:0] read_ptr, write_ptr;
reg [ptr_width-1:0]diff;
reg [width-1:0] data_out;
reg [width-1:0] memory[height-1:0];
reg empty_r;
reg empty_r_r;
reg full_r;
reg full_r_r;

assign empty = empty_r & ~empty_r_r;
assign full =  full_r & ~full_r_r;



always@(posedge clk or posedge rst)
begin
if(rst)begin
	write_ptr <= 0;
	data_out <= 0;
	read_ptr <= 0;
	diff <= 0;
	empty_r <= 1;
	full_r <= 0;
end
else if(write && !full && !read) begin 
	memory[write_ptr] <= data_in;
	write_ptr <= write_ptr + 1;
	if(diff== height-1)begin
		full_r <=1;
	end else begin
		diff <= diff + 1;
		full_r <= 0;
	end
end
else if(!write && !empty && read)begin
	data_out <= memory[read_ptr];
	read_ptr <= read_ptr + 1;
	if(diff == 0)begin
		empty_r <= 1;
	end else
	begin
	diff <= diff - 1;
	empty_r <= 0;
        end
end
else if (write && read && empty)begin
	memory[write_ptr] <= data_in;
	write_ptr <= write_ptr + 1;
	if(diff == height - 1)begin
		full_r <= 1;
	end else begin
		diff <= diff +1;
		full_r <= 0;
	end
end
else if (write && read && full)begin
	data_out <= memory[read_ptr];
	read_ptr <= read_ptr + 1;
	if(diff == 0)begin
		empty_r <= 1;
	end else begin
		diff <= diff -1;
		empty_r <= 0;
	end
end

else if (write && read && !full && !empty)
begin
	data_out <= memory[read_ptr];
        memory[write_ptr] <= data_in;
	read_ptr <= read_ptr + 1;
	if(diff == 0)begin
		empty_r <= 1;
	end else begin
		diff <= diff -1;
		empty_r <= 0;
	end
	write_ptr <= write_ptr + 1;
	if(diff == height - 1)begin
		full_r <= 1;
		diff <= 0;
	end else begin
		diff <= diff +1;
		full_r <= 0;
	end
end
end

always@(posedge clk)
begin
	if(rst)begin
		full_r_r <= 0;
		empty_r_r <=1; 
	end else begin
		full_r_r <= full_r;
		empty_r_r <= empty_r;
	end
end
endmodule
