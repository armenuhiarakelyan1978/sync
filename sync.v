module sync(
output write_sync,
input clk,
input rst,
input write);
reg meta;
reg write_sync;

always@(negedge clk)
begin
	if(rst)begin
	meta <= 0;
	write_sync <= 0;
        end else begin
	meta <= write;
	write_sync <= write_sync?0:meta;
	end
end
endmodule
