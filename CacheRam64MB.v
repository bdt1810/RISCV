module CacheRam64MB(clk,address,hit, buffer, bufferindex, DataOut, DataRamOut);
input [31:0] address;
input [144:0] buffer;
input [1:0] hit;
input [3:0] bufferindex;
output reg [144:0] DataOut;
output reg [31:0] DataRamOut;
input clk;
wire [31:0] Otest0, Otest1, Otest2, Otest3;
wire [31:0] Itest0,  Itest1, Itest2, Itest3;

assign Itest0[31:21] = 11'b0;
assign Itest0[20:6] = buffer[144:130];
assign Itest0[5:2] = bufferindex;
assign Itest0[1:0] = 2'b00;

assign Itest1[31:21] = 11'b0;
assign Itest1[20:6] = buffer[144:130];
assign Itest1[5:2] = bufferindex;
assign Itest1[1:0] = 2'b01;

assign Itest2[31:21] = 11'b0;
assign Itest2[20:6] = buffer[144:130];
assign Itest2[5:2] = bufferindex;
assign Itest2[1:0] = 2'b10;

assign Itest3[31:21] = 11'b0;
assign Itest3[20:6] = buffer[144:130];
assign Itest3[5:2] = bufferindex;
assign Itest3[1:0] = 2'b11;


assign  Otest0[31:2] = address[31:2];
assign  Otest0[1:0] = 2'b00;
assign  Otest1[31:2] = address[31:2];
assign  Otest1[1:0] = 2'b01;
assign  Otest2[31:2] = address[31:2];
assign  Otest2[1:0] = 2'b10;
assign  Otest3[31:2] = address[31:2];
assign  Otest3[1:0] = 2'b11;

reg [31:0]RAM[0:9000];

integer i;
initial 
begin
	for (i=0; i<9001; i=i+1)
		RAM[i] <= 32'h0;	
end
	always @(buffer)
	begin
		if(buffer[0] === 1'b1)  //Dirty
		begin
		RAM[Itest0] <= buffer[33:2];
		RAM[Itest1] <= buffer[65:34];
		RAM[Itest2] <= buffer[97:66];
		RAM[Itest3] <= buffer[129:98];
		end	
	end

always @(posedge clk or address)
begin
	begin
	DataRamOut <= RAM[address];
	if (address === 32'd0)
	begin
	DataOut[33:2] <= RAM[Otest0];
	DataOut[65:34] <= RAM[Otest1];
	DataOut[97:66] <= RAM[Otest2];
	DataOut[129:98] <= RAM[Otest3];
	DataOut[144:130] <= address[20:6];
	DataOut[1] = 1'b1; 
	DataOut[0] = 1'b0; // 1 is Valid, 0 is Dirty
	end
	else
	begin
	DataOut[33:2] <= RAM[Otest0];
	DataOut[65:34] <= RAM[Otest1];
	DataOut[97:66] <= RAM[Otest2];
	DataOut[129:98] <= RAM[Otest3];
	DataOut[144:130] <= address[20:6];
	DataOut[1] = 1'b1; 
	DataOut[0] = 1'b0; // 1 is Valid, 0 is Dirty
	end
	
	end
	
end
endmodule