module CacheModule1(clk, address, DataIn, RW, DataR);
input clk;
input [31:0] address, DataIn;
wire[1:0]hit;
input RW;
output [31:0] DataR;

wire [144:0] buffer, DataFromMem;
wire [31:0] request,DataCacheOut, DataRamOut;
wire [3:0] bufferindex;


NewCache D1(clk, address, DataIn, DataFromMem, RW, hit, DataCacheOut, buffer, request, bufferindex);
//DCache DCache(clk, address, RW, DataIn, DataFromMem, hit, DataCacheOut, request, buffer);
//CacheRam64MB RAM(clk, request, hit, buffer, DataFromMem, DataRamOut);
CacheRam64MB RAM(clk,address,hit, buffer, bufferindex,DataFromMem , DataRamOut);
mux21 X(DataR,hit[1], DataCacheOut, DataRamOut);

endmodule