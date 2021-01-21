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
output full;
output empthy;
input clk;
input rst;
input [width-1:0] data_in;
input write;
input read;

reg [height-1:0] read_ptr, write_ptr;

reg [width-1:0] data_out;
reg [width-1:0] memory[height-1:0];
reg [width-1:0] counter;

assign empthy = (counter == 0 && read && ~write)?1'b1:1'b0;
assign full =   (counter == height && write && ~read)?1'b1:1'b0;



always@(posedge clk or posedge rst)
begin
if(rst)begin
	write_ptr <= 0;
end
else begin
	if(write && counter < height) begin 
	memory[write_ptr] <= data_in;
	write_ptr <= write_ptr + 1;
end
end
end


always@(posedge clk or posedge rst)
begin 
	if(rst)begin
		read_ptr <= 0;
	end else begin
		if( read && counter != 0)begin
			data_out <= memory[read_ptr];
			read_ptr <= read_ptr + 1;
		end
end
end

always@(posedge clk or posedge rst)
begin
	if(rst)begin
		counter <= 0;
	end else begin
		case({write, read})
			2'b10: counter <= counter + 1;
			2'b01: counter <= counter - 1;
			default: counter <= counter;
		endcase
	end
end
endmodule
