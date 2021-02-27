module DCache(clk, address, RW, DataIn, DataFromMemA, hit, DataCacheOut, request, buffer);
input [31:0] address, DataIn;
input clk, RW; // 1 Read, 0 Write 
input [159:0] DataFromMemA;
output reg[31:0] DataCacheOut, request;
output reg[1:0] hit;
output reg [159:0] buffer;
reg[2:0] bufferindex;
wire [1:0] offset;
reg [1:0] counter0, counter1, counter2, counter3, counter4, counter5, counter6, counter7;
wire [2:0] index;
wire [26:0] tag;
assign  offset = address[1:0];
assign  index = address[4:2];
assign  tag = address[31:5];
integer i;
reg [31:0] DataFromMem, DataFromMem1, DataFromMem2, DataFromMem3, DataFromMem4;


reg [31:0] Cache [0:159];
initial 
begin
counter0 <= 2'b00;
counter1 <= 2'b00;
counter2 <= 2'b00;
counter3 <= 2'b00;
counter4 <= 2'b00;
counter5 <= 2'b00;
counter6 <= 2'b00;
counter7 <= 2'b00;
	for (i=0; i<160; i=i+1)
	begin
	Cache[i] <= 32'h0;
	end
end
always @(*)
begin
case(index)
3'b000:	begin
	if (RW === 1'b1)  // Read mode
		begin
			if (Cache[0][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[0][1] === 1'b1 && Cache[0][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[1];
				2'b01:	DataCacheOut <= Cache[2];
				2'b10:	DataCacheOut <= Cache[3];
				2'b11:	DataCacheOut <= Cache[4];
				endcase
				end
			else if (Cache[5][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[5][1] === 1'b1 && Cache[5][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[6];
				2'b01:	DataCacheOut <= Cache[7];
				2'b10:	DataCacheOut <= Cache[8];
				2'b11:	DataCacheOut <= Cache[9];
				endcase
				end
			else if (Cache[10][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[10][1] === 1'b1 && Cache[10][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[11];
				2'b01:	DataCacheOut <= Cache[12];
				2'b10:	DataCacheOut <= Cache[13];
				2'b11:	DataCacheOut <= Cache[14];
				endcase
				end
			else if (Cache[15][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[15][1] === 1'b1 && Cache[15][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[16];
				2'b01:	DataCacheOut <= Cache[17];
				2'b10:	DataCacheOut <= Cache[18];
				2'b11:	DataCacheOut <= Cache[19];
				endcase
				end
			else
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end

		end
	else  // Write mode
		begin
			if (Cache[0][1] === 1'b0)
				begin
				hit <= 2'b00;
				request <= address;
				DataCacheOut <= 32'h0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[0][1] === 1'b0 && Cache[0][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[5][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[5][1] === 1'b0 && Cache[5][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[10][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[10][1] === 1'b0 && Cache[10][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[15][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[15][1] === 1'b0 && Cache[15][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
		end
	end

3'b001:	begin
	if (RW === 1'b1)  // Read mode
		begin
			if (Cache[20][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[20][1] === 1'b1 && Cache[20][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[21];
				2'b01:	DataCacheOut <= Cache[22];
				2'b10:	DataCacheOut <= Cache[23];
				2'b11:	DataCacheOut <= Cache[24];
				endcase
				end
			else if (Cache[25][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[25][1] === 1'b1 && Cache[25][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[26];
				2'b01:	DataCacheOut <= Cache[27];
				2'b10:	DataCacheOut <= Cache[28];
				2'b11:	DataCacheOut <= Cache[29];
				endcase
				end
			else if (Cache[30][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[30][1] === 1'b1 && Cache[30][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[31];
				2'b01:	DataCacheOut <= Cache[32];
				2'b10:	DataCacheOut <= Cache[33];
				2'b11:	DataCacheOut <= Cache[34];
				endcase
				end
			else if (Cache[35][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[35][1] === 1'b1 && Cache[35][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[36];
				2'b01:	DataCacheOut <= Cache[37];
				2'b10:	DataCacheOut <= Cache[38];
				2'b11:	DataCacheOut <= Cache[39];
				endcase
				end
			else
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end

		end
	else  // Write mode
		begin
			if (Cache[20][1] === 1'b0)
				begin
				hit = 2'b00;
				request <= address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[20][1] === 1'b0 && Cache[20][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[25][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[25][1] === 1'b0 && Cache[25][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[30][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[30][1] === 1'b0 && Cache[30][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[35][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[35][1] === 1'b0 && Cache[35][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
		end
	end

3'b010:	begin
	if (RW === 1'b1)  // Read mode
		begin
			if (Cache[40][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b010;
				end
			else if (Cache[40][1] === 1'b1 && Cache[40][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b010;
				case (offset)
				2'b00:	DataCacheOut <= Cache[41];
				2'b01:	DataCacheOut <= Cache[42];
				2'b10:	DataCacheOut <= Cache[43];
				2'b11:	DataCacheOut <= Cache[44];
				endcase
				end
			else if (Cache[45][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b010;
				end
			else if (Cache[45][1] === 1'b1 && Cache[45][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b010;
				case (offset)
				2'b00:	DataCacheOut <= Cache[46];
				2'b01:	DataCacheOut <= Cache[47];
				2'b10:	DataCacheOut <= Cache[48];
				2'b11:	DataCacheOut <= Cache[49];
				endcase
				end
			else if (Cache[50][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b010;
				end
			else if (Cache[50][1] === 1'b1 && Cache[50][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b010;
				case (offset)
				2'b00:	DataCacheOut <= Cache[51];
				2'b01:	DataCacheOut <= Cache[52];
				2'b10:	DataCacheOut <= Cache[53];
				2'b11:	DataCacheOut <= Cache[54];
				endcase
				end
			else if (Cache[55][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b010;
				end
			else if (Cache[55][1] === 1'b1 && Cache[55][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b010;
				case (offset)
				2'b00:	DataCacheOut <= Cache[56];
				2'b01:	DataCacheOut <= Cache[57];
				2'b10:	DataCacheOut <= Cache[58];
				2'b11:	DataCacheOut <= Cache[59];
				endcase
				end
			else
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b010;
				end

		end
	else  // Write mode
		begin
			if (Cache[40][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[40][1] === 1'b0 && Cache[40][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[45][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[45][1] === 1'b0 && Cache[45][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[50][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[50][1] === 1'b0 && Cache[50][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[55][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[55][1] === 1'b0 && Cache[55][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
		end
	end

3'b011:	begin
	if (RW === 1'b1)  // Read mode
		begin
			if (Cache[60][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[60][1] === 1'b1 && Cache[60][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[61];
				2'b01:	DataCacheOut <= Cache[62];
				2'b10:	DataCacheOut <= Cache[63];
				2'b11:	DataCacheOut <= Cache[64];
				endcase
				end
			else if (Cache[65][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[65][1] === 1'b1 && Cache[65][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[66];
				2'b01:	DataCacheOut <= Cache[67];
				2'b10:	DataCacheOut <= Cache[68];
				2'b11:	DataCacheOut <= Cache[69];
				endcase
				end
			else if (Cache[70][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[70][1] === 1'b1 && Cache[70][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[71];
				2'b01:	DataCacheOut <= Cache[72];
				2'b10:	DataCacheOut <= Cache[73];
				2'b11:	DataCacheOut <= Cache[74];
				endcase
				end
			else if (Cache[75][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[75][1] === 1'b1 && Cache[75][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[76];
				2'b01:	DataCacheOut <= Cache[77];
				2'b10:	DataCacheOut <= Cache[78];
				2'b11:	DataCacheOut <= Cache[79];
				endcase
				end
			else
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end

		end
	else  // Write mode
		begin
			if (Cache[60][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[60][1] === 1'b0 && Cache[60][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[65][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[65][1] === 1'b0 && Cache[65][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[70][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[70][1] === 1'b0 && Cache[70][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[75][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[75][1] === 1'b0 && Cache[75][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
		end
	end

3'b100:	begin
	if (RW === 1'b1)  // Read mode
		begin
			if (Cache[80][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[80][1] === 1'b1 && Cache[80][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[81];
				2'b01:	DataCacheOut <= Cache[82];
				2'b10:	DataCacheOut <= Cache[83];
				2'b11:	DataCacheOut <= Cache[84];
				endcase
				end
			else if (Cache[85][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[85][1] === 1'b1 && Cache[85][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[86];
				2'b01:	DataCacheOut <= Cache[87];
				2'b10:	DataCacheOut <= Cache[88];
				2'b11:	DataCacheOut <= Cache[89];
				endcase
				end
			else if (Cache[90][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[90][1] === 1'b1 && Cache[90][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[91];
				2'b01:	DataCacheOut <= Cache[92];
				2'b10:	DataCacheOut <= Cache[93];
				2'b11:	DataCacheOut <= Cache[94];
				endcase
				end
			else if (Cache[95][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[95][1] === 1'b1 && Cache[95][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[96];
				2'b01:	DataCacheOut <= Cache[97];
				2'b10:	DataCacheOut <= Cache[98];
				2'b11:	DataCacheOut <= Cache[99];
				endcase
				end
			else
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end

		end
	else  // Write mode
		begin
			if (Cache[80][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[80][1] === 1'b0 && Cache[80][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[85][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[85][1] === 1'b0 && Cache[85][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[90][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[90][1] === 1'b0 && Cache[90][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[95][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[95][1] === 1'b0 && Cache[95][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
		end
	end

3'b101:	begin
	if (RW === 1'b1)  // Read mode
		begin
			if (Cache[100][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[100][1] === 1'b1 && Cache[100][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[101];
				2'b01:	DataCacheOut <= Cache[102];
				2'b10:	DataCacheOut <= Cache[103];
				2'b11:	DataCacheOut <= Cache[104];
				endcase
				end
			else if (Cache[105][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[105][1] === 1'b1 && Cache[105][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[106];
				2'b01:	DataCacheOut <= Cache[107];
				2'b10:	DataCacheOut <= Cache[108];
				2'b11:	DataCacheOut <= Cache[109];
				endcase
				end
			else if (Cache[110][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[110][1] === 1'b1 && Cache[110][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[111];
				2'b01:	DataCacheOut <= Cache[112];
				2'b10:	DataCacheOut <= Cache[113];
				2'b11:	DataCacheOut <= Cache[114];
				endcase
				end
			else if (Cache[115][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[115][1] === 1'b1 && Cache[115][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[116];
				2'b01:	DataCacheOut <= Cache[117];
				2'b10:	DataCacheOut <= Cache[118];
				2'b11:	DataCacheOut <= Cache[119];
				endcase
				end
			else
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end

		end
	else  // Write mode
		begin
			if (Cache[100][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[100][1] === 1'b0 && Cache[100][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[105][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[105][1] === 1'b0 && Cache[105][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[110][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[110][1] === 1'b0 && Cache[110][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[115][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[115][1] === 1'b0 && Cache[115][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
		end
	end
3'b110:	begin
	if (RW === 1'b1)  // Read mode
		begin
			if (Cache[120][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[120][1] === 1'b1 && Cache[120][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[121];
				2'b01:	DataCacheOut <= Cache[122];
				2'b10:	DataCacheOut <= Cache[123];
				2'b11:	DataCacheOut <= Cache[124];
				endcase
				end
			else if (Cache[125][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[125][1] === 1'b1 && Cache[125][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[126];
				2'b01:	DataCacheOut <= Cache[127];
				2'b10:	DataCacheOut <= Cache[128];
				2'b11:	DataCacheOut <= Cache[129];
				endcase
				end
			else if (Cache[130][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[130][1] === 1'b1 && Cache[130][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[131];
				2'b01:	DataCacheOut <= Cache[132];
				2'b10:	DataCacheOut <= Cache[133];
				2'b11:	DataCacheOut <= Cache[134];
				endcase
				end
			else if (Cache[135][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[135][1] === 1'b1 && Cache[135][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[136];
				2'b01:	DataCacheOut <= Cache[137];
				2'b10:	DataCacheOut <= Cache[138];
				2'b11:	DataCacheOut <= Cache[139];
				endcase
				end
			else
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end

		end
	else  // Write mode
		begin
			if (Cache[120][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[120][1] === 1'b0 && Cache[120][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[125][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[125][1] === 1'b0 && Cache[125][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[130][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[130][1] === 1'b0 && Cache[130][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[135][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[135][1] === 1'b0 && Cache[135][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
		end
	end

3'b111:	begin
	if (RW === 1'b1)  // Read mode
		begin
			if (Cache[140][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[140][1] === 1'b1 && Cache[140][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[141];
				2'b01:	DataCacheOut <= Cache[142];
				2'b10:	DataCacheOut <= Cache[143];
				2'b11:	DataCacheOut <= Cache[144];
				endcase
				end
			else if (Cache[160][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[160][1] === 1'b1 && Cache[160][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[146];
				2'b01:	DataCacheOut <= Cache[147];
				2'b10:	DataCacheOut <= Cache[148];
				2'b11:	DataCacheOut <= Cache[149];
				endcase
				end
			else if (Cache[150][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[150][1] === 1'b1 && Cache[150][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[151];
				2'b01:	DataCacheOut <= Cache[152];
				2'b10:	DataCacheOut <= Cache[153];
				2'b11:	DataCacheOut <= Cache[154];
				endcase
				end
			else if (Cache[155][1] === 1'b0)
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end
			else if (Cache[155][1] === 1'b1 && Cache[155][31:5] === tag)
				begin
				hit <= 2'b11;
				request <= address;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				case (offset)
				2'b00:	DataCacheOut <= Cache[156];
				2'b01:	DataCacheOut <= Cache[157];
				2'b10:	DataCacheOut <= Cache[158];
				2'b11:	DataCacheOut <= Cache[159];
				endcase
				end
			else
				begin
				hit <= 2'b01;
				request <= address;
				DataCacheOut <= 32'd0;
				buffer <= 160'd0;
				bufferindex <= 4'b000;
				end

		end
	else  // Write mode
		begin
			if (Cache[140][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[140][1] === 1'b0 && Cache[140][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[160][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[160][1] === 1'b0 && Cache[160][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[150][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[150][1] === 1'b0 && Cache[150][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[155][1] === 1'b0)
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else if (Cache[155][1] === 1'b0 && Cache[155][31:5] === tag)
				begin
				hit = 2'b10;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
			else
				begin
				hit = 2'b00;
				request = address;
				DataCacheOut = 32'h0;
				buffer = 160'd0;
				bufferindex = 4'b000;
				end
		end
	end
endcase
end  

always @(negedge clk)
begin
DataFromMem <= DataFromMemA[159:128];
DataFromMem1 <= DataFromMemA[127:96];
DataFromMem2 <= DataFromMemA[95:64];
DataFromMem3 <= DataFromMemA[63:32];
DataFromMem4 <= DataFromMemA[31:0];
case(index)
3'b000:	begin
	if(hit === 2'b01)  // Read miss
		begin
		case(counter0)
		2'b00:	begin
			counter0 = 2'b01;
			//buffer = {Cache[0],Cache[1],Cache[2], Cache[3], Cache[4]};
			Cache[0] <= DataFromMem;
			Cache[1] <= DataFromMem1;
			Cache[2] <= DataFromMem2;
			Cache[3] <= DataFromMem3;
			Cache[4] <= DataFromMem4; 
			end
		2'b01:	begin
			counter0 = 2'b10;
			//buffer = {Cache[5],Cache[6],Cache[7], Cache[8], Cache[9]};
			Cache[5] <= DataFromMem;
			Cache[6] <= DataFromMem1;
			Cache[7] <= DataFromMem2;
			Cache[8] <= DataFromMem3;
			Cache[9] <= DataFromMem4; 
			end
		2'b10:	begin
			counter0 = 2'b11;
			//buffer = {Cache[10],Cache[11],Cache[12], Cache[13], Cache[14]};
			Cache[10] <= DataFromMem;
			Cache[11] <= DataFromMem1;
			Cache[12] <= DataFromMem2;
			Cache[13] <= DataFromMem3;
			Cache[14] <= DataFromMem4; 
			end
		2'b11:	begin
			counter0 = 2'b00;
			//buffer = {Cache[15],Cache[16],Cache[17], Cache[18], Cache[19]};
			Cache[15] <= DataFromMem;
			Cache[16] <= DataFromMem1;
			Cache[17] <= DataFromMem2;
			Cache[18] <= DataFromMem3;
			Cache[19] <= DataFromMem4; 
			end
		endcase
		end
	else if (hit === 2'b10) // Write hit
		begin
		if (Cache[0][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[1] <= DataIn;
			2'b01:	Cache[2] <= DataIn;
			2'b10:	Cache[3] <= DataIn;
			2'b11:	Cache[4] <= DataIn;
			endcase
			Cache[0][1:0] <= 2'b11;
			end
		else if (Cache[5][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[6] <= DataIn;
			2'b01:	Cache[7] <= DataIn;
			2'b10:	Cache[8] <= DataIn;
			2'b11:	Cache[9] <= DataIn;
			endcase
			Cache[5][1:0] <= 2'b11;
			end
		else if (Cache[10][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[11] <= DataIn;
			2'b01:	Cache[12] <= DataIn;
			2'b10:	Cache[13] <= DataIn;
			2'b11:	Cache[14] <= DataIn;
			endcase
			Cache[10][1:0] <= 2'b11;
			end
		else 
			begin
			case(offset)
			2'b00:	Cache[16] <= DataIn;
			2'b01:	Cache[17] <= DataIn;
			2'b10:	Cache[18] <= DataIn;
			2'b11:	Cache[19] <= DataIn;
			endcase
			Cache[15][1:0] <= 2'b11;
			end
		end
	else if (hit === 2'b00) // Write miss
		begin
		case(counter0)
		2'b00:	begin
			counter0 = 2'b01;
			//buffer = {Cache[0],Cache[1],Cache[2], Cache[3], Cache[4]};
			case(offset)
			2'b00:	begin
				Cache[0] <= DataFromMem;
				Cache[0][1:0] <= 2'b11;			
				Cache[1] <= DataIn;
				Cache[2] <= DataFromMem2;
				Cache[3] <= DataFromMem3;
				Cache[4] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[0] <= DataFromMem;
				Cache[0][1:0] <= 2'b11;			
				Cache[1] <= DataFromMem1;
				Cache[2] <= DataIn;
				Cache[3] <= DataFromMem3;
				Cache[4] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[0] <= DataFromMem;
				Cache[0][1:0] <= 2'b11;			
				Cache[1] <= DataFromMem1;
				Cache[2] <= DataFromMem2;
				Cache[3] <= DataIn;
				Cache[4] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[0] <= DataFromMem;
				Cache[0][1:0] <= 2'b11;			
				Cache[1] <= DataFromMem1;
				Cache[2] <= DataFromMem2;
				Cache[3] <= DataFromMem3;
				Cache[4] <= DataIn;
				end
			endcase
			end

		2'b01:	begin
			counter0 = 2'b10;
			//buffer = {Cache[5],Cache[6],Cache[7], Cache[8], Cache[9]};
			case(offset)
			2'b00:	begin
				Cache[5] <= DataFromMem;
				Cache[5][1:0] <= 2'b11;			
				Cache[6] <= DataIn;
				Cache[7]<= DataFromMem2;
				Cache[8] <= DataFromMem3;
				Cache[9] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[5] <= DataFromMem;
				Cache[5][1:0] <= 2'b11;			
				Cache[6] <= DataFromMem1;
				Cache[7] <= DataIn;
				Cache[8] <= DataFromMem3;
				Cache[9] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[5] <= DataFromMem;
				Cache[5][1:0] <= 2'b11;			
				Cache[6] <= DataFromMem1;
				Cache[7] <= DataFromMem2;
				Cache[8] <= DataIn;
				Cache[9] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[5] <= DataFromMem;
				Cache[5][1:0] <= 2'b11;			
				Cache[6] <= DataFromMem1;
				Cache[7] <= DataFromMem2;
				Cache[8] <= DataFromMem3;
				Cache[9] <= DataIn;
				end
			endcase
			end

		2'b10:	begin
			counter0 = 2'b11;
			//buffer = {Cache[10],Cache[11],Cache[12], Cache[13], Cache[14]};
			case(offset)
			2'b00:	begin
				Cache[10] <= DataFromMem;
				Cache[10][1:0] <= 2'b11;			
				Cache[11] <= DataIn;
				Cache[12]<= DataFromMem2;
				Cache[13] <= DataFromMem3;
				Cache[14] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[10] <= DataFromMem;
				Cache[10][1:0] <= 2'b11;			
				Cache[11] <= DataFromMem1;
				Cache[12] <= DataIn;
				Cache[13] <= DataFromMem3;
				Cache[14] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[10] <= DataFromMem;
				Cache[10][1:0] <= 2'b11;			
				Cache[11] <= DataFromMem1;
				Cache[12] <= DataFromMem2;
				Cache[13] <= DataIn;
				Cache[14] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[10] <= DataFromMem;
				Cache[10][1:0] <= 2'b11;			
				Cache[11] <= DataFromMem1;
				Cache[12] <= DataFromMem2;
				Cache[13] <= DataFromMem3;
				Cache[14] <= DataIn;
				end
			endcase
			end

		2'b11:	begin
			counter0 = 2'b00;
			//buffer = {Cache[15],Cache[16],Cache[17], Cache[18], Cache[19]};
			case(offset)
			2'b00:	begin
				Cache[15] <= DataFromMem;
				Cache[15][1:0] <= 2'b11;			
				Cache[16] <= DataIn;
				Cache[17]<= DataFromMem2;
				Cache[18] <= DataFromMem3;
				Cache[19] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[15] <= DataFromMem;
				Cache[15][1:0] <= 2'b11;			
				Cache[16] <= DataFromMem1;
				Cache[17] <= DataIn;
				Cache[18] <= DataFromMem3;
				Cache[19] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[15] <= DataFromMem;
				Cache[15][1:0] <= 2'b11;			
				Cache[16] <= DataFromMem1;
				Cache[17] <= DataFromMem2;
				Cache[18] <= DataIn;
				Cache[19] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[15] <= DataFromMem;
				Cache[15][1:0] <= 2'b11;			
				Cache[16] <= DataFromMem1;
				Cache[17] <= DataFromMem2;
				Cache[18] <= DataFromMem3;
				Cache[19] <= DataIn;
				end
			endcase
			end
		endcase
		end
	else // Read hit
	counter0 = counter0;
	end

3'b001: begin
	if(hit === 2'b01)  // Read miss
		begin
		case(counter1)
		2'b00:	begin
			counter1 = 2'b01;
			//buffer = {Cache[20],Cache[21],Cache[22], Cache[23], Cache[24]};
			Cache[20] <= DataFromMem;
			Cache[21] <= DataFromMem1;
			Cache[22] <= DataFromMem2;
			Cache[23] <= DataFromMem3;
			Cache[24] <= DataFromMem4; 
			end
		2'b01:	begin
			counter1 = 2'b10;
			//buffer = {Cache[25],Cache[26],Cache[27], Cache[28], Cache[29]};
			Cache[25] <= DataFromMem;
			Cache[26] <= DataFromMem1;
			Cache[27] <= DataFromMem2;
			Cache[28] <= DataFromMem3;
			Cache[29] <= DataFromMem4; 
			end
		2'b10:	begin
			counter1 = 2'b11;
			//buffer = {Cache[30],Cache[31],Cache[32], Cache[33], Cache[34]};
			Cache[30] <= DataFromMem;
			Cache[31] <= DataFromMem1;
			Cache[32] <= DataFromMem2;
			Cache[33] <= DataFromMem3;
			Cache[34] <= DataFromMem4; 
			end
		2'b11:	begin
			counter1 = 2'b00;
			//buffer = {Cache[35],Cache[36],Cache[37], Cache[38], Cache[39]};
			Cache[35] <= DataFromMem;
			Cache[36] <= DataFromMem1;
			Cache[37] <= DataFromMem2;
			Cache[38] <= DataFromMem3;
			Cache[39] <= DataFromMem4; 
			end
		endcase
		end
	else if (hit === 2'b10) // Write hit
		begin
		if (Cache[20][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[21] <= DataIn;
			2'b01:	Cache[22] <= DataIn;
			2'b10:	Cache[23] <= DataIn;
			2'b11:	Cache[24] <= DataIn;
			endcase
			Cache[20][1:0] <= 2'b11;
			end
		else if (Cache[25][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[26] <= DataIn;
			2'b01:	Cache[27] <= DataIn;
			2'b10:	Cache[28] <= DataIn;
			2'b11:	Cache[29] <= DataIn;
			endcase
			Cache[25][1:0] <= 2'b11;
			end
		else if (Cache[30][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[31] <= DataIn;
			2'b01:	Cache[32] <= DataIn;
			2'b10:	Cache[33] <= DataIn;
			2'b11:	Cache[34] <= DataIn;
			endcase
			Cache[30][1:0] <= 2'b11;
			end
		else 
			begin
			case(offset)
			2'b00:	Cache[36] <= DataIn;
			2'b01:	Cache[37] <= DataIn;
			2'b10:	Cache[38] <= DataIn;
			2'b11:	Cache[39] <= DataIn;
			endcase
			Cache[35][1:0] <= 2'b11;
			end
		end
	else if (hit === 2'b00) // Write miss
		begin
		case(counter1)
		2'b00:	begin
			counter1 = 2'b01;
			//buffer = {Cache[20],Cache[21],Cache[22], Cache[23], Cache[24]};
			case(offset)
			2'b00:	begin
				Cache[20] <= DataFromMem;
				Cache[20][1:0] <= 2'b11;			
				Cache[21] <= DataIn;
				Cache[22] <= DataFromMem2;
				Cache[23] <= DataFromMem3;
				Cache[24] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[20] <= DataFromMem;
				Cache[20][1:0] <= 2'b11;			
				Cache[21] <= DataFromMem1;
				Cache[22] <= DataIn;
				Cache[23] <= DataFromMem3;
				Cache[24] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[20] <= DataFromMem;
				Cache[20][1:0] <= 2'b11;			
				Cache[21] <= DataFromMem1;
				Cache[22] <= DataFromMem2;
				Cache[23] <= DataIn;
				Cache[24] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[20] <= DataFromMem;
				Cache[20][1:0] <= 2'b11;			
				Cache[21] <= DataFromMem1;
				Cache[22] <= DataFromMem2;
				Cache[23] <= DataFromMem3;
				Cache[24] <= DataIn;
				end
			endcase
			end

		2'b01:	begin
			counter1 = 2'b10;
			//buffer = {Cache[25],Cache[26],Cache[27], Cache[28], Cache[29]};
			case(offset)
			2'b00:	begin
				Cache[25] <= DataFromMem;
				Cache[25][1:0] <= 2'b11;			
				Cache[26] <= DataIn;
				Cache[27]<= DataFromMem2;
				Cache[28] <= DataFromMem3;
				Cache[29] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[25] <= DataFromMem;
				Cache[25][1:0] <= 2'b11;			
				Cache[26] <= DataFromMem1;
				Cache[27] <= DataIn;
				Cache[28] <= DataFromMem3;
				Cache[29] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[25] <= DataFromMem;
				Cache[25][1:0] <= 2'b11;			
				Cache[26] <= DataFromMem1;
				Cache[27] <= DataFromMem2;
				Cache[28] <= DataIn;
				Cache[29] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[25] <= DataFromMem;
				Cache[25][1:0] <= 2'b11;			
				Cache[26] <= DataFromMem1;
				Cache[27] <= DataFromMem2;
				Cache[28] <= DataFromMem3;
				Cache[29] <= DataIn;
				end
			endcase
			end

		2'b10:	begin
			counter1 = 2'b11;
			//buffer = {Cache[30],Cache[31],Cache[32], Cache[33], Cache[34]};
			case(offset)
			2'b00:	begin
				Cache[30] <= DataFromMem;
				Cache[30][1:0] <= 2'b11;			
				Cache[31] <= DataIn;
				Cache[32]<= DataFromMem2;
				Cache[33] <= DataFromMem3;
				Cache[34] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[30] <= DataFromMem;
				Cache[30][1:0] <= 2'b11;			
				Cache[31] <= DataFromMem1;
				Cache[32] <= DataIn;
				Cache[33] <= DataFromMem3;
				Cache[34] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[30] <= DataFromMem;
				Cache[30][1:0] <= 2'b11;			
				Cache[31] <= DataFromMem1;
				Cache[32] <= DataFromMem2;
				Cache[33] <= DataIn;
				Cache[34] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[30] <= DataFromMem;
				Cache[30][1:0] <= 2'b11;			
				Cache[31] <= DataFromMem1;
				Cache[32] <= DataFromMem2;
				Cache[33] <= DataFromMem3;
				Cache[34] <= DataIn;
				end
			endcase
			end

		2'b11:	begin
			counter1 = 2'b00;
			//buffer = {Cache[35],Cache[36],Cache[37], Cache[38], Cache[39]};
			case(offset)
			2'b00:	begin
				Cache[35] <= DataFromMem;
				Cache[35][1:0] <= 2'b11;			
				Cache[36] <= DataIn;
				Cache[37]<= DataFromMem2;
				Cache[38] <= DataFromMem3;
				Cache[39] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[35] <= DataFromMem;
				Cache[35][1:0] <= 2'b11;			
				Cache[36] <= DataFromMem1;
				Cache[37] <= DataIn;
				Cache[38] <= DataFromMem3;
				Cache[39] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[35] <= DataFromMem;
				Cache[35][1:0] <= 2'b11;			
				Cache[36] <= DataFromMem1;
				Cache[37] <= DataFromMem2;
				Cache[38] <= DataIn;
				Cache[39] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[35] <= DataFromMem;
				Cache[35][1:0] <= 2'b11;			
				Cache[36] <= DataFromMem1;
				Cache[37] <= DataFromMem2;
				Cache[38] <= DataFromMem3;
				Cache[39] <= DataIn;
				end
			endcase
			end
		endcase
		end
	else // Read hit
	counter1 = counter1;
	end

3'b010:	begin
	if(hit === 2'b01)  // Read miss
		begin
		case(counter2)
		2'b00:	begin
			counter2 = 2'b01;
			buffer = {Cache[40],Cache[41],Cache[42], Cache[43], Cache[44]};
			Cache[40] <= DataFromMem;
			Cache[41] <= DataFromMem1;
			Cache[42] <= DataFromMem2;
			Cache[43] <= DataFromMem3;
			Cache[44] <= DataFromMem4; 
			end
		2'b01:	begin
			counter2 = 2'b10;
			buffer = {Cache[45],Cache[46],Cache[47], Cache[48], Cache[49]};
			Cache[45] <= DataFromMem;
			Cache[46] <= DataFromMem1;
			Cache[47] <= DataFromMem2;
			Cache[48] <= DataFromMem3;
			Cache[49] <= DataFromMem4; 
			end
		2'b10:	begin
			counter2 = 2'b11;
			buffer = {Cache[50],Cache[51],Cache[52], Cache[53], Cache[54]};
			Cache[50] <= DataFromMem;
			Cache[51] <= DataFromMem1;
			Cache[52] <= DataFromMem2;
			Cache[53] <= DataFromMem3;
			Cache[54] <= DataFromMem4; 
			end
		2'b11:	begin
			counter2 = 2'b00;
			buffer = {Cache[55],Cache[56],Cache[57], Cache[58], Cache[59]};
			Cache[55] <= DataFromMem;
			Cache[56] <= DataFromMem1;
			Cache[57] <= DataFromMem2;
			Cache[58] <= DataFromMem3;
			Cache[59] <= DataFromMem4; 
			end
		endcase
		end
	else if (hit === 2'b10) // Write hit
		begin
		if (Cache[40][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[41] <= DataIn;
			2'b01:	Cache[42] <= DataIn;
			2'b10:	Cache[43] <= DataIn;
			2'b11:	Cache[44] <= DataIn;
			endcase
			Cache[40][1:0] <= 2'b11;
			end
		else if (Cache[45][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[46] <= DataIn;
			2'b01:	Cache[47] <= DataIn;
			2'b10:	Cache[48] <= DataIn;
			2'b11:	Cache[49] <= DataIn;
			endcase
			Cache[45][1:0] <= 2'b11;
			end
		else if (Cache[50][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[51] <= DataIn;
			2'b01:	Cache[52] <= DataIn;
			2'b10:	Cache[53] <= DataIn;
			2'b11:	Cache[54] <= DataIn;
			endcase
			Cache[50][1:0] <= 2'b11;
			end
		else 
			begin
			case(offset)
			2'b00:	Cache[56] <= DataIn;
			2'b01:	Cache[57] <= DataIn;
			2'b10:	Cache[58] <= DataIn;
			2'b11:	Cache[59] <= DataIn;
			endcase
			Cache[55][1:0] <= 2'b11;
			end
		end
	else if (hit === 2'b00) // Write miss
		begin
		case(counter2)
		2'b00:	begin
			counter2 = 2'b01;
			buffer = {Cache[40],Cache[41],Cache[42], Cache[43], Cache[44]};
			case(offset)
			2'b00:	begin
				Cache[40] <= DataFromMem;
				Cache[40][1:0] <= 2'b11;			
				Cache[41] <= DataIn;
				Cache[42] <= DataFromMem2;
				Cache[43] <= DataFromMem3;
				Cache[44] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[40] <= DataFromMem;
				Cache[40][1:0] <= 2'b11;			
				Cache[41] <= DataFromMem1;
				Cache[42] <= DataIn;
				Cache[43] <= DataFromMem3;
				Cache[44] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[40] <= DataFromMem;
				Cache[40][1:0] <= 2'b11;			
				Cache[41] <= DataFromMem1;
				Cache[42] <= DataFromMem2;
				Cache[43] <= DataIn;
				Cache[44] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[40] <= DataFromMem;
				Cache[40][1:0] <= 2'b11;			
				Cache[41] <= DataFromMem1;
				Cache[42] <= DataFromMem2;
				Cache[43] <= DataFromMem3;
				Cache[44] <= DataIn;
				end
			endcase
			end

		2'b01:	begin
			counter2 = 2'b10;
			buffer = {Cache[45],Cache[46],Cache[47], Cache[48], Cache[49]};
			case(offset)
			2'b00:	begin
				Cache[45] <= DataFromMem;
				Cache[45][1:0] <= 2'b11;			
				Cache[46] <= DataIn;
				Cache[47]<= DataFromMem2;
				Cache[48] <= DataFromMem3;
				Cache[49] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[45] <= DataFromMem;
				Cache[45][1:0] <= 2'b11;			
				Cache[46] <= DataFromMem1;
				Cache[47] <= DataIn;
				Cache[48] <= DataFromMem3;
				Cache[49] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[45] <= DataFromMem;
				Cache[45][1:0] <= 2'b11;			
				Cache[46] <= DataFromMem1;
				Cache[47] <= DataFromMem2;
				Cache[48] <= DataIn;
				Cache[49] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[45] <= DataFromMem;
				Cache[45][1:0] <= 2'b11;			
				Cache[46] <= DataFromMem1;
				Cache[47] <= DataFromMem2;
				Cache[48] <= DataFromMem3;
				Cache[49] <= DataIn;
				end
			endcase
			end

		2'b10:	begin
			counter2 = 2'b11;
			buffer = {Cache[50],Cache[51],Cache[52], Cache[53], Cache[54]};
			case(offset)
			2'b00:	begin
				Cache[50] <= DataFromMem;
				Cache[50][1:0] <= 2'b11;			
				Cache[51] <= DataIn;
				Cache[52]<= DataFromMem2;
				Cache[53] <= DataFromMem3;
				Cache[54] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[50] <= DataFromMem;
				Cache[50][1:0] <= 2'b11;			
				Cache[51] <= DataFromMem1;
				Cache[52] <= DataIn;
				Cache[53] <= DataFromMem3;
				Cache[54] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[50] <= DataFromMem;
				Cache[50][1:0] <= 2'b11;			
				Cache[51] <= DataFromMem1;
				Cache[52] <= DataFromMem2;
				Cache[53] <= DataIn;
				Cache[54] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[50] <= DataFromMem;
				Cache[50][1:0] <= 2'b11;			
				Cache[51] <= DataFromMem1;
				Cache[52] <= DataFromMem2;
				Cache[53] <= DataFromMem3;
				Cache[54] <= DataIn;
				end
			endcase
			end

		2'b11:	begin
			counter2 = 2'b00;
			buffer = {Cache[55],Cache[56],Cache[57], Cache[58], Cache[59]};
			case(offset)
			2'b00:	begin
				Cache[55] <= DataFromMem;
				Cache[55][1:0] <= 2'b11;			
				Cache[56] <= DataIn;
				Cache[57]<= DataFromMem2;
				Cache[58] <= DataFromMem3;
				Cache[59] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[55] <= DataFromMem;
				Cache[55][1:0] <= 2'b11;			
				Cache[56] <= DataFromMem1;
				Cache[57] <= DataIn;
				Cache[58] <= DataFromMem3;
				Cache[59] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[55] <= DataFromMem;
				Cache[55][1:0] <= 2'b11;			
				Cache[56] <= DataFromMem1;
				Cache[57] <= DataFromMem2;
				Cache[58] <= DataIn;
				Cache[59] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[55] <= DataFromMem;
				Cache[55][1:0] <= 2'b11;			
				Cache[56] <= DataFromMem1;
				Cache[57] <= DataFromMem2;
				Cache[58] <= DataFromMem3;
				Cache[59] <= DataIn;
				end
			endcase
			end
		endcase
		end
	else // Read hit
	counter2 = counter2;
	end

3'b011:	begin
	if(hit === 2'b01)  // Read miss
		begin
		case(counter3)
		2'b00:	begin
			counter3 = 2'b01;
			buffer = {Cache[60],Cache[61],Cache[62], Cache[63], Cache[64]};
			Cache[60] <= DataFromMem;
			Cache[61] <= DataFromMem1;
			Cache[62] <= DataFromMem2;
			Cache[63] <= DataFromMem3;
			Cache[64] <= DataFromMem4; 
			end
		2'b01:	begin
			counter3 = 2'b10;
			buffer = {Cache[65],Cache[66],Cache[67], Cache[68], Cache[69]};
			Cache[65] <= DataFromMem;
			Cache[66] <= DataFromMem1;
			Cache[67] <= DataFromMem2;
			Cache[68] <= DataFromMem3;
			Cache[69] <= DataFromMem4; 
			end
		2'b10:	begin
			counter3 = 2'b11;
			buffer = {Cache[70],Cache[71],Cache[72], Cache[73], Cache[74]};
			Cache[70] <= DataFromMem;
			Cache[71] <= DataFromMem1;
			Cache[72] <= DataFromMem2;
			Cache[73] <= DataFromMem3;
			Cache[74] <= DataFromMem4; 
			end
		2'b11:	begin
			counter3 = 2'b00;
			buffer = {Cache[75],Cache[76],Cache[77], Cache[78], Cache[79]};
			Cache[75] <= DataFromMem;
			Cache[76] <= DataFromMem1;
			Cache[77] <= DataFromMem2;
			Cache[78] <= DataFromMem3;
			Cache[79] <= DataFromMem4; 
			end
		endcase
		end
	else if (hit === 2'b10) // Write hit
		begin
		if (Cache[60][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[61] <= DataIn;
			2'b01:	Cache[62] <= DataIn;
			2'b10:	Cache[63] <= DataIn;
			2'b11:	Cache[64] <= DataIn;
			endcase
			Cache[60][1:0] <= 2'b11;
			end
		else if (Cache[65][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[66] <= DataIn;
			2'b01:	Cache[67] <= DataIn;
			2'b10:	Cache[68] <= DataIn;
			2'b11:	Cache[69] <= DataIn;
			endcase
			Cache[65][1:0] <= 2'b11;
			end
		else if (Cache[70][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[71] <= DataIn;
			2'b01:	Cache[72] <= DataIn;
			2'b10:	Cache[73] <= DataIn;
			2'b11:	Cache[74] <= DataIn;
			endcase
			Cache[70][1:0] <= 2'b11;
			end
		else 
			begin
			case(offset)
			2'b00:	Cache[76] <= DataIn;
			2'b01:	Cache[77] <= DataIn;
			2'b10:	Cache[78] <= DataIn;
			2'b11:	Cache[79] <= DataIn;
			endcase
			Cache[75][1:0] <= 2'b11;
			end
		end
	else if (hit === 2'b00) // Write miss
		begin
		case(counter3)
		2'b00:	begin
			counter3 = 2'b01;
			buffer = {Cache[60],Cache[61],Cache[62], Cache[63], Cache[64]};
			case(offset)
			2'b00:	begin
				Cache[60] <= DataFromMem;
				Cache[60][1:0] <= 2'b11;			
				Cache[61] <= DataIn;
				Cache[62] <= DataFromMem2;
				Cache[63] <= DataFromMem3;
				Cache[64] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[60] <= DataFromMem;
				Cache[60][1:0] <= 2'b11;			
				Cache[61] <= DataFromMem1;
				Cache[62] <= DataIn;
				Cache[63] <= DataFromMem3;
				Cache[64] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[60] <= DataFromMem;
				Cache[60][1:0] <= 2'b11;			
				Cache[61] <= DataFromMem1;
				Cache[62] <= DataFromMem2;
				Cache[63] <= DataIn;
				Cache[64] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[60] <= DataFromMem;
				Cache[60][1:0] <= 2'b11;			
				Cache[61] <= DataFromMem1;
				Cache[62] <= DataFromMem2;
				Cache[63] <= DataFromMem3;
				Cache[64] <= DataIn;
				end
			endcase
			end

		2'b01:	begin
			counter3 = 2'b10;
			buffer = {Cache[65],Cache[66],Cache[67], Cache[68], Cache[69]};
			case(offset)
			2'b00:	begin
				Cache[65] <= DataFromMem;
				Cache[65][1:0] <= 2'b11;			
				Cache[66] <= DataIn;
				Cache[67]<= DataFromMem2;
				Cache[68] <= DataFromMem3;
				Cache[69] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[65] <= DataFromMem;
				Cache[65][1:0] <= 2'b11;			
				Cache[66] <= DataFromMem1;
				Cache[67] <= DataIn;
				Cache[68] <= DataFromMem3;
				Cache[69] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[65] <= DataFromMem;
				Cache[65][1:0] <= 2'b11;			
				Cache[66] <= DataFromMem1;
				Cache[67] <= DataFromMem2;
				Cache[68] <= DataIn;
				Cache[69] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[65] <= DataFromMem;
				Cache[65][1:0] <= 2'b11;			
				Cache[66] <= DataFromMem1;
				Cache[67] <= DataFromMem2;
				Cache[68] <= DataFromMem3;
				Cache[69] <= DataIn;
				end
			endcase
			end

		2'b10:	begin
			counter3 = 2'b11;
			buffer = {Cache[70],Cache[71],Cache[72], Cache[73], Cache[74]};
			case(offset)
			2'b00:	begin
				Cache[70] <= DataFromMem;
				Cache[70][1:0] <= 2'b11;			
				Cache[71] <= DataIn;
				Cache[72]<= DataFromMem2;
				Cache[73] <= DataFromMem3;
				Cache[74] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[70] <= DataFromMem;
				Cache[70][1:0] <= 2'b11;			
				Cache[71] <= DataFromMem1;
				Cache[72] <= DataIn;
				Cache[73] <= DataFromMem3;
				Cache[74] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[70] <= DataFromMem;
				Cache[70][1:0] <= 2'b11;			
				Cache[71] <= DataFromMem1;
				Cache[72] <= DataFromMem2;
				Cache[73] <= DataIn;
				Cache[74] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[70] <= DataFromMem;
				Cache[70][1:0] <= 2'b11;			
				Cache[71] <= DataFromMem1;
				Cache[72] <= DataFromMem2;
				Cache[73] <= DataFromMem3;
				Cache[74] <= DataIn;
				end
			endcase
			end

		2'b11:	begin
			counter3 = 2'b00;
			buffer = {Cache[75],Cache[76],Cache[77], Cache[78], Cache[79]};
			case(offset)
			2'b00:	begin
				Cache[75] <= DataFromMem;
				Cache[75][1:0] <= 2'b11;			
				Cache[76] <= DataIn;
				Cache[77]<= DataFromMem2;
				Cache[78] <= DataFromMem3;
				Cache[79] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[75] <= DataFromMem;
				Cache[75][1:0] <= 2'b11;			
				Cache[76] <= DataFromMem1;
				Cache[77] <= DataIn;
				Cache[78] <= DataFromMem3;
				Cache[79] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[75] <= DataFromMem;
				Cache[75][1:0] <= 2'b11;			
				Cache[76] <= DataFromMem1;
				Cache[77] <= DataFromMem2;
				Cache[78] <= DataIn;
				Cache[79] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[75] <= DataFromMem;
				Cache[75][1:0] <= 2'b11;			
				Cache[76] <= DataFromMem1;
				Cache[77] <= DataFromMem2;
				Cache[78] <= DataFromMem3;
				Cache[79] <= DataIn;
				end
			endcase
			end
		endcase
		end
	else // Read hit
	counter3 = counter3;
	end


3'b100:	begin
	if(hit === 2'b01)  // Read miss
		begin
		case(counter4)
		2'b00:	begin
			counter4 = 2'b01;
			buffer = {Cache[80],Cache[81],Cache[82], Cache[83], Cache[84]};
			Cache[80] <= DataFromMem;
			Cache[81] <= DataFromMem1;
			Cache[82] <= DataFromMem2;
			Cache[83] <= DataFromMem3;
			Cache[84] <= DataFromMem4; 
			end
		2'b01:	begin
			counter4 = 2'b10;
			buffer = {Cache[85],Cache[86],Cache[87], Cache[88], Cache[89]};
			Cache[85] <= DataFromMem;
			Cache[86] <= DataFromMem1;
			Cache[87] <= DataFromMem2;
			Cache[88] <= DataFromMem3;
			Cache[89] <= DataFromMem4; 
			end
		2'b10:	begin
			counter4 = 2'b11;
			buffer = {Cache[90],Cache[91],Cache[92], Cache[93], Cache[94]};
			Cache[90] <= DataFromMem;
			Cache[91] <= DataFromMem1;
			Cache[92] <= DataFromMem2;
			Cache[93] <= DataFromMem3;
			Cache[94] <= DataFromMem4; 
			end
		2'b11:	begin
			counter4 = 2'b00;
			buffer = {Cache[95],Cache[96],Cache[97], Cache[98], Cache[99]};
			Cache[95] <= DataFromMem;
			Cache[96] <= DataFromMem1;
			Cache[97] <= DataFromMem2;
			Cache[98] <= DataFromMem3;
			Cache[99] <= DataFromMem4; 
			end
		endcase
		end
	else if (hit === 2'b10) // Write hit
		begin
		if (Cache[80][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[81] <= DataIn;
			2'b01:	Cache[82] <= DataIn;
			2'b10:	Cache[83] <= DataIn;
			2'b11:	Cache[84] <= DataIn;
			endcase
			Cache[80][1:0] <= 2'b11;
			end
		else if (Cache[85][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[86] <= DataIn;
			2'b01:	Cache[87] <= DataIn;
			2'b10:	Cache[88] <= DataIn;
			2'b11:	Cache[89] <= DataIn;
			endcase
			Cache[85][1:0] <= 2'b11;
			end
		else if (Cache[90][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[91] <= DataIn;
			2'b01:	Cache[92] <= DataIn;
			2'b10:	Cache[93] <= DataIn;
			2'b11:	Cache[94] <= DataIn;
			endcase
			Cache[90][1:0] <= 2'b11;
			end
		else 
			begin
			case(offset)
			2'b00:	Cache[96] <= DataIn;
			2'b01:	Cache[97] <= DataIn;
			2'b10:	Cache[98] <= DataIn;
			2'b11:	Cache[99] <= DataIn;
			endcase
			Cache[95][1:0] <= 2'b11;
			end
		end
	else if (hit === 2'b00) // Write miss
		begin
		case(counter4)
		2'b00:	begin
			counter4 = 2'b01;
			buffer = {Cache[80],Cache[81],Cache[82], Cache[83], Cache[84]};
			case(offset)
			2'b00:	begin
				Cache[80] <= DataFromMem;
				Cache[80][1:0] <= 2'b11;			
				Cache[81] <= DataIn;
				Cache[82] <= DataFromMem2;
				Cache[83] <= DataFromMem3;
				Cache[84] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[80] <= DataFromMem;
				Cache[80][1:0] <= 2'b11;			
				Cache[81] <= DataFromMem1;
				Cache[82] <= DataIn;
				Cache[83] <= DataFromMem3;
				Cache[84] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[80] <= DataFromMem;
				Cache[80][1:0] <= 2'b11;			
				Cache[81] <= DataFromMem1;
				Cache[82] <= DataFromMem2;
				Cache[83] <= DataIn;
				Cache[84] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[80] <= DataFromMem;
				Cache[80][1:0] <= 2'b11;			
				Cache[81] <= DataFromMem1;
				Cache[82] <= DataFromMem2;
				Cache[83] <= DataFromMem3;
				Cache[84] <= DataIn;
				end
			endcase
			end

		2'b01:	begin
			counter4 = 2'b10;
			buffer = {Cache[85],Cache[86],Cache[87], Cache[88], Cache[89]};
			case(offset)
			2'b00:	begin
				Cache[85] <= DataFromMem;
				Cache[85][1:0] <= 2'b11;			
				Cache[86] <= DataIn;
				Cache[87]<= DataFromMem2;
				Cache[88] <= DataFromMem3;
				Cache[89] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[85] <= DataFromMem;
				Cache[85][1:0] <= 2'b11;			
				Cache[86] <= DataFromMem1;
				Cache[87] <= DataIn;
				Cache[88] <= DataFromMem3;
				Cache[89] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[85] <= DataFromMem;
				Cache[85][1:0] <= 2'b11;			
				Cache[86] <= DataFromMem1;
				Cache[87] <= DataFromMem2;
				Cache[88] <= DataIn;
				Cache[89] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[85] <= DataFromMem;
				Cache[85][1:0] <= 2'b11;			
				Cache[86] <= DataFromMem1;
				Cache[87] <= DataFromMem2;
				Cache[88] <= DataFromMem3;
				Cache[89] <= DataIn;
				end
			endcase
			end

		2'b10:	begin
			counter4 = 2'b11;
			buffer = {Cache[90],Cache[91],Cache[92], Cache[93], Cache[94]};
			case(offset)
			2'b00:	begin
				Cache[90] <= DataFromMem;
				Cache[90][1:0] <= 2'b11;			
				Cache[91] <= DataIn;
				Cache[92]<= DataFromMem2;
				Cache[93] <= DataFromMem3;
				Cache[94] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[90] <= DataFromMem;
				Cache[90][1:0] <= 2'b11;			
				Cache[91] <= DataFromMem1;
				Cache[92] <= DataIn;
				Cache[93] <= DataFromMem3;
				Cache[94] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[90] <= DataFromMem;
				Cache[90][1:0] <= 2'b11;			
				Cache[91] <= DataFromMem1;
				Cache[92] <= DataFromMem2;
				Cache[93] <= DataIn;
				Cache[94] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[90] <= DataFromMem;
				Cache[90][1:0] <= 2'b11;			
				Cache[91] <= DataFromMem1;
				Cache[92] <= DataFromMem2;
				Cache[93] <= DataFromMem3;
				Cache[94] <= DataIn;
				end
			endcase
			end

		2'b11:	begin
			counter4 = 2'b00;
			buffer = {Cache[95],Cache[96],Cache[97], Cache[98], Cache[99]};
			case(offset)
			2'b00:	begin
				Cache[95] <= DataFromMem;
				Cache[95][1:0] <= 2'b11;			
				Cache[96] <= DataIn;
				Cache[97]<= DataFromMem2;
				Cache[98] <= DataFromMem3;
				Cache[99] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[95] <= DataFromMem;
				Cache[95][1:0] <= 2'b11;			
				Cache[96] <= DataFromMem1;
				Cache[97] <= DataIn;
				Cache[98] <= DataFromMem3;
				Cache[99] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[95] <= DataFromMem;
				Cache[95][1:0] <= 2'b11;			
				Cache[96] <= DataFromMem1;
				Cache[97] <= DataFromMem2;
				Cache[98] <= DataIn;
				Cache[99] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[95] <= DataFromMem;
				Cache[95][1:0] <= 2'b11;			
				Cache[96] <= DataFromMem1;
				Cache[97] <= DataFromMem2;
				Cache[98] <= DataFromMem3;
				Cache[99] <= DataIn;
				end
			endcase
			end
		endcase
		end
	else // Read hit
	counter4 = counter4;
	end

3'b101:	begin
	if(hit === 2'b01)  // Read miss
		begin
		case(counter5)
		2'b00:	begin
			counter5 = 2'b01;			
			buffer = {Cache[100],Cache[101],Cache[102], Cache[103], Cache[104]};
			Cache[100] <= DataFromMem;
			Cache[101] <= DataFromMem1;
			Cache[102] <= DataFromMem2;
			Cache[103] <= DataFromMem3;
			Cache[104] <= DataFromMem4; 
			end
		2'b01:	begin
			counter5 = 2'b10;
			buffer = {Cache[105],Cache[106],Cache[107], Cache[108], Cache[109]};
			Cache[105] <= DataFromMem;
			Cache[106] <= DataFromMem1;
			Cache[107] <= DataFromMem2;
			Cache[108] <= DataFromMem3;
			Cache[109] <= DataFromMem4; 
			end
		2'b10:	begin
			buffer = {Cache[110],Cache[111],Cache[112], Cache[113], Cache[114]};
			counter5 = 2'b11;
			Cache[110] <= DataFromMem;
			Cache[111] <= DataFromMem1;
			Cache[112] <= DataFromMem2;
			Cache[113] <= DataFromMem3;
			Cache[114] <= DataFromMem4; 
			end
		2'b11:	begin
			counter5 = 2'b00;
			buffer = {Cache[115],Cache[116],Cache[117], Cache[118], Cache[119]};
			Cache[115] <= DataFromMem;
			Cache[116] <= DataFromMem1;
			Cache[117] <= DataFromMem2;
			Cache[118] <= DataFromMem3;
			Cache[119] <= DataFromMem4; 
			end
		endcase
		end
	else if (hit === 2'b10) // Write hit
		begin
		if (Cache[100][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[101] <= DataIn;
			2'b01:	Cache[102] <= DataIn;
			2'b10:	Cache[103] <= DataIn;
			2'b11:	Cache[104] <= DataIn;
			endcase
			Cache[100][1:0] <= 2'b11;
			end
		else if (Cache[105][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[106] <= DataIn;
			2'b01:	Cache[107] <= DataIn;
			2'b10:	Cache[108] <= DataIn;
			2'b11:	Cache[109] <= DataIn;
			endcase
			Cache[105][1:0] <= 2'b11;
			end
		else if (Cache[110][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[111] <= DataIn;
			2'b01:	Cache[112] <= DataIn;
			2'b10:	Cache[113] <= DataIn;
			2'b11:	Cache[114] <= DataIn;
			endcase
			Cache[110][1:0] <= 2'b11;
			end
		else 
			begin
			case(offset)
			2'b00:	Cache[116] <= DataIn;
			2'b01:	Cache[117] <= DataIn;
			2'b10:	Cache[118] <= DataIn;
			2'b11:	Cache[119] <= DataIn;
			endcase
			Cache[115][1:0] <= 2'b11;
			end
		end
	else if (hit === 2'b00) // Write miss
		begin
		case(counter5)
		2'b00:	begin
			counter5 = 2'b01;
			buffer = {Cache[100],Cache[101],Cache[102], Cache[103], Cache[104]};
			case(offset)
			2'b00:	begin
				Cache[100] <= DataFromMem;
				Cache[100][1:0] <= 2'b11;			
				Cache[101] <= DataIn;
				Cache[102] <= DataFromMem2;
				Cache[103] <= DataFromMem3;
				Cache[104] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[100] <= DataFromMem;
				Cache[100][1:0] <= 2'b11;			
				Cache[101] <= DataFromMem1;
				Cache[102] <= DataIn;
				Cache[103] <= DataFromMem3;
				Cache[104] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[100] <= DataFromMem;
				Cache[100][1:0] <= 2'b11;			
				Cache[101] <= DataFromMem1;
				Cache[102] <= DataFromMem2;
				Cache[103] <= DataIn;
				Cache[104] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[100] <= DataFromMem;
				Cache[100][1:0] <= 2'b11;			
				Cache[101] <= DataFromMem1;
				Cache[102] <= DataFromMem2;
				Cache[103] <= DataFromMem3;
				Cache[104] <= DataIn;
				end
			endcase
			end

		2'b01:	begin
			counter5 = 2'b10;
			buffer = {Cache[105],Cache[106],Cache[107], Cache[108], Cache[109]};
			case(offset)
			2'b00:	begin
				Cache[105] <= DataFromMem;
				Cache[105][1:0] <= 2'b11;			
				Cache[106] <= DataIn;
				Cache[107]<= DataFromMem2;
				Cache[108] <= DataFromMem3;
				Cache[109] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[105] <= DataFromMem;
				Cache[105][1:0] <= 2'b11;			
				Cache[106] <= DataFromMem1;
				Cache[107] <= DataIn;
				Cache[108] <= DataFromMem3;
				Cache[109] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[105] <= DataFromMem;
				Cache[105][1:0] <= 2'b11;			
				Cache[106] <= DataFromMem1;
				Cache[107] <= DataFromMem2;
				Cache[108] <= DataIn;
				Cache[109] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[105] <= DataFromMem;
				Cache[105][1:0] <= 2'b11;			
				Cache[106] <= DataFromMem1;
				Cache[107] <= DataFromMem2;
				Cache[108] <= DataFromMem3;
				Cache[109] <= DataIn;
				end
			endcase
			end

		2'b10:	begin
			counter5 = 2'b11;
			buffer = {Cache[110],Cache[111],Cache[112], Cache[113], Cache[114]};
			case(offset)
			2'b00:	begin
				Cache[110] <= DataFromMem;
				Cache[110][1:0] <= 2'b11;			
				Cache[111] <= DataIn;
				Cache[112]<= DataFromMem2;
				Cache[113] <= DataFromMem3;
				Cache[114] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[110] <= DataFromMem;
				Cache[110][1:0] <= 2'b11;			
				Cache[111] <= DataFromMem1;
				Cache[112] <= DataIn;
				Cache[113] <= DataFromMem3;
				Cache[114] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[110] <= DataFromMem;
				Cache[110][1:0] <= 2'b11;			
				Cache[111] <= DataFromMem1;
				Cache[112] <= DataFromMem2;
				Cache[113] <= DataIn;
				Cache[114] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[110] <= DataFromMem;
				Cache[110][1:0] <= 2'b11;			
				Cache[111] <= DataFromMem1;
				Cache[112] <= DataFromMem2;
				Cache[113] <= DataFromMem3;
				Cache[114] <= DataIn;
				end
			endcase
			end

		2'b11:	begin
			counter5 = 2'b00;
			buffer = {Cache[115],Cache[116],Cache[117], Cache[118], Cache[119]};
			case(offset)
			2'b00:	begin
				Cache[115] <= DataFromMem;
				Cache[115][1:0] <= 2'b11;			
				Cache[116] <= DataIn;
				Cache[117]<= DataFromMem2;
				Cache[118] <= DataFromMem3;
				Cache[119] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[115] <= DataFromMem;
				Cache[115][1:0] <= 2'b11;			
				Cache[116] <= DataFromMem1;
				Cache[117] <= DataIn;
				Cache[118] <= DataFromMem3;
				Cache[119] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[115] <= DataFromMem;
				Cache[115][1:0] <= 2'b11;			
				Cache[116] <= DataFromMem1;
				Cache[117] <= DataFromMem2;
				Cache[118] <= DataIn;
				Cache[119] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[115] <= DataFromMem;
				Cache[115][1:0] <= 2'b11;			
				Cache[116] <= DataFromMem1;
				Cache[117] <= DataFromMem2;
				Cache[118] <= DataFromMem3;
				Cache[119] <= DataIn;
				end
			endcase
			end
		endcase
		end
	else // Read hit
	counter5 = counter5;
	end


3'b110:	begin
	if(hit === 2'b01)  // Read miss
		begin
		case(counter6)
		2'b00:	begin
			counter6 = 2'b01;
			buffer = {Cache[120],Cache[121],Cache[122], Cache[123], Cache[124]};
			Cache[120] <= DataFromMem;
			Cache[121] <= DataFromMem1;
			Cache[122] <= DataFromMem2;
			Cache[123] <= DataFromMem3;
			Cache[124] <= DataFromMem4; 
			end
		2'b01:	begin
			counter6 = 2'b10;
			buffer = {Cache[125],Cache[126],Cache[127], Cache[128], Cache[129]};
			Cache[125] <= DataFromMem;
			Cache[126] <= DataFromMem1;
			Cache[127] <= DataFromMem2;
			Cache[128] <= DataFromMem3;
			Cache[129] <= DataFromMem4; 
			end
		2'b10:	begin
			counter6 = 2'b11;
			buffer = {Cache[130],Cache[131],Cache[132], Cache[133], Cache[134]};
			Cache[130] <= DataFromMem;
			Cache[131] <= DataFromMem1;
			Cache[132] <= DataFromMem2;
			Cache[133] <= DataFromMem3;
			Cache[134] <= DataFromMem4; 
			end
		2'b11:	begin
			counter6 = 2'b00;
			buffer = {Cache[135],Cache[136],Cache[137], Cache[138], Cache[139]};
			Cache[135] <= DataFromMem;
			Cache[136] <= DataFromMem1;
			Cache[137] <= DataFromMem2;
			Cache[138] <= DataFromMem3;
			Cache[139] <= DataFromMem4; 
			end
		endcase
		end
	else if (hit === 2'b10) // Write hit
		begin
		if (Cache[120][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[121] <= DataIn;
			2'b01:	Cache[122] <= DataIn;
			2'b10:	Cache[123] <= DataIn;
			2'b11:	Cache[124] <= DataIn;
			endcase
			Cache[120][1:0] <= 2'b11;
			end
		else if (Cache[125][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[126] <= DataIn;
			2'b01:	Cache[127] <= DataIn;
			2'b10:	Cache[128] <= DataIn;
			2'b11:	Cache[129] <= DataIn;
			endcase
			Cache[125][1:0] <= 2'b11;
			end
		else if (Cache[130][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[131] <= DataIn;
			2'b01:	Cache[132] <= DataIn;
			2'b10:	Cache[133] <= DataIn;
			2'b11:	Cache[134] <= DataIn;
			endcase
			Cache[130][1:0] <= 2'b11;
			end
		else 
			begin
			case(offset)
			2'b00:	Cache[136] <= DataIn;
			2'b01:	Cache[137] <= DataIn;
			2'b10:	Cache[138] <= DataIn;
			2'b11:	Cache[139] <= DataIn;
			endcase
			Cache[135][1:0] <= 2'b11;
			end
		end
	else if (hit === 2'b00) // Write miss
		begin
		case(counter6)
		2'b00:	begin
			counter6 = 2'b01;
			buffer = {Cache[120],Cache[121],Cache[122], Cache[123], Cache[124]};
			case(offset)
			2'b00:	begin
				Cache[120] <= DataFromMem;
				Cache[120][1:0] <= 2'b11;			
				Cache[121] <= DataIn;
				Cache[122] <= DataFromMem2;
				Cache[123] <= DataFromMem3;
				Cache[124] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[120] <= DataFromMem;
				Cache[120][1:0] <= 2'b11;			
				Cache[121] <= DataFromMem1;
				Cache[122] <= DataIn;
				Cache[123] <= DataFromMem3;
				Cache[124] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[120] <= DataFromMem;
				Cache[120][1:0] <= 2'b11;			
				Cache[121] <= DataFromMem1;
				Cache[122] <= DataFromMem2;
				Cache[123] <= DataIn;
				Cache[124] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[120] <= DataFromMem;
				Cache[120][1:0] <= 2'b11;			
				Cache[121] <= DataFromMem1;
				Cache[122] <= DataFromMem2;
				Cache[123] <= DataFromMem3;
				Cache[124] <= DataIn;
				end
			endcase
			end

		2'b01:	begin
			counter6 = 2'b10;
			buffer = {Cache[125],Cache[126],Cache[127], Cache[128], Cache[129]};
			case(offset)
			2'b00:	begin
				Cache[125] <= DataFromMem;
				Cache[125][1:0] <= 2'b11;			
				Cache[126] <= DataIn;
				Cache[127]<= DataFromMem2;
				Cache[128] <= DataFromMem3;
				Cache[129] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[125] <= DataFromMem;
				Cache[125][1:0] <= 2'b11;			
				Cache[126] <= DataFromMem1;
				Cache[127] <= DataIn;
				Cache[128] <= DataFromMem3;
				Cache[129] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[125] <= DataFromMem;
				Cache[125][1:0] <= 2'b11;			
				Cache[126] <= DataFromMem1;
				Cache[127] <= DataFromMem2;
				Cache[128] <= DataIn;
				Cache[129] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[125] <= DataFromMem;
				Cache[125][1:0] <= 2'b11;			
				Cache[126] <= DataFromMem1;
				Cache[127] <= DataFromMem2;
				Cache[128] <= DataFromMem3;
				Cache[129] <= DataIn;
				end
			endcase
			end

		2'b10:	begin
			counter6 = 2'b11;
			buffer = {Cache[130],Cache[131],Cache[132], Cache[133], Cache[134]};
			case(offset)
			2'b00:	begin
				Cache[130] <= DataFromMem;
				Cache[130][1:0] <= 2'b11;			
				Cache[131] <= DataIn;
				Cache[132]<= DataFromMem2;
				Cache[133] <= DataFromMem3;
				Cache[134] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[130] <= DataFromMem;
				Cache[130][1:0] <= 2'b11;			
				Cache[131] <= DataFromMem1;
				Cache[132] <= DataIn;
				Cache[133] <= DataFromMem3;
				Cache[134] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[130] <= DataFromMem;
				Cache[130][1:0] <= 2'b11;			
				Cache[131] <= DataFromMem1;
				Cache[132] <= DataFromMem2;
				Cache[133] <= DataIn;
				Cache[134] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[130] <= DataFromMem;
				Cache[130][1:0] <= 2'b11;			
				Cache[131] <= DataFromMem1;
				Cache[132] <= DataFromMem2;
				Cache[133] <= DataFromMem3;
				Cache[134] <= DataIn;
				end
			endcase
			end

		2'b11:	begin
			counter6 = 2'b00;
			buffer = {Cache[135],Cache[136],Cache[137], Cache[138], Cache[139]};
			case(offset)
			2'b00:	begin
				Cache[135] <= DataFromMem;
				Cache[135][1:0] <= 2'b11;			
				Cache[136] <= DataIn;
				Cache[137]<= DataFromMem2;
				Cache[138] <= DataFromMem3;
				Cache[139] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[135] <= DataFromMem;
				Cache[135][1:0] <= 2'b11;			
				Cache[136] <= DataFromMem1;
				Cache[137] <= DataIn;
				Cache[138] <= DataFromMem3;
				Cache[139] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[135] <= DataFromMem;
				Cache[135][1:0] <= 2'b11;			
				Cache[136] <= DataFromMem1;
				Cache[137] <= DataFromMem2;
				Cache[138] <= DataIn;
				Cache[139] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[135] <= DataFromMem;
				Cache[135][1:0] <= 2'b11;			
				Cache[136] <= DataFromMem1;
				Cache[137] <= DataFromMem2;
				Cache[138] <= DataFromMem3;
				Cache[139] <= DataIn;
				end
			endcase
			end
		endcase
		end
	else // Read hit
	counter6 = counter6;
	end


3'b111:	begin
	if(hit === 2'b01)  // Read miss
		begin
		case(counter7)
		2'b00:	begin
			counter7 = 2'b01;
			buffer = {Cache[140],Cache[141],Cache[142], Cache[143], Cache[144]};
			Cache[140] <= DataFromMem;
			Cache[141] <= DataFromMem1;
			Cache[142] <= DataFromMem2;
			Cache[143] <= DataFromMem3;
			Cache[144] <= DataFromMem4; 
			end
		2'b01:	begin
			counter7 = 2'b10;
			buffer = {Cache[160],Cache[146],Cache[147], Cache[148], Cache[149]};
			Cache[160] <= DataFromMem;
			Cache[146] <= DataFromMem1;
			Cache[147] <= DataFromMem2;
			Cache[148] <= DataFromMem3;
			Cache[149] <= DataFromMem4; 
			end
		2'b10:	begin
			counter7 = 2'b11;
			buffer = {Cache[150],Cache[151],Cache[152], Cache[153], Cache[154]};
			Cache[150] <= DataFromMem;
			Cache[151] <= DataFromMem1;
			Cache[152] <= DataFromMem2;
			Cache[153] <= DataFromMem3;
			Cache[154] <= DataFromMem4; 
			end
		2'b11:	begin
			counter7 = 2'b00;
			buffer = {Cache[155],Cache[156],Cache[157], Cache[158], Cache[159]};
			Cache[155] <= DataFromMem;
			Cache[156] <= DataFromMem1;
			Cache[157] <= DataFromMem2;
			Cache[158] <= DataFromMem3;
			Cache[159] <= DataFromMem4; 
			end
		endcase
		end
	else if (hit === 2'b10) // Write hit
		begin
		if (Cache[140][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[141] <= DataIn;
			2'b01:	Cache[142] <= DataIn;
			2'b10:	Cache[143] <= DataIn;
			2'b11:	Cache[144] <= DataIn;
			endcase
			Cache[140][1:0] <= 2'b11;
			end
		else if (Cache[160][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[146] <= DataIn;
			2'b01:	Cache[147] <= DataIn;
			2'b10:	Cache[148] <= DataIn;
			2'b11:	Cache[149] <= DataIn;
			endcase
			Cache[160][1:0] <= 2'b11;
			end
		else if (Cache[150][31:5] === tag)
			begin
			case(offset)
			2'b00:	Cache[151] <= DataIn;
			2'b01:	Cache[152] <= DataIn;
			2'b10:	Cache[153] <= DataIn;
			2'b11:	Cache[154] <= DataIn;
			endcase
			Cache[150][1:0] <= 2'b11;
			end
		else 
			begin
			case(offset)
			2'b00:	Cache[156] <= DataIn;
			2'b01:	Cache[157] <= DataIn;
			2'b10:	Cache[158] <= DataIn;
			2'b11:	Cache[159] <= DataIn;
			endcase
			Cache[155][1:0] <= 2'b11;
			end
		end
	else if (hit === 2'b00) // Write miss
		begin
		case(counter7)
		2'b00:	begin
			counter7 = 2'b01;
			buffer = {Cache[140],Cache[141],Cache[142], Cache[143], Cache[144]};
			case(offset)
			2'b00:	begin
				Cache[140] <= DataFromMem;
				Cache[140][1:0] <= 2'b11;			
				Cache[141] <= DataIn;
				Cache[142] <= DataFromMem2;
				Cache[143] <= DataFromMem3;
				Cache[144] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[140] <= DataFromMem;
				Cache[140][1:0] <= 2'b11;			
				Cache[141] <= DataFromMem1;
				Cache[142] <= DataIn;
				Cache[143] <= DataFromMem3;
				Cache[144] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[140] <= DataFromMem;
				Cache[140][1:0] <= 2'b11;			
				Cache[141] <= DataFromMem1;
				Cache[142] <= DataFromMem2;
				Cache[143] <= DataIn;
				Cache[144] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[140] <= DataFromMem;
				Cache[140][1:0] <= 2'b11;			
				Cache[141] <= DataFromMem1;
				Cache[142] <= DataFromMem2;
				Cache[143] <= DataFromMem3;
				Cache[144] <= DataIn;
				end
			endcase
			end

		2'b01:	begin
			counter7 = 2'b10;
			buffer = {Cache[160],Cache[146],Cache[147], Cache[148], Cache[149]};
			case(offset)
			2'b00:	begin
				Cache[160] <= DataFromMem;
				Cache[160][1:0] <= 2'b11;			
				Cache[146] <= DataIn;
				Cache[147]<= DataFromMem2;
				Cache[148] <= DataFromMem3;
				Cache[149] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[160] <= DataFromMem;
				Cache[160][1:0] <= 2'b11;			
				Cache[146] <= DataFromMem1;
				Cache[147] <= DataIn;
				Cache[148] <= DataFromMem3;
				Cache[149] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[160] <= DataFromMem;
				Cache[160][1:0] <= 2'b11;			
				Cache[146] <= DataFromMem1;
				Cache[147] <= DataFromMem2;
				Cache[148] <= DataIn;
				Cache[149] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[160] <= DataFromMem;
				Cache[160][1:0] <= 2'b11;			
				Cache[146] <= DataFromMem1;
				Cache[147] <= DataFromMem2;
				Cache[148] <= DataFromMem3;
				Cache[149] <= DataIn;
				end
			endcase
			end

		2'b10:	begin
			counter7 = 2'b11;
			buffer = {Cache[150],Cache[151],Cache[152], Cache[153], Cache[154]};
			case(offset)
			2'b00:	begin
				Cache[150] <= DataFromMem;
				Cache[150][1:0] <= 2'b11;			
				Cache[151] <= DataIn;
				Cache[152]<= DataFromMem2;
				Cache[153] <= DataFromMem3;
				Cache[154] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[150] <= DataFromMem;
				Cache[150][1:0] <= 2'b11;			
				Cache[151] <= DataFromMem1;
				Cache[152] <= DataIn;
				Cache[153] <= DataFromMem3;
				Cache[154] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[150] <= DataFromMem;
				Cache[150][1:0] <= 2'b11;			
				Cache[151] <= DataFromMem1;
				Cache[152] <= DataFromMem2;
				Cache[153] <= DataIn;
				Cache[154] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[150] <= DataFromMem;
				Cache[150][1:0] <= 2'b11;			
				Cache[151] <= DataFromMem1;
				Cache[152] <= DataFromMem2;
				Cache[153] <= DataFromMem3;
				Cache[154] <= DataIn;
				end
			endcase
			end

		2'b11:	begin
			counter7 = 2'b00;
			buffer = {Cache[155],Cache[156],Cache[157], Cache[158], Cache[159]};
			case(offset)
			2'b00:	begin
				Cache[155] <= DataFromMem;
				Cache[155][1:0] <= 2'b11;			
				Cache[156] <= DataIn;
				Cache[157]<= DataFromMem2;
				Cache[158] <= DataFromMem3;
				Cache[159] <= DataFromMem4;
				end
			2'b01:	begin
				Cache[155] <= DataFromMem;
				Cache[155][1:0] <= 2'b11;			
				Cache[156] <= DataFromMem1;
				Cache[157] <= DataIn;
				Cache[158] <= DataFromMem3;
				Cache[159] <= DataFromMem4;
				end
			2'b10:	begin
				Cache[155] <= DataFromMem;
				Cache[155][1:0] <= 2'b11;			
				Cache[156] <= DataFromMem1;
				Cache[157] <= DataFromMem2;
				Cache[158] <= DataIn;
				Cache[159] <= DataFromMem4;
				end
			2'b11:	begin
				Cache[155] <= DataFromMem;
				Cache[155][1:0] <= 2'b11;			
				Cache[156] <= DataFromMem1;
				Cache[157] <= DataFromMem2;
				Cache[158] <= DataFromMem3;
				Cache[159] <= DataIn;
				end
			endcase
			end
		endcase
		end
	else // Read hit
	counter7 = counter7;
	end
endcase


end
endmodule
