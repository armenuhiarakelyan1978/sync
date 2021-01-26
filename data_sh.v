module data_sh(
output reg [31:0] data_out,
output  write,
input [31:0]data_in,
input en,
input clk,
input rst);

reg [4:0]cnt;
assign write =(cnt == 31);

always@(posedge clk)
	if(rst)begin
		cnt <= 0;
	end else begin
		cnt <= cnt + 1;
	end
always@(posedge clk)
begin
	if(rst)begin
		data_out <= 0;
	end else if(en && write  )begin
		data_out <= {data_in,data_out[31:1]};
	end
	
end

endmodule
