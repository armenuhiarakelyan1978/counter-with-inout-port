module bidir_p(inout [4:0] bidir,
	input clk,
	input en,
	input rst );

wire [4:0]load;
reg [4:0]count;
reg [4:0]count_r;
reg [4:0]load1;


always@(posedge clk or posedge rst)
begin
	if(rst)begin
		count <= 0;
		load1 <= 0;
	end
	else if(en) 
	begin
		count <= count + 1;
		if(count == load)		
			count <= 0;

	end
	else if(en == 0)begin
		count <= 0;
		load1 <= load;
	end

end


always@(posedge clk or posedge rst)
begin 
	if(rst)begin
		count_r <= 0;
	end
	else begin
		count_r <= count;
	end
end

assign bidir = en?((count_r<load1)?(count_r+1):5'b0):5'bz;


assign load = (en== 0)? bidir :5'bz;


endmodule
