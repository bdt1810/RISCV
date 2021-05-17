module ramdata(datai, valid, clkram, rflag, datao);
	input valid, clkram;
	input [15:0] datai;
	output reg [31:0] datao;
	input [1:0] rflag;
 	
	always @(posedge clkram)
	begin
		if (valid)
		begin
			if (rflag === 2'b00)
				datao[31:16] <= datai;
			else if (rflag === 2'b01)
				datao[15:0] <= datai;
		end
	end
endmodule
