module NewCache(clk, address, DataIn, DataFromMem, RW, hit, DataCacheOut, buffer, request, bufferindex);
input [31:0] address, DataIn;
input clk, RW; // 1 Read, 0 Write 
input [144:0] DataFromMem;
output reg[144:0] buffer;
output reg[31:0] DataCacheOut, request;
output reg[1:0] hit;
output reg[3:0] bufferindex;
wire [1:0] offset;
reg [1:0] counter0, counter1, counter2, counter3, counter4, counter5, counter6, counter7;
reg [1:0] counter8, counter9, counter10, counter11, counter12, counter13, counter14, counter15;

wire [3:0] index;
wire [14:0] tag;
reg [144:0] block0, block1, block2, block3, blockW, blockK;
assign  offset = address[1:0];
assign  index = address[5:2];
assign  tag = address[20:6];
integer i;
reg [144:0] Cache [0:66];     // 15bit tag + 32x4bit data + 1 valid + 1 dirty = 144
initial 
begin
	counter0 = 2'b00;
	counter1 = 2'b00;
	counter2 = 2'b00;
	counter3 = 2'b00;
	counter4 = 2'b00;
	counter5 = 2'b00;
	counter6 = 2'b00;
	counter7 = 2'b00;
	counter8 = 2'b00;
	counter9 = 2'b00;
	counter10 = 2'b00;
	counter11 = 2'b00;
	counter12 = 2'b00;
	counter13 = 2'b00;
	counter14 = 2'b00;
	counter15 = 2'b00;
	block0 = 145'd0;
	block1 = 145'd0;
	block2 = 145'd0;
	block3 = 145'd0;
	for (i=0; i<67; i=i+1)
	begin
	Cache[i] <= 145'h0;
	end
end

