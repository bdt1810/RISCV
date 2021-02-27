`include "CacheComp.v"
`include "CacheRAM64MB.v"
`include "mux21.v"
module CacheModuleCheck(clk, ALU_Out, DataW, RW, DataR);
input clk;
input[31:0] ALU_Out, DataW;
input RW;
output[31:0] DataR;
wire[3:0] index;
wire [1:0] hit;
wire active0, active1, active2, active3, active4, active5, active6, active7, active8, active9, active10, active11, active12, active13, active14, active15;
wire [31:0] DataCacheOut, DataFinalOut, request;
wire [144:0] DataMemIn, DataMemOut;
assign index = ALU_Out[5:2];

begin
CacheSelectIndex CacheSelectIndex(index, active0, active1, active2, active3, active4, active5, active6, active7, active8, active9, active10, active11, active12, active13, active14, active15);
//CacheComp1 CacheComp0(active0, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp1(active1, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp2(active2, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp3(active3, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp4(active4, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp5(active5, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp6(active6, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp7(active7, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp8(active8, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp9(active9, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp10(active10, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp11(active11, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp12(active12, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp13(active13, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp14(active14, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//CacheComp CacheComp15(active15, clk, ALU_Out, DataW, DataMemIn, RW, hit, DataCacheOut, DataMemOut, request);
//
//CacheRam64MB CacheRam64MB(clk, hit, index, request, DataMemOut, DataMemIn, DataFinalOut);
//mux21 mux21(DataR, hit[1], DataFinalOut, DataCacheOut); //0 , 1
end
endmodule


