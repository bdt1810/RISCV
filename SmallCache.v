module SmallCache(active, clk, address, DataIn, DataFromMem, RW, hit, DataCacheOut, buffer, request, bufferindex);
input [31:0] address, DataIn;
input clk, RW, active; // 1 Read, 0 Write 
input [144:0] DataFromMem;
output reg[144:0] buffer;
output reg[31:0] DataCacheOut, request;
output reg[1:0] hit;
output reg[3:0] bufferindex;
wire [1:0] offset;
reg [1:0] counter0;

wire [3:0] index;
wire [14:0] tag;
reg [144:0] block0, block1, block2, block3, blockW;
assign  offset = address[1:0];
assign  index = address[5:2];
assign  tag = address[20:6];
integer i;
reg [144:0] Cache [0:3];     // 15bit tag + 32x4bit data + 1 valid + 1 dirty = 144
initial 

begin
	counter0 = 2'b00;
	block0 = 145'd0;
	block1 = 145'd0;
	block2 = 145'd0;
	block3 = 145'd0;
	for (i=0; i<64; i=i+1)
	begin
	Cache[i] <= 145'd0;
	end
end


always @(*)
begin
	if (active === 1'b1)
	begin
			block0 <= Cache[0];
			block1 <= Cache[1];
			block2 <= Cache[2];
			block3 <= Cache[3];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0000;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0000;
				case (offset)
				2'b00:	DataCacheOut = block0[33:2];
				2'b01:	DataCacheOut = block0[65:34];
				2'b10:	DataCacheOut = block0[97:66];
				2'b11:	DataCacheOut = block0[129:98];
				endcase
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;	
				buffer = 145'd0;
				bufferindex = 4'b0000;	
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				DataCacheOut = 32'd0;	
				buffer = 145'd0;
				bufferindex = 4'b0000;	
				case (offset)
				2'b00:	DataCacheOut = block1[33:2];
				2'b01:	DataCacheOut = block1[65:34];
				2'b10:	DataCacheOut = block1[97:66];
				2'b11:	DataCacheOut = block1[129:98];
				endcase
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0000;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				DataCacheOut = 32'd0;	
				buffer = 145'd0;
				bufferindex = 4'b0000;	
				case (offset)
				2'b00:	DataCacheOut = block2[33:2];
				2'b01:	DataCacheOut = block2[65:34];
				2'b10:	DataCacheOut = block2[97:66];
				2'b11:	DataCacheOut = block2[129:98];
				endcase
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0000;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				DataCacheOut = 32'd0;	
				buffer = 145'd0;
				bufferindex = 4'b0000;	
				case (offset)
				2'b00:	DataCacheOut = block3[33:2];
				2'b01:	DataCacheOut = block3[65:34];
				2'b10:	DataCacheOut = block3[97:66];
				2'b11:	DataCacheOut = block3[129:98];
				endcase
				end
			else 
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0000;
				end
			end
		else 
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0000;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0000;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0000;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0000;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0000;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0000;
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0000;
				end
			else if (block3[144:130] === tag && block3[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0000;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0000;
				end
			end
		end
end


always @(negedge clk)
begin
 	if( active === 1'b1)
		begin
		block0 <= Cache[0];
		block1 <= Cache[1];
		block2 <= Cache[2];
		block3 <= Cache[3];
		if (hit === 2'b01) //Read miss
		begin
		case(counter0)
		2'b00:	begin
			buffer <= block0;
			Cache[0]<= DataFromMem;
			counter0 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[1]<= DataFromMem;
			counter0 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[2]<= DataFromMem;
			counter0 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[3]<= DataFromMem;
			counter0 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10) //Write hit
		begin
		buffer <= block0;
		if(block0[144:130] === tag)
		begin
		case(offset)
			2'b00:	begin
				Cache[0][33:2] <= DataIn;
				Cache[0][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[0][65:34] <= DataIn;
				Cache[0][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[0][97:66] <= DataIn;
				Cache[0][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[0][129:98] <= DataIn;
				Cache[0][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[1][33:2] <= DataIn;
				Cache[1][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[1][65:34] <= DataIn;
				Cache[1][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[1][97:66] <= DataIn;
				Cache[1][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[1][129:98] <= DataIn;
				Cache[1][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[3][33:2] <= DataIn;
				Cache[3][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[3][65:34] <= DataIn;
				Cache[3][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[3][97:66] <= DataIn;
				Cache[3][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[3][129:98] <= DataIn;
				Cache[3][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[3][33:2] <= DataIn;
				Cache[3][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[3][65:34] <= DataIn;
				Cache[3][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[3][97:66] <= DataIn;
				Cache[3][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[3][129:98] <= DataIn;
				Cache[3][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter0)
		2'b00:				begin
						counter0 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[0][144:34] <= DataFromMem[144:34];
						Cache[0][33:2] <= DataIn;
						Cache[0][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[0][144:66] <= DataFromMem[144:66];
						Cache[0][65:34] <= DataIn;
						Cache[0][33:2] <= DataFromMem[33:2];
						Cache[0][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[0][144:98] <= DataFromMem[144:98];
						Cache[0][97:66] <= DataIn;
						Cache[0][65:2] <= DataFromMem[65:2];
						Cache[0][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[0][129:98] <= DataIn;
						Cache[0][97:2] <= DataFromMem[97:2];
						Cache[0][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter0 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[1][144:34] <= DataFromMem[144:34];
						Cache[1][33:2] <= DataIn;
						Cache[1][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[1][144:66] <= DataFromMem[144:66];
						Cache[1][65:34] <= DataIn;
						Cache[1][33:2] <= DataFromMem[33:2];
						Cache[1][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[1][144:98] <= DataFromMem[144:98];
						Cache[1][97:66] <= DataIn;
						Cache[1][65:2] <= DataFromMem[65:2];
						Cache[1][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[1][129:98] <= DataIn;
						Cache[1][97:2] <= DataFromMem[97:2];
						Cache[1][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter0 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[2][144:34] <= DataFromMem[144:34];
						Cache[2][33:2] <= DataIn;
						Cache[2][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[2][144:66] <= DataFromMem[144:66];
						Cache[2][65:34] <= DataIn;
						Cache[2][33:2] <= DataFromMem[33:2];
						Cache[2][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[2][144:98] <= DataFromMem[144:98];
						Cache[2][97:66] <= DataIn;
						Cache[2][65:2] <= DataFromMem[65:2];
						Cache[2][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[2][129:98] <= DataIn;
						Cache[2][97:2] <= DataFromMem[97:2];
						Cache[2][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter0 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[3][144:34] <= DataFromMem[144:34];
						Cache[3][33:2] <= DataIn;
						Cache[3][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[3][144:66] <= DataFromMem[144:66];
						Cache[3][65:34] <= DataIn;
						Cache[3][33:2] <= DataFromMem[33:2];
						Cache[3][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[3][144:98] <= DataFromMem[144:98];
						Cache[3][97:66] <= DataIn;
						Cache[3][65:2] <= DataFromMem[65:2];
						Cache[3][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[3][129:98] <= DataIn;
						Cache[3][97:2] <= DataFromMem[97:2];
						Cache[3][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter0 = counter0;	
		end
end
endmodule