always @(*)
begin
case(index)
4'b0000: 	begin
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
4'b0001:	begin
			block0 <= Cache[4];
			block1 <= Cache[5];
			block2 <= Cache[6];
			block3 <= Cache[7];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0001;
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
				bufferindex = 4'b0001;	
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = 32'd3;
				DataCacheOut = 32'd0;	
				buffer = 145'd0;
				bufferindex = 4'b0001;	
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
				bufferindex = 4'b0001;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				DataCacheOut = 32'd0;	
				buffer = 145'd0;
				bufferindex = 4'b0001;	
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
				bufferindex = 4'b0001;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				DataCacheOut = 32'd0;	
				buffer = 145'd0;
				bufferindex = 4'b0001;	
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
				bufferindex = 4'b0001;
				end
			end
		else   // Write
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0001;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0001;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0001;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0001;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
 				buffer = 145'd0;
				bufferindex = 4'b0001;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0001;
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0001;
				end
			else if (block3[144:130] === tag && block3[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0001;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0001;
				end
			end
		end

4'b0010:	begin
			block0 <= Cache[8];
			block1 <= Cache[9];
			block2 <= Cache[10];
			block3 <= Cache[11];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0010;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0010;
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
				bufferindex = 4'b0010;	
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0010;	
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
				bufferindex = 4'b0010;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;	
				buffer = 145'd0;
				bufferindex = 4'b0010;	
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
				bufferindex = 4'b0010;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0010;	
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
				bufferindex = 4'b0010;
				end
			end
		else   // Write
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0010;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0001;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0010;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0010;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0010;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0010;
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0010;
				end
			else if (block3[144:130] === tag && block3[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0010;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0010;
				end
			end
		end

4'b0011:	begin
			block0 <= Cache[12];
			block1 <= Cache[13];
			block2 <= Cache[14];
			block3 <= Cache[15];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0011;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0011;
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
				bufferindex = 4'b0011;	
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0011;	
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
				bufferindex = 4'b0011;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				buffer = 145'd0;
				bufferindex = 4'b0011;	
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
				bufferindex = 4'b0011;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				DataCacheOut = 32'd0;	
				buffer = 145'd0;
				bufferindex = 4'b0011;	
				end
			else 
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0011;
				end
			end
		else   // Write
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0011;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0011;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0011;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0011;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0011;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0011;
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
				bufferindex = 4'b0011;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0011;
				end
			end
		end

4'b0100:	begin
			block0 <= Cache[16];
			block1 <= Cache[17];
			block2 <= Cache[18];
			block3 <= Cache[19];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0100;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0100;
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
				bufferindex = 4'b0100;	
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0100;	
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
				bufferindex = 4'b0100;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				buffer = 145'd0;
				bufferindex = 4'b0100;	
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
				bufferindex = 4'b0100;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0100;	
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
				bufferindex = 4'b0100;
				end
			end
		else   // Write
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0100;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0100;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0100;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0100;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0100;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0100;
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0100;
				end
			else if (block3[144:130] === tag && block3[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0100;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0100;
				end
			end
		end

4'b0101:	begin
			block0 <= Cache[20];
			block1 <= Cache[21];
			block2 <= Cache[22];
			block3 <= Cache[23];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0101;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0101;
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
				bufferindex = 4'b0101;	
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0101;	
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
				bufferindex = 4'b0101;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				buffer = 145'd0;
				bufferindex = 4'b0101;	
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
				bufferindex = 4'b0101;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0101;	
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
				bufferindex = 4'b0101;
				end
			end
		else   // Write
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0101;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0101;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0101;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0101;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0101;
				DataCacheOut = 32'd0;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0101;
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0101;
				end
			else if (block3[144:130] === tag && block3[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0101;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0101;
				end
			end
		end

4'b0110:	begin
			block0 <= Cache[24];
			block1 <= Cache[25];
			block2 <= Cache[26];
			block3 <= Cache[27];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0110;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0110;
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
				bufferindex = 4'b0110;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0110;
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
				bufferindex = 4'b0110;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				buffer = 145'd0;
				bufferindex = 4'b0110;
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
				buffer = 145'd0;
				bufferindex = 4'b0110;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0110;
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
				bufferindex = 4'b0110;
				end
			end
		else   // Write
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0110;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0110;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0110;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0110;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0110;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0110;
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
				bufferindex = 4'b0110;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0110;
				end
			end
		end

4'b0111:	begin
			block0 <= Cache[28];
			block1 <= Cache[29];
			block2 <= Cache[30];
			block3 <= Cache[31];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0111;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0111;
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
				bufferindex = 4'b0111;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0111;
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
				bufferindex = 4'b0111;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				buffer = 145'd0;
				bufferindex = 4'b0111;
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
				bufferindex = 4'b0111;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b0111;
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
				bufferindex = 4'b0111;
				end
			end
		else   // Write
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
				bufferindex = 4'b0111;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0111;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0111;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0111;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0111;
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0111;
				end
			else if (block3[144:130] === tag && block3[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b0111;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b0111;
				end
			end
		end

4'b1000:	begin
			block0 <= Cache[32];
			block1 <= Cache[33];
			block2 <= Cache[34];
			block3 <= Cache[35];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1000;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1000;
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
				bufferindex = 4'b1000;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1000;
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
				bufferindex = 4'b1000;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				buffer = 145'd0;
				bufferindex = 4'b1000;
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
				bufferindex = 4'b1000;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1000;
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
				bufferindex = 4'b1000;
				end
			end
		else   // Write
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1000;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1000;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1000;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1000;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1000;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1000;
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1000;
				end
			else if (block3[144:130] === tag && block3[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1000;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1000;
				end
			end
		end	

4'b1001:	begin
			block0 <= Cache[36];
			block1 <= Cache[37];
			block2 <= Cache[38];
			block3 <= Cache[39];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1001;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1001;
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
				bufferindex = 4'b1001;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1001;
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
				bufferindex = 4'b1001;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				buffer = 145'd0;
				bufferindex = 4'b1001;
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
				bufferindex = 4'b1001;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1001;
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
				bufferindex = 4'b1001;
				end
			end
		else   // Write
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1001;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1001;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1001;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1001;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1001;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1001;
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1001;
				end
			else if (block3[144:130] === tag && block3[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1001;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1001;
				end
			end
		end

4'b1010:	begin
			block0 <= Cache[40];
			block1 <= Cache[41];
			block2 <= Cache[42];
			block3 <= Cache[43];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1010;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1010;
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
				bufferindex = 4'b1010;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1010;
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
				bufferindex = 4'b1010;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				buffer = 145'd0;
				bufferindex = 4'b1010;
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
				bufferindex = 4'b1010;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1010;
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
				bufferindex = 4'b1010;
				end
			end
		else   // Write
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1010;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1010;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1010;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1010;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1010;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1010;
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1010;
				end
			else if (block3[144:130] === tag && block3[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1010;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1010;
				end
			end
		end

4'b1011:	begin
			block0 <= Cache[44];
			block1 <= Cache[45];
			block2 <= Cache[46];
			block3 <= Cache[47];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1011;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1011;
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
				bufferindex = 4'b1011;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1011;
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
				bufferindex = 4'b1011;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				buffer = 145'd0;
				bufferindex = 4'b1011;
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
				bufferindex = 4'b1011;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1011;
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
				bufferindex = 4'b1011;
				end
			end
		else   // Write
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1011;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1011;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1011;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1011;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1011;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1011;
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1011;
				end
			else if (block3[144:130] === tag && block3[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1011;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1011;
				end
			end
		end

4'b1100:	begin
			block0 <= Cache[48];
			block1 <= Cache[49];
			block2 <= Cache[50];
			block3 <= Cache[51];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1100;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1100;
				case (offset)
				2'b00:	DataCacheOut = 32'd5;
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
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1100;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1100;
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
				bufferindex = 4'b1100;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				buffer = 145'd0;
				bufferindex = 4'b1100;	
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
				bufferindex = 4'b1100;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1100;	
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
				bufferindex = 4'b1100;
				end
			end
		else   // Write
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1100;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1100;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1100;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1100;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1100;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1100;
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1100;
				end
			else if (block3[144:130] === tag && block3[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1100;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1100;
				end
			end
		end

4'b1101:	begin
			block0 <= Cache[52];
			block1 <= Cache[53];
			block2 <= Cache[54];
			block3 <= Cache[55];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1101;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1101;
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
				bufferindex = 4'b1101;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1101;
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
				bufferindex = 4'b1101;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				buffer = 145'd0;
				bufferindex = 4'b1101;
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
				bufferindex = 4'b1101;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1101;
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
				bufferindex = 4'b1101;
				end
			end
		else   // Write
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1101;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1101;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1101;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1101;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1101;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1101;
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1101;
				end
			else if (block3[144:130] === tag && block3[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1101;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1101;
				end
			end
		end

4'b1110:	begin
			block0 <= Cache[56];
			block1 <= Cache[57];
			block2 <= Cache[58];
			block3 <= Cache[59];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1110;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1110;
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
				bufferindex = 4'b1110;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1110;
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
				bufferindex = 4'b1110;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				buffer = 145'd0;
				bufferindex = 4'b1110;
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
				bufferindex = 4'b1110;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1110;
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
				bufferindex = 4'b1110;
				end
			end
		else   // Write
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1110;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1110;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1110;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1110;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1110;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1110;
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1110;
				end
			else if (block3[144:130] === tag && block3[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1110;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1110;
				end
			end
		end

4'b1111:	begin
			block0 <= Cache[60];
			block1 <= Cache[61];
			block2 <= Cache[62];
			block3 <= Cache[63];
			if(RW === 1'b1) //Read
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b01;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1111;
				end
			else if (block0[144:130] === tag & block0[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1111;
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
				bufferindex = 4'b1111;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1111;
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
				bufferindex = 4'b1111;
				end
			else if (block2[144:130] === tag & block2[1] === 1'b1)
				begin
				hit = 2'b11;
				request =  address;
				buffer = 145'd0;
				bufferindex = 4'b1111;
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
				bufferindex = 4'b1111;
				end
			else if (block3[144:130] === tag & block3[1] === 1'b1)
				begin
				hit = 2'b11;
				request = address;
				buffer = 145'd0;
				bufferindex = 4'b1111;
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
				bufferindex = 4'b1111;
				end
			end
		else   // Write
			begin
			if (block0[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1111;
				end
			else if (block0[144:130] === tag && block0[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1111;
				end
			else if (block1[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1111;
				end
			else if (block1[144:130] === tag && block1[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1111;
				end
			else if (block2[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1111;
				end
			else if (block2[144:130] === tag && block2[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1111;
				end
			else if (block3[1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1111;
				end
			else if (block3[144:130] === tag && block3[1] === 1'b1)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 145'd0;
				bufferindex = 4'b1111;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'd0;
				buffer = 145'd0;
				bufferindex = 4'b1111;
				end
			end
		end
endcase
end

always @(negedge clk)
begin
case(index)
4'b0000:	begin
		block0 <= Cache[0];
		block1 <= Cache[1];
		block2 <= Cache[2];
		block3 <= Cache[3];
		bufferindex = 4'b0000;
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
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
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
				Cache[2][33:2] <= DataIn;
				Cache[2][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[2][65:34] <= DataIn;
				Cache[2][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[2][97:66] <= DataIn;
				Cache[2][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[2][129:98] <= DataIn;
				Cache[2][1:0] <= 2'b11;
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
						Cache[0][144:130] <= DataFromMem[144:130];
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
						Cache[1][144:130] <= DataFromMem[144:130];
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
						Cache[2][144:130] <= DataFromMem[144:130];
						Cache[2][129:98] <= DataIn;
						Cache[2][97:2] <= DataFromMem[97:2];
						Cache[2][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter0 = 2'b01;
						buffer <= block3;
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
						Cache[3][144:130] <= DataFromMem[144:130];
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

4'b0001:	begin
		block0 <= Cache[4];
		block1 <= Cache[5];
		block2 <= Cache[6];
		block3 <= Cache[7];
		bufferindex = 4'b0001;
		if (hit === 2'b01) //Read miss
		begin
		case(counter1)
		2'b00:	begin
			buffer <= block0;
			Cache[4]<= DataFromMem;
			counter1 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[5]<= DataFromMem;
			counter1 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[6]<= DataFromMem;
			counter1 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[7]<= DataFromMem;
			counter1 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[4][33:2] <= DataIn;
				Cache[4][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[4][65:34] <= DataIn;
				Cache[4][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[4][97:66] <= DataIn;
				Cache[4][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[4][129:98] <= DataIn;
				Cache[4][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[5][33:2] <= DataIn;
				Cache[5][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[5][65:34] <= DataIn;
				Cache[5][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[5][97:66] <= DataIn;
				Cache[5][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[5][129:98] <= DataIn;
				Cache[5][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[6][33:2] <= DataIn;
				Cache[6][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[6][65:34] <= DataIn;
				Cache[6][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[6][97:66] <= DataIn;
				Cache[6][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[6][129:98] <= DataIn;
				Cache[6][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[7][33:2] <= DataIn;
				Cache[7][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[7][65:34] <= DataIn;
				Cache[7][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[7][97:66] <= DataIn;
				Cache[7][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[7][129:98] <= DataIn;
				Cache[7][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter1)
		2'b00:				begin
						counter1 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[4][144:34] <= DataFromMem[144:34];
						Cache[4][33:2] <= DataIn;
						Cache[4][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[4][144:66] <= DataFromMem[144:66];
						Cache[4][65:34] <= DataIn;
						Cache[4][33:2] <= DataFromMem[33:2];
						Cache[4][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[4][144:98] <= DataFromMem[144:98];
						Cache[4][97:66] <= DataIn;
						Cache[4][65:2] <= DataFromMem[65:2];
						Cache[4][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[4][144:130] <= DataFromMem[144:130];
						Cache[4][129:98] <= DataIn;
						Cache[4][97:2] <= DataFromMem[97:2];
						Cache[4][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter1 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[5][144:34] <= DataFromMem[144:34];
						Cache[5][33:2] <= DataIn;
						Cache[5][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[5][144:66] <= DataFromMem[144:66];
						Cache[5][65:34] <= DataIn;
						Cache[5][33:2] <= DataFromMem[33:2];
						Cache[5][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[5][144:98] <= DataFromMem[144:98];
						Cache[5][97:66] <= DataIn;
						Cache[5][65:2] <= DataFromMem[65:2];
						Cache[5][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[5][144:130] <= DataFromMem[144:130];
						Cache[5][129:98] <= DataIn;
						Cache[5][97:2] <= DataFromMem[97:2];
						Cache[5][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter1 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[6][144:34] <= DataFromMem[144:34];
						Cache[6][33:2] <= DataIn;
						Cache[6][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[6][144:66] <= DataFromMem[144:66];
						Cache[6][65:34] <= DataIn;
						Cache[6][33:2] <= DataFromMem[33:2];
						Cache[6][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[6][144:98] <= DataFromMem[144:98];
						Cache[6][97:66] <= DataIn;
						Cache[6][65:2] <= DataFromMem[65:2];
						Cache[6][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[6][144:130] <= DataFromMem[144:130];
						Cache[6][129:98] <= DataIn;
						Cache[6][97:2] <= DataFromMem[97:2];
						Cache[6][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter1 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[7][144:34] <= DataFromMem[144:34];
						Cache[7][33:2] <= DataIn;
						Cache[7][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[7][144:66] <= DataFromMem[144:66];
						Cache[7][65:34] <= DataIn;
						Cache[7][33:2] <= DataFromMem[33:2];
						Cache[7][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[7][144:98] <= DataFromMem[144:98];
						Cache[7][97:66] <= DataIn;
						Cache[7][65:2] <= DataFromMem[65:2];
						Cache[7][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[7][144:130] <= DataFromMem[144:130];
						Cache[7][129:98] <= DataIn;
						Cache[7][97:2] <= DataFromMem[97:2];
						Cache[7][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter1 = counter1;	
		end





4'b0010:	begin
		block0 <= Cache[8];
		block1 <= Cache[9];
		block2 <= Cache[10];
		block3 <= Cache[11];
		bufferindex = 4'b0010;
		if (hit === 2'b01) //Read miss
		begin
		case(counter2)
		2'b00:	begin
			buffer <= block0;
			Cache[8]<= DataFromMem;
			counter2 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[9]<= DataFromMem;
			counter2 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[10]<= DataFromMem;
			counter2 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[11]<= DataFromMem;
			counter2 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[8][33:2] <= DataIn;
				Cache[8][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[8][65:34] <= DataIn;
				Cache[8][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[8][97:66] <= DataIn;
				Cache[8][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[8][129:98] <= DataIn;
				Cache[8][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[9][33:2] <= DataIn;
				Cache[9][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[9][65:34] <= DataIn;
				Cache[9][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[9][97:66] <= DataIn;
				Cache[9][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[9][129:98] <= DataIn;
				Cache[9][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[10][33:2] <= DataIn;
				Cache[10][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[10][65:34] <= DataIn;
				Cache[10][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[10][97:66] <= DataIn;
				Cache[10][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[10][129:98] <= DataIn;
				Cache[10][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[11][33:2] <= DataIn;
				Cache[11][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[11][65:34] <= DataIn;
				Cache[11][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[11][97:66] <= DataIn;
				Cache[11][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[11][129:98] <= DataIn;
				Cache[11][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter2)
		2'b00:				begin
						counter2 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[8][144:34] <= DataFromMem[144:34];
						Cache[8][33:2] <= DataIn;
						Cache[8][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[8][144:66] <= DataFromMem[144:66];
						Cache[8][65:34] <= DataIn;
						Cache[8][33:2] <= DataFromMem[33:2];
						Cache[8][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[8][144:98] <= DataFromMem[144:98];
						Cache[8][97:66] <= DataIn;
						Cache[8][65:2] <= DataFromMem[65:2];
						Cache[8][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[8][144:130] <= DataFromMem[144:130];
						Cache[8][129:98] <= DataIn;
						Cache[8][97:2] <= DataFromMem[97:2];
						Cache[8][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter2 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[9][144:34] <= DataFromMem[144:34];
						Cache[9][33:2] <= DataIn;
						Cache[9][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[9][144:66] <= DataFromMem[144:66];
						Cache[9][65:34] <= DataIn;
						Cache[9][33:2] <= DataFromMem[33:2];
						Cache[9][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[9][144:98] <= DataFromMem[144:98];
						Cache[9][97:66] <= DataIn;
						Cache[9][65:2] <= DataFromMem[65:2];
						Cache[9][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[9][144:130] <= DataFromMem[144:130];
						Cache[9][129:98] <= DataIn;
						Cache[9][97:2] <= DataFromMem[97:2];
						Cache[9][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter2 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[10][144:34] <= DataFromMem[144:34];
						Cache[10][33:2] <= DataIn;
						Cache[10][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[10][144:66] <= DataFromMem[144:66];
						Cache[10][65:34] <= DataIn;
						Cache[10][33:2] <= DataFromMem[33:2];
						Cache[10][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[10][144:98] <= DataFromMem[144:98];
						Cache[10][97:66] <= DataIn;
						Cache[10][65:2] <= DataFromMem[65:2];
						Cache[10][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[10][144:130] <= DataFromMem[144:130];
						Cache[10][129:98] <= DataIn;
						Cache[10][97:2] <= DataFromMem[97:2];
						Cache[10][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter2 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[11][144:34] <= DataFromMem[144:34];
						Cache[11][33:2] <= DataIn;
						Cache[11][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[11][144:66] <= DataFromMem[144:66];
						Cache[11][65:34] <= DataIn;
						Cache[11][33:2] <= DataFromMem[33:2];
						Cache[11][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[11][144:98] <= DataFromMem[144:98];
						Cache[11][97:66] <= DataIn;
						Cache[11][65:2] <= DataFromMem[65:2];
						Cache[11][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[11][144:130] <= DataFromMem[144:130];
						Cache[11][129:98] <= DataIn;
						Cache[11][97:2] <= DataFromMem[97:2];
						Cache[11][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter2 = counter2;	
		end
4'b0011:	begin
		block0 <= Cache[12];
		block1 <= Cache[13];
		block2 <= Cache[14];
		block3 <= Cache[15];
		bufferindex = 4'b0011;
		if (hit === 2'b01) //Read miss
		begin
		case(counter3)
		2'b00:	begin
			buffer <= block0;
			Cache[12]<= DataFromMem;
			counter3 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[13]<= DataFromMem;
			counter3 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[14]<= DataFromMem;
			counter3 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[15]<= DataFromMem;
			counter3 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[12][33:2] <= DataIn;
				Cache[12][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[12][65:34] <= DataIn;
				Cache[12][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[12][97:66] <= DataIn;
				Cache[12][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[12][129:98] <= DataIn;
				Cache[12][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[13][33:2] <= DataIn;
				Cache[13][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[13][65:34] <= DataIn;
				Cache[13][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[13][97:66] <= DataIn;
				Cache[13][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[13][129:98] <= DataIn;
				Cache[13][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[14][33:2] <= DataIn;
				Cache[14][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[14][65:34] <= DataIn;
				Cache[14][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[14][97:66] <= DataIn;
				Cache[14][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[14][129:98] <= DataIn;
				Cache[14][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[15][33:2] <= DataIn;
				Cache[15][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[15][65:34] <= DataIn;
				Cache[15][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[15][97:66] <= DataIn;
				Cache[15][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[15][129:98] <= DataIn;
				Cache[15][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter3)
		2'b00:				begin
						counter3 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[12][144:34] <= DataFromMem[144:34];
						Cache[12][33:2] <= DataIn;
						Cache[12][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[12][144:66] <= DataFromMem[144:66];
						Cache[12][65:34] <= DataIn;
						Cache[12][33:2] <= DataFromMem[33:2];
						Cache[12][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[12][144:98] <= DataFromMem[144:98];
						Cache[12][97:66] <= DataIn;
						Cache[12][65:2] <= DataFromMem[65:2];
						Cache[12][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[12][144:130] <= DataFromMem[144:130];
						Cache[12][129:98] <= DataIn;
						Cache[12][97:2] <= DataFromMem[97:2];
						Cache[12][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter3 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[13][144:34] <= DataFromMem[144:34];
						Cache[13][33:2] <= DataIn;
						Cache[13][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[13][144:66] <= DataFromMem[144:66];
						Cache[13][65:34] <= DataIn;
						Cache[13][33:2] <= DataFromMem[33:2];
						Cache[13][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[13][144:98] <= DataFromMem[144:98];
						Cache[13][97:66] <= DataIn;
						Cache[13][65:2] <= DataFromMem[65:2];
						Cache[13][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[13][144:130] <= DataFromMem[144:130];
						Cache[13][129:98] <= DataIn;
						Cache[13][97:2] <= DataFromMem[97:2];
						Cache[13][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter3 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[14][144:34] <= DataFromMem[144:34];
						Cache[14][33:2] <= DataIn;
						Cache[14][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[14][144:66] <= DataFromMem[144:66];
						Cache[14][65:34] <= DataIn;
						Cache[14][33:2] <= DataFromMem[33:2];
						Cache[14][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[14][144:98] <= DataFromMem[144:98];
						Cache[14][97:66] <= DataIn;
						Cache[14][65:2] <= DataFromMem[65:2];
						Cache[14][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[14][144:130] <= DataFromMem[144:130];
						Cache[14][129:98] <= DataIn;
						Cache[14][97:2] <= DataFromMem[97:2];
						Cache[14][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter3 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[15][144:34] <= DataFromMem[144:34];
						Cache[15][33:2] <= DataIn;
						Cache[15][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[15][144:66] <= DataFromMem[144:66];
						Cache[15][65:34] <= DataIn;
						Cache[15][33:2] <= DataFromMem[33:2];
						Cache[15][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[15][144:98] <= DataFromMem[144:98];
						Cache[15][97:66] <= DataIn;
						Cache[15][65:2] <= DataFromMem[65:2];
						Cache[15][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[15][144:130] <= DataFromMem[144:130];
						Cache[15][129:98] <= DataIn;
						Cache[15][97:2] <= DataFromMem[97:2];
						Cache[15][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter3 = counter3;	
		end


4'b0100:	begin
		block0 <= Cache[16];
		block1 <= Cache[17];
		block2 <= Cache[18];
		block3 <= Cache[19];
		bufferindex = 4'b0100;
		if (hit === 2'b01) //Read miss
		begin
		case(counter4)
		2'b00:	begin
			buffer <= block0;
			Cache[16]<= DataFromMem;
			counter4 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[17]<= DataFromMem;
			counter4 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[18]<= DataFromMem;
			counter4 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[19]<= DataFromMem;
			counter4 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[16][33:2] <= DataIn;
				Cache[16][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[16][65:34] <= DataIn;
				Cache[16][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[16][97:66] <= DataIn;
				Cache[16][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[16][129:98] <= DataIn;
				Cache[16][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[17][33:2] <= DataIn;
				Cache[17][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[17][65:34] <= DataIn;
				Cache[17][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[17][97:66] <= DataIn;
				Cache[17][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[17][129:98] <= DataIn;
				Cache[17][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[18][33:2] <= DataIn;
				Cache[18][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[18][65:34] <= DataIn;
				Cache[18][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[18][97:66] <= DataIn;
				Cache[18][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[18][129:98] <= DataIn;
				Cache[18][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[19][33:2] <= DataIn;
				Cache[19][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[19][65:34] <= DataIn;
				Cache[19][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[19][97:66] <= DataIn;
				Cache[19][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[19][129:98] <= DataIn;
				Cache[19][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter4)
		2'b00:				begin
						counter4 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[16][144:34] <= DataFromMem[144:34];
						Cache[16][33:2] <= DataIn;
						Cache[16][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[16][144:66] <= DataFromMem[144:66];
						Cache[16][65:34] <= DataIn;
						Cache[16][33:2] <= DataFromMem[33:2];
						Cache[16][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[16][144:98] <= DataFromMem[144:98];
						Cache[16][97:66] <= DataIn;
						Cache[16][65:2] <= DataFromMem[65:2];
						Cache[16][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[16][144:130] <= DataFromMem[144:130];
						Cache[16][129:98] <= DataIn;
						Cache[16][97:2] <= DataFromMem[97:2];
						Cache[16][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter4 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[17][144:34] <= DataFromMem[144:34];
						Cache[17][33:2] <= DataIn;
						Cache[17][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[17][144:66] <= DataFromMem[144:66];
						Cache[17][65:34] <= DataIn;
						Cache[17][33:2] <= DataFromMem[33:2];
						Cache[17][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[17][144:98] <= DataFromMem[144:98];
						Cache[17][97:66] <= DataIn;
						Cache[17][65:2] <= DataFromMem[65:2];
						Cache[17][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[17][144:130] <= DataFromMem[144:130];
						Cache[17][129:98] <= DataIn;
						Cache[17][97:2] <= DataFromMem[97:2];
						Cache[17][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter4 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[18][144:34] <= DataFromMem[144:34];
						Cache[18][33:2] <= DataIn;
						Cache[18][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[18][144:66] <= DataFromMem[144:66];
						Cache[18][65:34] <= DataIn;
						Cache[18][33:2] <= DataFromMem[33:2];
						Cache[18][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[18][144:98] <= DataFromMem[144:98];
						Cache[18][97:66] <= DataIn;
						Cache[18][65:2] <= DataFromMem[65:2];
						Cache[18][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[18][144:130] <= DataFromMem[144:130];
						Cache[18][129:98] <= DataIn;
						Cache[18][97:2] <= DataFromMem[97:2];
						Cache[18][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter4 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[19][144:34] <= DataFromMem[144:34];
						Cache[19][33:2] <= DataIn;
						Cache[19][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[19][144:66] <= DataFromMem[144:66];
						Cache[19][65:34] <= DataIn;
						Cache[19][33:2] <= DataFromMem[33:2];
						Cache[19][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[19][144:98] <= DataFromMem[144:98];
						Cache[19][97:66] <= DataIn;
						Cache[19][65:2] <= DataFromMem[65:2];
						Cache[19][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[19][144:130] <= DataFromMem[144:130];
						Cache[19][129:98] <= DataIn;
						Cache[19][97:2] <= DataFromMem[97:2];
						Cache[19][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter4 = counter4;	
		end


4'b0101:	begin
		block0 <= Cache[20];
		block1 <= Cache[21];
		block2 <= Cache[22];
		block3 <= Cache[23];
		bufferindex = 4'b0101;
		if (hit === 2'b01) //Read miss
		begin
		case(counter5)
		2'b00:	begin
			buffer <= block0;
			Cache[20]<= DataFromMem;
			counter5 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[21]<= DataFromMem;
			counter5 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[22]<= DataFromMem;
			counter5 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[23]<= DataFromMem;
			counter5 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[20][33:2] <= DataIn;
				Cache[20][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[20][65:34] <= DataIn;
				Cache[20][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[20][97:66] <= DataIn;
				Cache[20][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[20][129:98] <= DataIn;
				Cache[20][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[21][33:2] <= DataIn;
				Cache[21][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[21][65:34] <= DataIn;
				Cache[21][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[21][97:66] <= DataIn;
				Cache[21][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[21][129:98] <= DataIn;
				Cache[21][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[22][33:2] <= DataIn;
				Cache[22][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[22][65:34] <= DataIn;
				Cache[22][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[22][97:66] <= DataIn;
				Cache[22][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[22][129:98] <= DataIn;
				Cache[22][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[23][33:2] <= DataIn;
				Cache[23][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[23][65:34] <= DataIn;
				Cache[23][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[23][97:66] <= DataIn;
				Cache[23][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[23][129:98] <= DataIn;
				Cache[23][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter5)
		2'b00:				begin
						counter5 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[20][144:34] <= DataFromMem[144:34];
						Cache[20][33:2] <= DataIn;
						Cache[20][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[20][144:66] <= DataFromMem[144:66];
						Cache[20][65:34] <= DataIn;
						Cache[20][33:2] <= DataFromMem[33:2];
						Cache[20][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[20][144:98] <= DataFromMem[144:98];
						Cache[20][97:66] <= DataIn;
						Cache[20][65:2] <= DataFromMem[65:2];
						Cache[20][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[20][144:130] <= DataFromMem[144:130];
						Cache[20][129:98] <= DataIn;
						Cache[20][97:2] <= DataFromMem[97:2];
						Cache[20][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter5 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[21][144:34] <= DataFromMem[144:34];
						Cache[21][33:2] <= DataIn;
						Cache[21][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[21][144:66] <= DataFromMem[144:66];
						Cache[21][65:34] <= DataIn;
						Cache[21][33:2] <= DataFromMem[33:2];
						Cache[21][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[21][144:98] <= DataFromMem[144:98];
						Cache[21][97:66] <= DataIn;
						Cache[21][65:2] <= DataFromMem[65:2];
						Cache[21][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[21][144:130] <= DataFromMem[144:130];
						Cache[21][129:98] <= DataIn;
						Cache[21][97:2] <= DataFromMem[97:2];
						Cache[21][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter5 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[22][144:34] <= DataFromMem[144:34];
						Cache[22][33:2] <= DataIn;
						Cache[22][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[22][144:66] <= DataFromMem[144:66];
						Cache[22][65:34] <= DataIn;
						Cache[22][33:2] <= DataFromMem[33:2];
						Cache[22][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[22][144:98] <= DataFromMem[144:98];
						Cache[22][97:66] <= DataIn;
						Cache[22][65:2] <= DataFromMem[65:2];
						Cache[22][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[22][144:130] <= DataFromMem[144:130];
						Cache[22][129:98] <= DataIn;
						Cache[22][97:2] <= DataFromMem[97:2];
						Cache[22][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter5 = 2'b01;
						buffer <= block3;
						case(offset)
					2'b00:	begin
						Cache[23][144:34] <= DataFromMem[144:34];
						Cache[23][33:2] <= DataIn;
						Cache[23][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[23][144:66] <= DataFromMem[144:66];
						Cache[23][65:34] <= DataIn;
						Cache[23][33:2] <= DataFromMem[33:2];
						Cache[23][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[23][144:98] <= DataFromMem[144:98];
						Cache[23][97:66] <= DataIn;
						Cache[23][65:2] <= DataFromMem[65:2];
						Cache[23][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[23][144:130] <= DataFromMem[144:130];
						Cache[23][129:98] <= DataIn;
						Cache[23][97:2] <= DataFromMem[97:2];
						Cache[23][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter5 = counter5;	
		end

4'b0110:	begin
		block0 <= Cache[24];
		block1 <= Cache[25];
		block2 <= Cache[26];
		block3 <= Cache[27];
		bufferindex = 4'b0110;
		if (hit === 2'b01) //Read miss
		begin
		case(counter6)
		2'b00:	begin
			buffer <= block0;
			Cache[24]<= DataFromMem;
			counter6 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[25]<= DataFromMem;
			counter6 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[26]<= DataFromMem;
			counter6 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[27]<= DataFromMem;
			counter6 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[24][33:2] <= DataIn;
				Cache[24][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[24][65:34] <= DataIn;
				Cache[24][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[24][97:66] <= DataIn;
				Cache[24][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[24][129:98] <= DataIn;
				Cache[24][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[25][33:2] <= DataIn;
				Cache[25][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[25][65:34] <= DataIn;
				Cache[25][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[25][97:66] <= DataIn;
				Cache[25][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[25][129:98] <= DataIn;
				Cache[25][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[26][33:2] <= DataIn;
				Cache[26][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[26][65:34] <= DataIn;
				Cache[26][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[26][97:66] <= DataIn;
				Cache[26][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[26][129:98] <= DataIn;
				Cache[26][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[27][33:2] <= DataIn;
				Cache[27][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[27][65:34] <= DataIn;
				Cache[27][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[27][97:66] <= DataIn;
				Cache[27][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[27][129:98] <= DataIn;
				Cache[27][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter6)
		2'b00:				begin
						counter6 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[24][144:34] <= DataFromMem[144:34];
						Cache[24][33:2] <= DataIn;
						Cache[24][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[24][144:66] <= DataFromMem[144:66];
						Cache[24][65:34] <= DataIn;
						Cache[24][33:2] <= DataFromMem[33:2];
						Cache[24][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[24][144:98] <= DataFromMem[144:98];
						Cache[24][97:66] <= DataIn;
						Cache[24][65:2] <= DataFromMem[65:2];
						Cache[24][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[24][144:130] <= DataFromMem[144:130];
						Cache[24][129:98] <= DataIn;
						Cache[24][97:2] <= DataFromMem[97:2];
						Cache[24][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter6 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[25][144:34] <= DataFromMem[144:34];
						Cache[25][33:2] <= DataIn;
						Cache[25][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[25][144:66] <= DataFromMem[144:66];
						Cache[25][65:34] <= DataIn;
						Cache[25][33:2] <= DataFromMem[33:2];
						Cache[25][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[25][144:98] <= DataFromMem[144:98];
						Cache[25][97:66] <= DataIn;
						Cache[25][65:2] <= DataFromMem[65:2];
						Cache[25][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[25][144:130] <= DataFromMem[144:130];
						Cache[25][129:98] <= DataIn;
						Cache[25][97:2] <= DataFromMem[97:2];
						Cache[25][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter6 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[26][144:34] <= DataFromMem[144:34];
						Cache[26][33:2] <= DataIn;
						Cache[26][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[26][144:66] <= DataFromMem[144:66];
						Cache[26][65:34] <= DataIn;
						Cache[26][33:2] <= DataFromMem[33:2];
						Cache[26][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[26][144:98] <= DataFromMem[144:98];
						Cache[26][97:66] <= DataIn;
						Cache[26][65:2] <= DataFromMem[65:2];
						Cache[26][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[26][144:130] <= DataFromMem[144:130];
						Cache[26][129:98] <= DataIn;
						Cache[26][97:2] <= DataFromMem[97:2];
						Cache[26][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter6 = 2'b01;
						buffer <= block3;
						case(offset)
					2'b00:	begin
						Cache[27][144:34] <= DataFromMem[144:34];
						Cache[27][33:2] <= DataIn;
						Cache[27][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[27][144:66] <= DataFromMem[144:66];
						Cache[27][65:34] <= DataIn;
						Cache[27][33:2] <= DataFromMem[33:2];
						Cache[27][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[27][144:98] <= DataFromMem[144:98];
						Cache[27][97:66] <= DataIn;
						Cache[27][65:2] <= DataFromMem[65:2];
						Cache[27][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[27][144:130] <= DataFromMem[144:130];
						Cache[27][129:98] <= DataIn;
						Cache[27][97:2] <= DataFromMem[97:2];
						Cache[27][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter6 = counter6;	
		end


4'b0111:	begin
		block0 <= Cache[28];
		block1 <= Cache[29];
		block2 <= Cache[30];
		block3 <= Cache[31];
		bufferindex = 4'b0111;
		if (hit === 2'b01) //Read miss
		begin
		case(counter7)
		2'b00:	begin
			buffer <= block0;
			Cache[28]<= DataFromMem;
			counter7 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[29]<= DataFromMem;
			counter7 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[30]<= DataFromMem;
			counter7 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[31]<= DataFromMem;
			counter7 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[28][33:2] <= DataIn;
				Cache[28][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[28][65:34] <= DataIn;
				Cache[28][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[28][97:66] <= DataIn;
				Cache[28][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[28][129:98] <= DataIn;
				Cache[28][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[29][33:2] <= DataIn;
				Cache[29][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[29][65:34] <= DataIn;
				Cache[29][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[29][97:66] <= DataIn;
				Cache[29][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[29][129:98] <= DataIn;
				Cache[29][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[30][33:2] <= DataIn;
				Cache[30][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[30][65:34] <= DataIn;
				Cache[30][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[30][97:66] <= DataIn;
				Cache[30][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[30][129:98] <= DataIn;
				Cache[30][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[31][33:2] <= DataIn;
				Cache[31][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[31][65:34] <= DataIn;
				Cache[31][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[31][97:66] <= DataIn;
				Cache[31][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[31][129:98] <= DataIn;
				Cache[31][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter7)
		2'b00:				begin
						counter7 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[28][144:34] <= DataFromMem[144:34];
						Cache[28][33:2] <= DataIn;
						Cache[28][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[28][144:66] <= DataFromMem[144:66];
						Cache[28][65:34] <= DataIn;
						Cache[28][33:2] <= DataFromMem[33:2];
						Cache[28][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[28][144:98] <= DataFromMem[144:98];
						Cache[28][97:66] <= DataIn;
						Cache[28][65:2] <= DataFromMem[65:2];
						Cache[28][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[28][144:130] <= DataFromMem[144:130];
						Cache[28][129:98] <= DataIn;
						Cache[28][97:2] <= DataFromMem[97:2];
						Cache[28][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter7 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[29][144:34] <= DataFromMem[144:34];
						Cache[29][33:2] <= DataIn;
						Cache[29][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[29][144:66] <= DataFromMem[144:66];
						Cache[29][65:34] <= DataIn;
						Cache[29][33:2] <= DataFromMem[33:2];
						Cache[29][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[29][144:98] <= DataFromMem[144:98];
						Cache[29][97:66] <= DataIn;
						Cache[29][65:2] <= DataFromMem[65:2];
						Cache[29][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[29][144:130] <= DataFromMem[144:130];
						Cache[29][129:98] <= DataIn;
						Cache[29][97:2] <= DataFromMem[97:2];
						Cache[29][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter7 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[30][144:34] <= DataFromMem[144:34];
						Cache[30][33:2] <= DataIn;
						Cache[30][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[30][144:66] <= DataFromMem[144:66];
						Cache[30][65:34] <= DataIn;
						Cache[30][33:2] <= DataFromMem[33:2];
						Cache[30][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[30][144:98] <= DataFromMem[144:98];
						Cache[30][97:66] <= DataIn;
						Cache[30][65:2] <= DataFromMem[65:2];
						Cache[30][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[30][144:130] <= DataFromMem[144:130];
						Cache[30][129:98] <= DataIn;
						Cache[30][97:2] <= DataFromMem[97:2];
						Cache[30][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter7 = 2'b01;
						buffer <= block3;
						case(offset)
					2'b00:	begin
						Cache[31][144:34] <= DataFromMem[144:34];
						Cache[31][33:2] <= DataIn;
						Cache[31][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[31][144:66] <= DataFromMem[144:66];
						Cache[31][65:34] <= DataIn;
						Cache[31][33:2] <= DataFromMem[33:2];
						Cache[31][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[31][144:98] <= DataFromMem[144:98];
						Cache[31][97:66] <= DataIn;
						Cache[31][65:2] <= DataFromMem[65:2];
						Cache[31][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[31][144:130] <= DataFromMem[144:130];
						Cache[31][129:98] <= DataIn;
						Cache[31][97:2] <= DataFromMem[97:2];
						Cache[31][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter7 = counter7;	
		end


		
4'b1000:	begin
		block0 <= Cache[32];
		block1 <= Cache[33];
		block2 <= Cache[34];
		block3 <= Cache[35];
		bufferindex = 4'b1000;
		if (hit === 2'b01) //Read miss
		begin
		case(counter8)
		2'b00:	begin
			buffer <= block0;
			Cache[32]<= DataFromMem;
			counter8 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[33]<= DataFromMem;
			counter8 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[34]<= DataFromMem;
			counter8 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[35]<= DataFromMem;
			counter8 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[32][33:2] <= DataIn;
				Cache[32][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[32][65:34] <= DataIn;
				Cache[32][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[32][97:66] <= DataIn;
				Cache[32][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[32][129:98] <= DataIn;
				Cache[32][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[33][33:2] <= DataIn;
				Cache[33][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[33][65:34] <= DataIn;
				Cache[33][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[33][97:66] <= DataIn;
				Cache[33][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[33][129:98] <= DataIn;
				Cache[33][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[34][33:2] <= DataIn;
				Cache[34][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[34][65:34] <= DataIn;
				Cache[34][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[34][97:66] <= DataIn;
				Cache[34][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[34][129:98] <= DataIn;
				Cache[34][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[35][33:2] <= DataIn;
				Cache[35][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[35][65:34] <= DataIn;
				Cache[35][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[35][97:66] <= DataIn;
				Cache[35][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[35][129:98] <= DataIn;
				Cache[35][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter8)
		2'b00:				begin
						counter8 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[32][144:34] <= DataFromMem[144:34];
						Cache[32][33:2] <= DataIn;
						Cache[32][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[32][144:66] <= DataFromMem[144:66];
						Cache[32][65:34] <= DataIn;
						Cache[32][33:2] <= DataFromMem[33:2];
						Cache[32][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[32][144:98] <= DataFromMem[144:98];
						Cache[32][97:66] <= DataIn;
						Cache[32][65:2] <= DataFromMem[65:2];
						Cache[32][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[32][144:130] <= DataFromMem[144:130];
						Cache[32][129:98] <= DataIn;
						Cache[32][97:2] <= DataFromMem[97:2];
						Cache[32][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter8 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[33][144:34] <= DataFromMem[144:34];
						Cache[33][33:2] <= DataIn;
						Cache[33][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[33][144:66] <= DataFromMem[144:66];
						Cache[33][65:34] <= DataIn;
						Cache[33][33:2] <= DataFromMem[33:2];
						Cache[33][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[33][144:98] <= DataFromMem[144:98];
						Cache[33][97:66] <= DataIn;
						Cache[33][65:2] <= DataFromMem[65:2];
						Cache[33][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[33][144:130] <= DataFromMem[144:130];
						Cache[33][129:98] <= DataIn;
						Cache[33][97:2] <= DataFromMem[97:2];
						Cache[33][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter8 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[34][144:34] <= DataFromMem[144:34];
						Cache[34][33:2] <= DataIn;
						Cache[34][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[34][144:66] <= DataFromMem[144:66];
						Cache[34][65:34] <= DataIn;
						Cache[34][33:2] <= DataFromMem[33:2];
						Cache[34][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[34][144:98] <= DataFromMem[144:98];
						Cache[34][97:66] <= DataIn;
						Cache[34][65:2] <= DataFromMem[65:2];
						Cache[34][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[34][144:130] <= DataFromMem[144:130];
						Cache[34][129:98] <= DataIn;
						Cache[34][97:2] <= DataFromMem[97:2];
						Cache[34][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter8 = 2'b01;
						buffer <= block3;
						case(offset)
					2'b00:	begin
						Cache[35][144:34] <= DataFromMem[144:34];
						Cache[35][33:2] <= DataIn;
						Cache[35][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[35][144:66] <= DataFromMem[144:66];
						Cache[35][65:34] <= DataIn;
						Cache[35][33:2] <= DataFromMem[33:2];
						Cache[35][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[35][144:98] <= DataFromMem[144:98];
						Cache[35][97:66] <= DataIn;
						Cache[35][65:2] <= DataFromMem[65:2];
						Cache[35][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[35][144:130] <= DataFromMem[144:130];
						Cache[35][129:98] <= DataIn;
						Cache[35][97:2] <= DataFromMem[97:2];
						Cache[35][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter8 = counter8;	
		end





4'b1001:	begin
		block0 <= Cache[36];
		block1 <= Cache[37];
		block2 <= Cache[38];
		block3 <= Cache[39];
		bufferindex = 4'b1001;
		if (hit === 2'b01) //Read miss
		begin
		case(counter9)
		2'b00:	begin
			buffer <= block0;
			Cache[36]<= DataFromMem;
			counter9 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[37]<= DataFromMem;
			counter9 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[38]<= DataFromMem;
			counter9 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[39]<= DataFromMem;
			counter9 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10 & DataFromMem != 145'hFFFFFFFFFFFFFFF) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[36][33:2] <= DataIn;
				Cache[36][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[36][65:34] <= DataIn;
				Cache[36][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[36][97:66] <= DataIn;
				Cache[36][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[36][129:98] <= DataIn;
				Cache[36][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[37][33:2] <= DataIn;
				Cache[37][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[37][65:34] <= DataIn;
				Cache[37][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[37][97:66] <= DataIn;
				Cache[37][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[37][129:98] <= DataIn;
				Cache[37][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[38][33:2] <= DataIn;
				Cache[38][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[38][65:34] <= DataIn;
				Cache[38][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[38][97:66] <= DataIn;
				Cache[38][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[38][129:98] <= DataIn;
				Cache[38][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[39][33:2] <= DataIn;
				Cache[39][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[39][65:34] <= DataIn;
				Cache[39][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[39][97:66] <= DataIn;
				Cache[39][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[39][129:98] <= DataIn;
				Cache[39][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter9)
		2'b00:				begin
						counter9 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[36][144:34] <= DataFromMem[144:34];
						Cache[36][33:2] <= DataIn;
						Cache[36][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[36][144:66] <= DataFromMem[144:66];
						Cache[36][65:34] <= DataIn;
						Cache[36][33:2] <= DataFromMem[33:2];
						Cache[36][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[36][144:98] <= DataFromMem[144:98];
						Cache[36][97:66] <= DataIn;
						Cache[36][65:2] <= DataFromMem[65:2];
						Cache[36][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[36][144:130] <= DataFromMem[144:130];
						Cache[36][129:98] <= DataIn;
						Cache[36][97:2] <= DataFromMem[97:2];
						Cache[36][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter9 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[37][144:34] <= DataFromMem[144:34];
						Cache[37][33:2] <= DataIn;
						Cache[37][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[37][144:66] <= DataFromMem[144:66];
						Cache[37][65:34] <= DataIn;
						Cache[37][33:2] <= DataFromMem[33:2];
						Cache[37][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[37][144:98] <= DataFromMem[144:98];
						Cache[37][97:66] <= DataIn;
						Cache[37][65:2] <= DataFromMem[65:2];
						Cache[37][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[37][144:130] <= DataFromMem[144:130];
						Cache[37][129:98] <= DataIn;
						Cache[37][97:2] <= DataFromMem[97:2];
						Cache[37][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter9 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[38][144:34] <= DataFromMem[144:34];
						Cache[38][33:2] <= DataIn;
						Cache[38][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[38][144:66] <= DataFromMem[144:66];
						Cache[38][65:34] <= DataIn;
						Cache[38][33:2] <= DataFromMem[33:2];
						Cache[38][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[38][144:98] <= DataFromMem[144:98];
						Cache[38][97:66] <= DataIn;
						Cache[38][65:2] <= DataFromMem[65:2];
						Cache[38][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[38][144:130] <= DataFromMem[144:130];
						Cache[38][129:98] <= DataIn;
						Cache[38][97:2] <= DataFromMem[97:2];
						Cache[38][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter9 = 2'b01;
						buffer <= block3;
						case(offset)
					2'b00:	begin
						Cache[39][144:34] <= DataFromMem[144:34];
						Cache[39][33:2] <= DataIn;
						Cache[39][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[39][144:66] <= DataFromMem[144:66];
						Cache[39][65:34] <= DataIn;
						Cache[39][33:2] <= DataFromMem[33:2];
						Cache[39][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[39][144:98] <= DataFromMem[144:98];
						Cache[39][97:66] <= DataIn;
						Cache[39][65:2] <= DataFromMem[65:2];
						Cache[39][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[39][144:130] <= DataFromMem[144:130];
						Cache[39][129:98] <= DataIn;
						Cache[39][97:2] <= DataFromMem[97:2];
						Cache[39][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter9 = counter9;	
		end




4'b1010:	begin
		block0 <= Cache[40];
		block1 <= Cache[41];
		block2 <= Cache[42];
		block3 <= Cache[43];
		bufferindex = 4'b1010;
		if (hit === 2'b01) //Read miss
		begin
		case(counter10)
		2'b00:	begin
			buffer <= block0;
			Cache[40]<= DataFromMem;
			counter10 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[41]<= DataFromMem;
			counter10 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[42]<= DataFromMem;
			counter10 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[43]<= DataFromMem;
			counter10 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10 & DataFromMem != 145'hFFFFFFFFFFFFFFF) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[40][33:2] <= DataIn;
				Cache[40][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[40][65:34] <= DataIn;
				Cache[40][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[40][97:66] <= DataIn;
				Cache[40][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[40][129:98] <= DataIn;
				Cache[40][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[41][33:2] <= DataIn;
				Cache[41][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[41][65:34] <= DataIn;
				Cache[41][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[41][97:66] <= DataIn;
				Cache[41][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[41][129:98] <= DataIn;
				Cache[41][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[42][33:2] <= DataIn;
				Cache[42][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[42][65:34] <= DataIn;
				Cache[42][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[42][97:66] <= DataIn;
				Cache[42][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[42][129:98] <= DataIn;
				Cache[42][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[43][33:2] <= DataIn;
				Cache[43][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[43][65:34] <= DataIn;
				Cache[43][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[43][97:66] <= DataIn;
				Cache[43][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[43][129:98] <= DataIn;
				Cache[43][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter10)
		2'b00:				begin
						counter10 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[40][144:34] <= DataFromMem[144:34];
						Cache[40][33:2] <= DataIn;
						Cache[40][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[40][144:66] <= DataFromMem[144:66];
						Cache[40][65:34] <= DataIn;
						Cache[40][33:2] <= DataFromMem[33:2];
						Cache[40][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[40][144:98] <= DataFromMem[144:98];
						Cache[40][97:66] <= DataIn;
						Cache[40][65:2] <= DataFromMem[65:2];
						Cache[40][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[40][144:130] <= DataFromMem[144:130];
						Cache[40][129:98] <= DataIn;
						Cache[40][97:2] <= DataFromMem[97:2];
						Cache[40][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter10 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[41][144:34] <= DataFromMem[144:34];
						Cache[41][33:2] <= DataIn;
						Cache[41][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[41][144:66] <= DataFromMem[144:66];
						Cache[41][65:34] <= DataIn;
						Cache[41][33:2] <= DataFromMem[33:2];
						Cache[41][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[41][144:98] <= DataFromMem[144:98];
						Cache[41][97:66] <= DataIn;
						Cache[41][65:2] <= DataFromMem[65:2];
						Cache[41][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[41][144:130] <= DataFromMem[144:130];
						Cache[41][129:98] <= DataIn;
						Cache[41][97:2] <= DataFromMem[97:2];
						Cache[41][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter10 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[42][144:34] <= DataFromMem[144:34];
						Cache[42][33:2] <= DataIn;
						Cache[42][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[42][144:66] <= DataFromMem[144:66];
						Cache[42][65:34] <= DataIn;
						Cache[42][33:2] <= DataFromMem[33:2];
						Cache[42][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[42][144:98] <= DataFromMem[144:98];
						Cache[42][97:66] <= DataIn;
						Cache[42][65:2] <= DataFromMem[65:2];
						Cache[42][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[42][144:130] <= DataFromMem[144:130];
						Cache[42][129:98] <= DataIn;
						Cache[42][97:2] <= DataFromMem[97:2];
						Cache[42][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter10 = 2'b01;
						buffer <= block3;
						case(offset)
					2'b00:	begin
						Cache[43][144:34] <= DataFromMem[144:34];
						Cache[43][33:2] <= DataIn;
						Cache[43][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[43][144:66] <= DataFromMem[144:66];
						Cache[43][65:34] <= DataIn;
						Cache[43][33:2] <= DataFromMem[33:2];
						Cache[43][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[43][144:98] <= DataFromMem[144:98];
						Cache[43][97:66] <= DataIn;
						Cache[43][65:2] <= DataFromMem[65:2];
						Cache[43][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[43][144:130] <= DataFromMem[144:130];
						Cache[43][129:98] <= DataIn;
						Cache[43][97:2] <= DataFromMem[97:2];
						Cache[43][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter10 = counter10;	
		end

4'b1011:	begin
		block0 <= Cache[44];
		block1 <= Cache[45];
		block2 <= Cache[46];
		block3 <= Cache[47];
		bufferindex = 4'b1011;
		if (hit === 2'b01) //Read miss
		begin
		case(counter11)
		2'b00:	begin
			buffer <= block0;
			Cache[44]<= DataFromMem;
			counter11 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[45]<= DataFromMem;
			counter11 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[46]<= DataFromMem;
			counter11 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[47]<= DataFromMem;
			counter11 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10 & DataFromMem != 145'hFFFFFFFFFFFFFFF) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[44][33:2] <= DataIn;
				Cache[44][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[44][65:34] <= DataIn;
				Cache[44][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[44][97:66] <= DataIn;
				Cache[44][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[44][129:98] <= DataIn;
				Cache[44][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[45][33:2] <= DataIn;
				Cache[45][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[45][65:34] <= DataIn;
				Cache[45][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[45][97:66] <= DataIn;
				Cache[45][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[45][129:98] <= DataIn;
				Cache[45][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[46][33:2] <= DataIn;
				Cache[46][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[46][65:34] <= DataIn;
				Cache[46][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[46][97:66] <= DataIn;
				Cache[46][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[46][129:98] <= DataIn;
				Cache[46][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[47][33:2] <= DataIn;
				Cache[47][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[47][65:34] <= DataIn;
				Cache[47][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[47][97:66] <= DataIn;
				Cache[47][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[47][129:98] <= DataIn;
				Cache[47][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter11)
		2'b00:				begin
						counter11 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[44][144:34] <= DataFromMem[144:34];
						Cache[44][33:2] <= DataIn;
						Cache[44][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[44][144:66] <= DataFromMem[144:66];
						Cache[44][65:34] <= DataIn;
						Cache[44][33:2] <= DataFromMem[33:2];
						Cache[44][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[44][144:98] <= DataFromMem[144:98];
						Cache[44][97:66] <= DataIn;
						Cache[44][65:2] <= DataFromMem[65:2];
						Cache[44][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[44][144:130] <= DataFromMem[144:130];
						Cache[44][129:98] <= DataIn;
						Cache[44][97:2] <= DataFromMem[97:2];
						Cache[44][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter11 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[45][144:34] <= DataFromMem[144:34];
						Cache[45][33:2] <= DataIn;
						Cache[45][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[45][144:66] <= DataFromMem[144:66];
						Cache[45][65:34] <= DataIn;
						Cache[45][33:2] <= DataFromMem[33:2];
						Cache[45][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[45][144:98] <= DataFromMem[144:98];
						Cache[45][97:66] <= DataIn;
						Cache[45][65:2] <= DataFromMem[65:2];
						Cache[45][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[45][144:130] <= DataFromMem[144:130];
						Cache[45][129:98] <= DataIn;
						Cache[45][97:2] <= DataFromMem[97:2];
						Cache[45][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter11 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[46][144:34] <= DataFromMem[144:34];
						Cache[46][33:2] <= DataIn;
						Cache[46][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[46][144:66] <= DataFromMem[144:66];
						Cache[46][65:34] <= DataIn;
						Cache[46][33:2] <= DataFromMem[33:2];
						Cache[46][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[46][144:98] <= DataFromMem[144:98];
						Cache[46][97:66] <= DataIn;
						Cache[46][65:2] <= DataFromMem[65:2];
						Cache[46][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[46][144:130] <= DataFromMem[144:130];
						Cache[46][129:98] <= DataIn;
						Cache[46][97:2] <= DataFromMem[97:2];
						Cache[46][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter11 = 2'b01;
						buffer <= block3;
						case(offset)
					2'b00:	begin
						Cache[47][144:34] <= DataFromMem[144:34];
						Cache[47][33:2] <= DataIn;
						Cache[47][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[47][144:66] <= DataFromMem[144:66];
						Cache[47][65:34] <= DataIn;
						Cache[47][33:2] <= DataFromMem[33:2];
						Cache[47][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[47][144:98] <= DataFromMem[144:98];
						Cache[47][97:66] <= DataIn;
						Cache[47][65:2] <= DataFromMem[65:2];
						Cache[47][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[47][144:130] <= DataFromMem[144:130];
						Cache[47][129:98] <= DataIn;
						Cache[47][97:2] <= DataFromMem[97:2];
						Cache[47][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter11 = counter11;	
		end



4'b1100:	begin
		block0 <= Cache[48];
		block1 <= Cache[49];
		block2 <= Cache[50];
		block3 <= Cache[51];
		bufferindex = 4'b1100;
		if (hit === 2'b01) //Read miss
		begin
		case(counter12)
		2'b00:	begin
			buffer <= block0;
			Cache[48]<= DataFromMem;
			counter12 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[49]<= DataFromMem;
			counter12 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[50]<= DataFromMem;
			counter12 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[51]<= DataFromMem;
			counter12 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10 & DataFromMem != 145'hFFFFFFFFFFFFFFF) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[48][33:2] <= DataIn;
				Cache[48][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[48][65:34] <= DataIn;
				Cache[48][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[48][97:66] <= DataIn;
				Cache[48][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[48][129:98] <= DataIn;
				Cache[48][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[49][33:2] <= DataIn;
				Cache[49][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[49][65:34] <= DataIn;
				Cache[49][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[49][97:66] <= DataIn;
				Cache[49][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[49][129:98] <= DataIn;
				Cache[49][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[50][33:2] <= DataIn;
				Cache[50][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[50][65:34] <= DataIn;
				Cache[50][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[50][97:66] <= DataIn;
				Cache[50][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[50][129:98] <= DataIn;
				Cache[50][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[51][33:2] <= DataIn;
				Cache[51][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[51][65:34] <= DataIn;
				Cache[51][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[51][97:66] <= DataIn;
				Cache[51][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[51][129:98] <= DataIn;
				Cache[51][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter12)
		2'b00:				begin
						counter12 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[48][144:34] <= DataFromMem[144:34];
						Cache[48][33:2] <= DataIn;
						Cache[48][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[48][144:66] <= DataFromMem[144:66];
						Cache[48][65:34] <= DataIn;
						Cache[48][33:2] <= DataFromMem[33:2];
						Cache[48][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[48][144:98] <= DataFromMem[144:98];
						Cache[48][97:66] <= DataIn;
						Cache[48][65:2] <= DataFromMem[65:2];
						Cache[48][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[48][144:130] <= DataFromMem[144:130];
						Cache[48][129:98] <= DataIn;
						Cache[48][97:2] <= DataFromMem[97:2];
						Cache[48][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter12 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[49][144:34] <= DataFromMem[144:34];
						Cache[49][33:2] <= DataIn;
						Cache[49][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[49][144:66] <= DataFromMem[144:66];
						Cache[49][65:34] <= DataIn;
						Cache[49][33:2] <= DataFromMem[33:2];
						Cache[49][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[49][144:98] <= DataFromMem[144:98];
						Cache[49][97:66] <= DataIn;
						Cache[49][65:2] <= DataFromMem[65:2];
						Cache[49][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[49][144:130] <= DataFromMem[144:130];
						Cache[49][129:98] <= DataIn;
						Cache[49][97:2] <= DataFromMem[97:2];
						Cache[49][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter12 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[50][144:34] <= DataFromMem[144:34];
						Cache[50][33:2] <= DataIn;
						Cache[50][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[50][144:66] <= DataFromMem[144:66];
						Cache[50][65:34] <= DataIn;
						Cache[50][33:2] <= DataFromMem[33:2];
						Cache[50][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[50][144:98] <= DataFromMem[144:98];
						Cache[50][97:66] <= DataIn;
						Cache[50][65:2] <= DataFromMem[65:2];
						Cache[50][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[50][144:130] <= DataFromMem[144:130];
						Cache[50][129:98] <= DataIn;
						Cache[50][97:2] <= DataFromMem[97:2];
						Cache[50][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter12 = 2'b01;
						buffer <= block3;
						case(offset)
					2'b00:	begin
						Cache[51][144:34] <= DataFromMem[144:34];
						Cache[51][33:2] <= DataIn;
						Cache[51][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[51][144:66] <= DataFromMem[144:66];
						Cache[51][65:34] <= DataIn;
						Cache[51][33:2] <= DataFromMem[33:2];
						Cache[51][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[51][144:98] <= DataFromMem[144:98];
						Cache[51][97:66] <= DataIn;
						Cache[51][65:2] <= DataFromMem[65:2];
						Cache[51][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[51][144:130] <= DataFromMem[144:130];
						Cache[51][129:98] <= DataIn;
						Cache[51][97:2] <= DataFromMem[97:2];
						Cache[51][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter12 = counter12;	
		end

4'b1101:	begin
		block0 <= Cache[52];
		block1 <= Cache[53];
		block2 <= Cache[54];
		block3 <= Cache[55];
		bufferindex = 4'b1101;
		if (hit === 2'b01) //Read miss
		begin
		case(counter13)
		2'b00:	begin
			buffer <= block0;
			Cache[52]<= DataFromMem;
			counter13 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[53]<= DataFromMem;
			counter13 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[54]<= DataFromMem;
			counter13 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[55]<= DataFromMem;
			counter13 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10 & DataFromMem != 145'hFFFFFFFFFFFFFFF) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[52][33:2] <= DataIn;
				Cache[52][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[52][65:34] <= DataIn;
				Cache[52][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[52][97:66] <= DataIn;
				Cache[52][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[52][129:98] <= DataIn;
				Cache[52][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[53][33:2] <= DataIn;
				Cache[53][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[53][65:34] <= DataIn;
				Cache[53][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[53][97:66] <= DataIn;
				Cache[53][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[53][129:98] <= DataIn;
				Cache[53][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[54][33:2] <= DataIn;
				Cache[54][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[54][65:34] <= DataIn;
				Cache[54][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[54][97:66] <= DataIn;
				Cache[54][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[54][129:98] <= DataIn;
				Cache[54][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[55][33:2] <= DataIn;
				Cache[55][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[55][65:34] <= DataIn;
				Cache[55][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[55][97:66] <= DataIn;
				Cache[55][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[55][129:98] <= DataIn;
				Cache[55][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter13)
		2'b00:				begin
						counter13 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[52][144:34] <= DataFromMem[144:34];
						Cache[52][33:2] <= DataIn;
						Cache[52][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[52][144:66] <= DataFromMem[144:66];
						Cache[52][65:34] <= DataIn;
						Cache[52][33:2] <= DataFromMem[33:2];
						Cache[52][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[52][144:98] <= DataFromMem[144:98];
						Cache[52][97:66] <= DataIn;
						Cache[52][65:2] <= DataFromMem[65:2];
						Cache[52][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[52][144:130] <= DataFromMem[144:130];
						Cache[52][129:98] <= DataIn;
						Cache[52][97:2] <= DataFromMem[97:2];
						Cache[52][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter13 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[53][144:34] <= DataFromMem[144:34];
						Cache[53][33:2] <= DataIn;
						Cache[53][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[53][144:66] <= DataFromMem[144:66];
						Cache[53][65:34] <= DataIn;
						Cache[53][33:2] <= DataFromMem[33:2];
						Cache[53][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[53][144:98] <= DataFromMem[144:98];
						Cache[53][97:66] <= DataIn;
						Cache[53][65:2] <= DataFromMem[65:2];
						Cache[53][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[53][144:130] <= DataFromMem[144:130];
						Cache[53][129:98] <= DataIn;
						Cache[53][97:2] <= DataFromMem[97:2];
						Cache[53][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter13 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[54][144:34] <= DataFromMem[144:34];
						Cache[54][33:2] <= DataIn;
						Cache[54][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[54][144:66] <= DataFromMem[144:66];
						Cache[54][65:34] <= DataIn;
						Cache[54][33:2] <= DataFromMem[33:2];
						Cache[54][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[54][144:98] <= DataFromMem[144:98];
						Cache[54][97:66] <= DataIn;
						Cache[54][65:2] <= DataFromMem[65:2];
						Cache[54][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[54][144:130] <= DataFromMem[144:130];
						Cache[54][129:98] <= DataIn;
						Cache[54][97:2] <= DataFromMem[97:2];
						Cache[54][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter13 = 2'b01;
						buffer <= block3;
						case(offset)
					2'b00:	begin
						Cache[55][144:34] <= DataFromMem[144:34];
						Cache[55][33:2] <= DataIn;
						Cache[55][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[55][144:66] <= DataFromMem[144:66];
						Cache[55][65:34] <= DataIn;
						Cache[55][33:2] <= DataFromMem[33:2];
						Cache[55][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[55][144:98] <= DataFromMem[144:98];
						Cache[55][97:66] <= DataIn;
						Cache[55][65:2] <= DataFromMem[65:2];
						Cache[55][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[55][144:130] <= DataFromMem[144:130];
						Cache[55][129:98] <= DataIn;
						Cache[55][97:2] <= DataFromMem[97:2];
						Cache[55][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter13 = counter13;	
		end


4'b1110:	begin
		block0 <= Cache[56];
		block1 <= Cache[57];
		block2 <= Cache[58];
		block3 <= Cache[59];
		bufferindex = 4'b1110;
		if (hit === 2'b01) //Read miss
		begin
		case(counter14)
		2'b00:	begin
			buffer <= block0;
			Cache[56]<= DataFromMem;
			counter14 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[57]<= DataFromMem;
			counter14 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[58]<= DataFromMem;
			counter14 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[59]<= DataFromMem;
			counter14 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10 & DataFromMem != 145'hFFFFFFFFFFFFFFF) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[56][33:2] <= DataIn;
				Cache[56][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[56][65:34] <= DataIn;
				Cache[56][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[56][97:66] <= DataIn;
				Cache[56][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[56][129:98] <= DataIn;
				Cache[56][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[57][33:2] <= DataIn;
				Cache[57][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[57][65:34] <= DataIn;
				Cache[57][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[57][97:66] <= DataIn;
				Cache[57][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[57][129:98] <= DataIn;
				Cache[57][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[58][33:2] <= DataIn;
				Cache[58][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[58][65:34] <= DataIn;
				Cache[58][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[58][97:66] <= DataIn;
				Cache[58][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[58][129:98] <= DataIn;
				Cache[58][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[59][33:2] <= DataIn;
				Cache[59][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[59][65:34] <= DataIn;
				Cache[59][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[59][97:66] <= DataIn;
				Cache[59][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[59][129:98] <= DataIn;
				Cache[59][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter14)
		2'b00:				begin
						counter14 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[56][144:34] <= DataFromMem[144:34];
						Cache[56][33:2] <= DataIn;
						Cache[56][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[56][144:66] <= DataFromMem[144:66];
						Cache[56][65:34] <= DataIn;
						Cache[56][33:2] <= DataFromMem[33:2];
						Cache[56][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[56][144:98] <= DataFromMem[144:98];
						Cache[56][97:66] <= DataIn;
						Cache[56][65:2] <= DataFromMem[65:2];
						Cache[56][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[56][144:130] <= DataFromMem[144:130];
						Cache[56][129:98] <= DataIn;
						Cache[56][97:2] <= DataFromMem[97:2];
						Cache[56][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter14 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[57][144:34] <= DataFromMem[144:34];
						Cache[57][33:2] <= DataIn;
						Cache[57][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[57][144:66] <= DataFromMem[144:66];
						Cache[57][65:34] <= DataIn;
						Cache[57][33:2] <= DataFromMem[33:2];
						Cache[57][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[57][144:98] <= DataFromMem[144:98];
						Cache[57][97:66] <= DataIn;
						Cache[57][65:2] <= DataFromMem[65:2];
						Cache[57][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[57][144:130] <= DataFromMem[144:130];
						Cache[57][129:98] <= DataIn;
						Cache[57][97:2] <= DataFromMem[97:2];
						Cache[57][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter14 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[58][144:34] <= DataFromMem[144:34];
						Cache[58][33:2] <= DataIn;
						Cache[58][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[58][144:66] <= DataFromMem[144:66];
						Cache[58][65:34] <= DataIn;
						Cache[58][33:2] <= DataFromMem[33:2];
						Cache[58][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[58][144:98] <= DataFromMem[144:98];
						Cache[58][97:66] <= DataIn;
						Cache[58][65:2] <= DataFromMem[65:2];
						Cache[58][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[58][144:130] <= DataFromMem[144:130];
						Cache[58][129:98] <= DataIn;
						Cache[58][97:2] <= DataFromMem[97:2];
						Cache[58][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter14 = 2'b01;
						buffer <= block3;
						case(offset)
					2'b00:	begin
						Cache[59][144:34] <= DataFromMem[144:34];
						Cache[59][33:2] <= DataIn;
						Cache[59][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[59][144:66] <= DataFromMem[144:66];
						Cache[59][65:34] <= DataIn;
						Cache[59][33:2] <= DataFromMem[33:2];
						Cache[59][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[59][144:98] <= DataFromMem[144:98];
						Cache[59][97:66] <= DataIn;
						Cache[59][65:2] <= DataFromMem[65:2];
						Cache[59][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[59][144:130] <= DataFromMem[144:130];
						Cache[59][129:98] <= DataIn;
						Cache[59][97:2] <= DataFromMem[97:2];
						Cache[59][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter14 = counter14;	
		end

4'b1111:	begin
		block0 <= Cache[60];
		block1 <= Cache[61];
		block2 <= Cache[62];
		block3 <= Cache[63];
		bufferindex = 4'b1111;
		if (hit === 2'b01) //Read miss
		begin
		case(counter15)
		2'b00:	begin
			buffer <= block0;
			Cache[60]<= DataFromMem;
			counter15 = 2'b01;
			end
		2'b01: 	begin
			buffer <= block1;
			Cache[61]<= DataFromMem;
			counter15 = 2'b10;
			end
		2'b10:	begin
			buffer <= block2;
			Cache[62]<= DataFromMem;
			counter15 = 2'b11;
			end
		2'b11:	begin
			buffer <= block3;
			Cache[63]<= DataFromMem;
			counter15 = 2'b00;
			end
		endcase
		end
		else if (hit === 2'b10 & DataFromMem != 145'hFFFFFFFFFFFFFFF) //Write hit
		begin
		if(block0[144:130] === tag)
		begin
		buffer <= block0;
		case(offset)
			2'b00:	begin
				Cache[60][33:2] <= DataIn;
				Cache[60][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[60][65:34] <= DataIn;
				Cache[60][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[60][97:66] <= DataIn;
				Cache[60][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[60][129:98] <= DataIn;
				Cache[60][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block1[144:130] === tag)
		begin
		buffer <= block1;
		case(offset)
			2'b00:	begin
				Cache[61][33:2] <= DataIn;
				Cache[61][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[61][65:34] <= DataIn;
				Cache[61][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[61][97:66] <= DataIn;
				Cache[61][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[61][129:98] <= DataIn;
				Cache[61][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block2[144:130] === tag)
		begin
		buffer <= block2;
		case(offset)
			2'b00:	begin
				Cache[62][33:2] <= DataIn;
				Cache[62][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[62][65:34] <= DataIn;
				Cache[62][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[62][97:66] <= DataIn;
				Cache[62][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[62][129:98] <= DataIn;
				Cache[62][1:0] <= 2'b11;
				end
		endcase
		end
		
		else if(block3[144:130] === tag)
		begin
		buffer <= block3;
		case(offset)
			2'b00:	begin
				Cache[63][33:2] <= DataIn;
				Cache[63][1:0] <= 2'b11;
				end
			2'b01:	begin
				Cache[63][65:34] <= DataIn;
				Cache[63][1:0] <= 2'b11;
				end
			2'b10: 	begin
				Cache[63][97:66] <= DataIn;
				Cache[63][1:0] <= 2'b11;
				end
			2'b11:	begin
				Cache[63][129:98] <= DataIn;
				Cache[63][1:0] <= 2'b11;
				end
		endcase
		end

		end
		else if(hit === 2'b00) //Write miss
		begin
		case(counter15)
		2'b00:				begin
						counter15 = 2'b01;
						buffer <= block0;
						case(offset)
					2'b00:	begin
						Cache[60][144:34] <= DataFromMem[144:34];
						Cache[60][33:2] <= DataIn;
						Cache[60][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[60][144:66] <= DataFromMem[144:66];
						Cache[60][65:34] <= DataIn;
						Cache[60][33:2] <= DataFromMem[33:2];
						Cache[60][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[60][144:98] <= DataFromMem[144:98];
						Cache[60][97:66] <= DataIn;
						Cache[60][65:2] <= DataFromMem[65:2];
						Cache[60][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[60][144:130] <= DataFromMem[144:130];
						Cache[60][129:98] <= DataIn;
						Cache[60][97:2] <= DataFromMem[97:2];
						Cache[60][1:0] <= 2'b11;
						end
						endcase
						end

		2'b01:				begin
						counter15 = 2'b10;
						buffer <= block1;
						case(offset)
					2'b00:	begin
						Cache[61][144:34] <= DataFromMem[144:34];
						Cache[61][33:2] <= DataIn;
						Cache[61][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[61][144:66] <= DataFromMem[144:66];
						Cache[61][65:34] <= DataIn;
						Cache[61][33:2] <= DataFromMem[33:2];
						Cache[61][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[61][144:98] <= DataFromMem[144:98];
						Cache[61][97:66] <= DataIn;
						Cache[61][65:2] <= DataFromMem[65:2];
						Cache[61][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[61][144:130] <= DataFromMem[144:130];
						Cache[61][129:98] <= DataIn;
						Cache[61][97:2] <= DataFromMem[97:2];
						Cache[61][1:0] <= 2'b11;
						end
						endcase
						end

		2'b10:				begin
						counter15 = 2'b11;
						buffer <= block2;
						case(offset)
					2'b00:	begin
						Cache[62][144:34] <= DataFromMem[144:34];
						Cache[62][33:2] <= DataIn;
						Cache[62][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[62][144:66] <= DataFromMem[144:66];
						Cache[62][65:34] <= DataIn;
						Cache[62][33:2] <= DataFromMem[33:2];
						Cache[62][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[62][144:98] <= DataFromMem[144:98];
						Cache[62][97:66] <= DataIn;
						Cache[62][65:2] <= DataFromMem[65:2];
						Cache[62][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[62][144:130] <= DataFromMem[144:130];
						Cache[62][129:98] <= DataIn;
						Cache[62][97:2] <= DataFromMem[97:2];
						Cache[62][1:0] <= 2'b11;
						end
						endcase
						end

		2'b11:				begin
						counter15 = 2'b01;
						buffer <= block3;
						case(offset)
					2'b00:	begin
						Cache[63][144:34] <= DataFromMem[144:34];
						Cache[63][33:2] <= DataIn;
						Cache[63][1:0] <= 2'b11;
						end
					2'b01:	begin
						Cache[63][144:66] <= DataFromMem[144:66];
						Cache[63][65:34] <= DataIn;
						Cache[63][33:2] <= DataFromMem[33:2];
						Cache[63][1:0] <= 2'b11;
						end
					2'b10: 	begin
						Cache[63][144:98] <= DataFromMem[144:98];
						Cache[63][97:66] <= DataIn;
						Cache[63][65:2] <= DataFromMem[65:2];
						Cache[63][1:0] <= 2'b11;
						end
					2'b11:	begin
						Cache[63][144:130] <= DataFromMem[144:130];
						Cache[63][129:98] <= DataIn;
						Cache[63][97:2] <= DataFromMem[97:2];
						Cache[63][1:0] <= 2'b11;
						end
						endcase
						end
		endcase
		end
		
		else // Read hit
		counter15 = counter15;	
		end
endcase
end

endmodule
