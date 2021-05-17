module ramcontrol(inst, data, addr, valid, request, clk, clkram, cs, we_n, re_n, be_n, datao, addro, rflag);
	input [31:0] inst, data, addr;
	input valid, request, clk, clkram;
	output reg we_n, re_n;
	output cs;
	output [1:0] be_n;
	output reg [15:0] addro;
	output reg [31:0] datao;
	output reg [1:0] rflag;
	reg [1:0] wflag;
	
	
	
	assign be_n = 2'b00;
	assign cs = 1'b1;

	initial 
	begin
		rflag <= 2'b00;
		wflag <= 2'b00;
	end
	always @(posedge clk)
	begin
		if(inst[6:0] === 7'b0000011)
		begin
			re_n  <= 1'b0;
			we_n  <= 1'b1;
			addro <= {addr[22:0],1'b0};
		end
		else if (inst[6:0] === 7'b0100011)
		begin
			re_n  <= 1'b1;
			we_n  <= 1'b0;
			addro <= {addr[22:0],1'b0};
			datao <= data[31:16];
		end 
		else 
		begin
			re_n  <= 1'b1;
			we_n  <= 1'b1;
		end
	end

	always @(posedge clkram)
	begin
		if (request === 1'b0)
		begin
			if (valid === 1'b1 && inst[6:0] === 7'b0000011)
			begin
				rflag <= rflag + 1;
				addro <= {addr[22:0],1'b1};
			end
			else if (inst[6:0] === 7'b0100011)
			begin
				wflag <= wflag + 1;
				addro <= {addr[22:0],1'b1};
				datao <= data[15:0];
			end
			else
			begin
				re_n  <= 1'b1;
				we_n  <= 1'b1;
			end
		end
		if (rflag > 2)
		begin
			re_n <= 1'b1;
			we_n <= 1'b1;
			rflag <= 2'b00;
		end
		else if (wflag > 2)
		begin
			re_n <= 1'b1;
			we_n <= 1'b1;
			wflag <= 2'b00;
		end	
	end
endmodule
