module ramcontrol(inst, data, addr, valid, request, clk, clkram, cs, we_n, re_n, be_n, datao, addro, rflag);
	input [31:0] inst, data, addr;
	input valid, request, clk, clkram;
	output reg we_n, re_n;
	output cs;
	output [1:0] be_n;
	output reg [24:0] addro;
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
		end
		else if (inst[6:0] === 7'b0100011)
		begin
			re_n  <= 1'b1;
			we_n  <= 1'b0;
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
				if (rflag === 2'b00)
				begin
					addro <= {addr[23:0],1'b0};
					rflag <= 2'b01;
				end
				else if (rflag === 2'b01)
				begin
					addro <= {addr[23:0],1'b1};
					rflag <= 2'b10;
				end
				else	
					rflag <= rflag;
			end
			else if(we_n === 1'b0)
			begin
				if (wflag === 2'b00)
				begin
					addro <= {addr[23:0],1'b0};
					datao <= data[31:16];
					wflag <= 2'b01;
				end
				else if (wflag === 2'b01)
				begin
					addro <= {addr[23:0],1'b1};
					datao <= data[15:0];
					wflag <= 2'b10;
				end
				else 
					wflag <= wflag;
			end	
			else 
			begin
				rflag <= rflag;
				wflag <= wflag;
			end
		end
		else 
		begin
			rflag <= 2'b00;
			wflag <= 2'b00;
		end
	end
endmodule
