
//Main memory = 64M => 2^6 x 2^20 = 2^26 bit
// 2^26 bit/32 = 2^26/2^5 = 2^21
// Use 21 bit => 21 - 2 bit offset - 4 bit index = 15 bit tag
// reg [144:0] = [ 144->130 | 129->98 | 97->66 | 65->34 | 33->2 | 1 | 0 ] [valid + dirty]

//Cache
//32 bit address (calculated by ALU)
//address = [ 20->6 | 5->2 | 1->0 ]

module CacheComp1(active, clk, address, DataIn, DataFromMem, RW, hit, DataOut, DataToMem, request);
input [31:0] address, DataIn;
input clk, RW, active; // 1 Read, 0 Write 
input [144:0] DataFromMem;
output reg[144:0] DataToMem;
output reg[31:0] DataOut, request;
output reg[1:0] hit;
wire [1:0] offset;
wire [3:0] index;
wire [15:0] tag;
reg [1:0] counterRW,counter; // 00
reg [144:0] tag0, tag1, tag2, tag3, tagW, tagdata, tagbuffer;
reg [144:0] Cache0000 [0:3];     // 15bit tag + 32x4bit data + 1 valid + 1 dirty 
assign  offset = address[1:0];
assign  index = address[5:2];
assign  tag = address[20:6];

initial
begin
Cache0000[0] <= 145'd0;
Cache0000[1] <= 145'd0;
Cache0000[2] <= 145'd0;
Cache0000[3] <= 145'd0;
assign counter = 2'b00;
end

always @(posedge clk & active === 1'b1)
begin
	if(RW === 1'b1) //Read
		begin
		tag0 <= Cache0000[0];
		tag1 <= Cache0000[1];
		tag2 <= Cache0000[2];
		tag3 <= Cache0000[3];
		if (tag0[1] === 1'b0 | tag1[1] === 1'b0 | tag2[1] === 1'b0 | tag3[1] === 1'b0)
		begin
		if (tag0[1] === 1'b0)
		begin
		hit = 2'b01;
		request = address;
		end
		else if(tag1[1] === 1'b0)
		begin
		hit = 2'b01;
		request = address;
		end
		else if(tag2[0] === 1'b0)
		begin
		hit = 2'b01;
		request = address;
		end
		else if (tag3[0] === 1'b0)
		begin
		hit = 2'b01;
		request = address;
		end
		end
		else
				begin
				if (tag === tag0[144:130] & tag0[1] === 1'b1)
					begin
					case (offset)
					2'b00:	DataOut = tag0[33:2];
					2'b01:	DataOut = tag0[65:34];
					2'b10:	DataOut = tag0[97:66];
					2'b11:	DataOut = tag0[129:98];
					endcase
					hit <= 2'b11;
					end
				else if (tag === tag1[144:130] & tag1[1] === 1'b1)
					begin
					case (offset)
					2'b00:	DataOut = tag1[33:2];
					2'b01:	DataOut = tag1[65:34];
					2'b10:	DataOut = tag1[97:66];
					2'b11:	DataOut = tag1[129:98];
					endcase
					hit <= 2'b11;
					end
				else if (tag === tag2[144:130] & tag2[1] === 1'b1)
					begin
					case (offset)
					2'b00:	DataOut = tag2[33:2];
					2'b01:	DataOut = tag2[65:34];
					2'b10:	DataOut = tag2[97:66];
					2'b11:	DataOut = tag2[129:98];
					endcase
					hit <= 2'b11;
					end
				else if (tag === tag3[144:130] & tag3[1] === 1'b1)
					begin
					case (offset)
					2'b00:	DataOut = tag3[33:2];
					2'b01:	DataOut = tag3[65:34];
					2'b10:	DataOut = tag3[97:66];
					2'b11:	DataOut = tag3[129:98];
					endcase
					hit = 2'b11;
					end
				else
					begin
						hit = 2'b01;
						request = address;
					end
			end
		end



	else  // Write 
	begin

		tag0 <= Cache0000[0];
		tag1 <= Cache0000[1];
		tag2 <= Cache0000[2];
		tag3 <= Cache0000[3];

		if (tag0[1] === 1'b0 | tag1[1] === 1'b0 | tag2[1] === 1'b0 | tag3[1] === 1'b0)
		begin
		if (tag0[1] === 1'b0)
		begin
		hit <= 2'b00;
		request <= address;
		end
		else if(tag1[1] === 1'b0)
		begin
		hit <= 2'b00;
		request <= address;
		end
		else if(tag2[0] === 1'b0)
		begin
		hit <= 2'b00;
		request <= address;
		end
		else if (tag3[0] === 1'b0)
		begin
		hit <= 2'b00;
		request <= address;
		end
		end
		

		else
				begin
				if (tag === tag0[144:130] & tag0[1] === 1'b1)
					begin
					case (offset)
					2'b00:
						begin
						tag0[33:2] <= DataIn;
						tag0[0] <= 1'b1;
						end
					2'b01:	
						begin
						tag0[65:34] <= DataIn;
						tag0[0] <= 1'b1;
						end					
					2'b10:	
						begin
						tag0[97:66] <= DataIn;
						tag0[0] <= 1'b1;
						end
					2'b11:	
						begin
						tag0[129:98] <= DataIn;
						tag0[0] <= 1'b1;
						end
					endcase
					Cache0000[0] <= tag0;
					hit = 2'b10;
					end
				else if (tag === tag1[144:130] & tag1[1] === 1'b1)
					begin
					case (offset)
					2'b00:
						begin
						tag1[33:2] <= DataIn;
						tag1[0] <= 1'b1;
						end
					2'b01:	
						begin
						tag1[65:34] <= DataIn;
						tag1[0] <= 1'b1;
						end					
					2'b10:
						begin
						tag1[97:66] <= DataIn;
						tag1[0] <= 1'b1;
						end
					2'b11:	
						begin
						tag1[129:98] <= DataIn;
						tag1[0] <= 1'b1;
						end
					endcase
					Cache0000[1] <= tag1;
					hit = 2'b10;
					end
				else if (tag === tag2[144:130] & tag2[1] === 1'b1)
					begin
					case (offset)
					2'b00:
						begin
						tag2[33:2] <= DataIn;
						tag2[0] <= 1'b1;
						end
					2'b01:	
						begin
						tag2[65:34] <= DataIn;
						tag2[0] <= 1'b1;
						end					
					2'b10:	
						begin
						tag2[97:66] <= DataIn;
						tag2[0] <= 1'b1;
						end
					2'b11:	
						begin
						tag2[129:98] <= DataIn;
						tag2[0] <= 1'b1;
						end
					endcase
					Cache0000[2] <= tag2;
					hit = 2'b10;
					end
				else if (tag === tag3[144:130] & tag3[1] === 1'b1)
					begin
					case (offset)
					2'b00:
						begin
						tag3[33:2] <= DataIn;
						tag3[0] <= 1'b1;
						end
					2'b01:	
						begin
						tag3[65:34] <= DataIn;
						tag3[0] <= 1'b1;
						end					
					2'b10:	
						begin
						tag3[97:66] <= DataIn;
						tag3[0] <= 1'b1;
						end
					2'b11:	
						begin
						tag3[129:98] <= DataIn;
						tag3[0] <= 1'b1;
						end
					endcase
					Cache0000[3] <= tag3;
					hit = 2'b10;
					end
				else
					counter = counter;
			end
		end
end
always @(negedge clk & active === 1'b1) //ghi tu memory vao Cache
begin
	if(DataFromMem !== 144'b0)
		begin
		tag0 <= Cache0000[0];
		tag1 <= Cache0000[1];
		tag2 <= Cache0000[2];
		tag3 <= Cache0000[3];
		case(counter)
		2'b00:
			begin
			if (tag0[0] === 1'b0)			//  No Dirty
				begin
				if (RW === 1'b1 && hit[1] === 1'b0) 		//Read
				Cache0000[0] <= DataFromMem;
				else 				//Write 
				begin
				tagdata = DataFromMem;
				counter = 2'b10;
				case(offset)
				2'b00:	begin
					tagdata[32:2] <= DataIn;
					tagdata[0] <= 1'b1;
					Cache0000[0] <= tagdata;
					end
				2'b01:	begin
					tagdata[65:34] <= DataIn;
					tagdata[0] <= 1'b1;
					Cache0000[0] <= tagdata;
					end
				2'b10:	begin
					tagdata[97:66] <= DataIn;
					tagdata[0] <= 1'b1;
					Cache0000[0] <= tagdata;
					end
				2'b11:	begin
					tagdata[129:98] <= DataIn;
					tagdata[0] <= 1'b1;
					Cache0000[0] <= tagdata;
					end
				endcase
				end				
				end
			else 					// Dirty
				begin
				tagbuffer <= tag0;
				tagdata <= DataFromMem;
				counter <= 2'b10;
				case(offset)
				2'b00:	begin
					tagdata[33:2] <= DataIn;
					tagdata[0] <= 1'b1;
					Cache0000[0] <= tagdata;
					end
				2'b01:	begin
					tagdata[65:34] <= DataIn;
					tagdata[0] <= 1'b1;
					Cache0000[0] <= tagdata;
					end
				2'b10:	begin
					tagdata[97:66] <= DataIn;
					tagdata[0] <= 1'b1;
					Cache0000[0] <= tagdata;
					end
				2'b11:	begin
					tagdata[129:98] <= DataIn;
					tagdata[0] <= 1'b1;
					Cache0000[0] <= tagdata;
					end
				endcase
				end
			end
		2'b01:
			begin
			if (tag1[0] === 1'b0)			//  No Dirty
				begin
				if (RW === 1'b1) 		//Read
				Cache0000[1] <= DataFromMem;
				else 				//Write 
				begin
				tagdata <= DataFromMem;
				counter <= 2'b10;
				case(offset)
				2'b00:	begin
					tagdata[33:2] <= DataIn;
					tagdata[0] <= 1'b1;
					Cache0000[1] <= tagdata;
					end
				2'b01:	begin
					tagdata[65:34] = DataIn;
					tagdata[0] <= 1'b1;
					Cache0000[1] <= tagdata;
					end
				2'b10:	begin
					tagdata[97:66] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[1] <= tagdata;
					end
				2'b11:	begin
					tagdata[129:98] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[1] <= tagdata;
					end
				endcase
				end				
				end
			else 					// Dirty
				begin
				tagdata = DataFromMem;
				tagbuffer <= tag1;
				counter = 2'b10;
				case(offset)
				2'b00:	begin
					tagdata[33:2] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[1] <= tagdata;
					end
				2'b01:	begin
					tagdata[65:34] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[1] <= tagdata;
					end
				2'b10:	begin
					tagdata[97:66] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[1] <= tagdata;
					end
				2'b11:	begin
					tagdata[129:98] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[1] <= tagdata;
					end
				endcase
				end
			end
		2'b10:	begin
			if (tag2[0] === 1'b0)			//  No Dirty
				begin
				if (RW === 1'b1) 		//Read
				Cache0000[2] <= DataFromMem;
				else 				//Write 
				begin
				tagdata = DataFromMem;
				counter = 2'b11;
				case(offset)
				2'b00:	begin
					tagdata[33:2] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[2] <= tagdata;
					end
				2'b01:	begin
					tagdata[65:34] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[2] <= tagdata;
					end
				2'b10:	begin
					tagdata[97:66] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[2] <= tagdata;
					end
				2'b11:	begin
					tagdata[129:98] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[2] <= tagdata;
					end
				endcase
				end				
				end
			else 					// Dirty
				begin
				tagdata = DataFromMem;
				tagbuffer <= tag2;
				counter = 2'b11;
				case(offset)
				2'b00:	begin
					tagdata[33:2] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[0] <= tagdata;
					end
				2'b01:	begin
					tagdata[65:34] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[0] <= tagdata;
					end
				2'b10:	begin
					tagdata[97:66] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[0] <= tagdata;
					end
				2'b11:	begin
					tagdata[129:98] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[0] <= tagdata;
					end
				endcase
				end
			end
		2'b11:	begin
			if (tag3[0] === 1'b0)			//  No Dirty
				begin
				if (RW === 1'b1) 		//Read
				Cache0000[3] <= DataFromMem;
				else 				//Write 
				begin
				tagdata = DataFromMem;
				counter = 2'b00;
				case(offset)
				2'b00:	begin
					tagdata[33:2] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[3] <= tagdata;
					end
				2'b01:	begin
					tagdata[65:34] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[3] <= tagdata;
					end
				2'b10:	begin
					tagdata[97:66] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[3] <= tagdata;
					end
				2'b11:	begin
					tagdata[129:98] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[3] <= tagdata;
					end
				endcase
				end				
				end
			else 					// Dirty
				begin
				tagdata = DataFromMem;
				tagbuffer <= tag3;
				counter = 2'b00;
				case(offset)
				2'b00:	begin
					tagdata[33:2] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[3] <= tagdata;
					end
				2'b01:	begin
					tagdata[65:34] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[3] <= tagdata;
					end
				2'b10:	begin
					tagdata[97:66] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[3] <= tagdata;
					end
				2'b11:	begin
					tagdata[129:98] = DataIn;
					tagdata[0] = 1'b1;
					Cache0000[3] <= tagdata;
					end
				endcase
				end
			end
		endcase
		end
end
endmodule
//
