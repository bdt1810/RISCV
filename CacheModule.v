`include "NewCache.v"
`include "CacheRAM64MB.v"
`include "mux21.v"
module CacheModule(clk, address, DataIn, RW, DataR);
input clk;
input [31:0] address, DataIn;
wire[1:0] RAMhit;
input RW;
output [31:0] DataR;

wire[144:0] DataFromMem,buffer;
wire[144:0] buffer0, buffer1, buffer2, buffer3, buffer4, buffer5, buffer6, buffer7, buffer8;
wire[144:0] buffer9, buffer10, buffer11, buffer12, buffer13, buffer14, buffer15;
wire[31:0] request, DataCacheOut, DataRamOut;
wire[31:0] request0, request1, request2, request3, request4, request5, request6, request7, request8;
wire[31:0] request9, request10, request11, request12, request13, request14, request15;
wire[31:0] DataCacheOut0, DataCacheOut1, DataCacheOut2, DataCacheOut3, DataCacheOut4, DataCacheOut5, DataCacheOut6, DataCacheOut7; 
wire[31:0] DataCacheOut8, DataCacheOut9, DataCacheOut10, DataCacheOut11, DataCacheOut12, DataCacheOut13, DataCacheOut14, DataCacheOut15;
wire[3:0] bufferindex, index;
wire[1:0] hit0, hit1, hit2, hit3, hit4, hit5, hit6, hit7;
wire[1:0] hit8, hit9, hit10, hit11, hit12, hit13, hit14, hit15;
wire[3:0] bufferindex0, bufferindex1, bufferindex2, bufferindex3, bufferindex4, bufferindex5, bufferindex6, bufferindex7, bufferindex8;
wire[3:0] bufferindex9, bufferindex10, bufferindex11, bufferindex12, bufferindex13, bufferindex14, bufferindex15;
assign index = address[5:2];

CacheSelectIndex D(index, active0, active1, active2, active3, active4, active5, active6, active7, active8, active9, active10, active11, active12, active13, active14, active15);
SmallCache  C00 (active0, clk, address, DataIn, DataFromMem, RW, hit0, DataCacheOut0, buffer0, request0, bufferindex0);
SmallCache  C01 (active1, clk, address, DataIn, DataFromMem, RW, hit1, DataCacheOut1, buffer1, request1, bufferindex1);
SmallCache  C02 (active2, clk, address, DataIn, DataFromMem, RW, hit2, DataCacheOut2, buffer2, request2, bufferindex2);
SmallCache  C03 (active3, clk, address, DataIn, DataFromMem, RW, hit3, DataCacheOut3, buffer3, request3, bufferindex3);
SmallCache  C04 (active4, clk, address, DataIn, DataFromMem, RW, hit4, DataCacheOut4, buffer4, request4, bufferindex4);
SmallCache  C05 (active5, clk, address, DataIn, DataFromMem, RW, hit5, DataCacheOut5, buffer5, request5, bufferindex5);
SmallCache  C06 (active6, clk, address, DataIn, DataFromMem, RW, hit6, DataCacheOut6, buffer6, request6, bufferindex6);
SmallCache  C07 (active7, clk, address, DataIn, DataFromMem, RW, hit7, DataCacheOut7, buffer7, request7, bufferindex7);
SmallCache  C08 (active8, clk, address, DataIn, DataFromMem, RW, hit8, DataCacheOut8, buffer8, request8, bufferindex8);
SmallCache  C09 (active9, clk, address, DataIn, DataFromMem, RW, hit9, DataCacheOut9, buffer9, request9, bufferindex9);
SmallCache  C10 (active10, clk, address, DataIn, DataFromMem, RW, hit10, DataCacheOut10, buffer10, request10, bufferindex10);
SmallCache  C11 (active11, clk, address, DataIn, DataFromMem, RW, hit11, DataCacheOut11, buffer11, request11, bufferindex11);
SmallCache  C12 (active12, clk, address, DataIn, DataFromMem, RW, hit12, DataCacheOut12, buffer12, request12, bufferindex12);
SmallCache  C13 (active13, clk, address, DataIn, DataFromMem, RW, hit13, DataCacheOut13, buffer13, request13, bufferindex13);
SmallCache  C14 (active14, clk, address, DataIn, DataFromMem, RW, hit14, DataCacheOut14, buffer14, request14, bufferindex14);
SmallCache  C15 (active15, clk, address, DataIn, DataFromMem, RW, hit15, DataCacheOut15, buffer15, request15, bufferindex15);
mux16to1_2bit mux16to1a(hit0, hit1, hit2, hit3, hit4, hit5, hit6, hit7, hit8, hit9, hit10, hit11, hit12, hit13, hit14, hit15, index, RAMhit);
mux16to1_32bit mux16to1b(DataCacheOut0, DataCacheOut1, DataCacheOut2, DataCacheOut3, DataCacheOut4, DataCacheOut5, DataCacheOut6, DataCacheOut7, DataCacheOut8, DataCacheOut9, DataCacheOut10, DataCacheOut11, DataCacheOut12, DataCacheOut13, DataCacheOut14, DataCacheOut15, index, DataCacheOut);
mux16to1_32bit mux16to1c(request0, request1, request2, request3, request4, request5, request6, request7, request8, request9, request10, request11, request12, request13, request14, request15, index, request);
mux16to1_145bit mux16to1d(buffer0, buffer1, buffer2, buffer3, buffer4, buffer5, buffer6, buffer7, buffer8, buffer9, buffer10, buffer11, buffer12, buffer13, buffer14, buffer15, index, buffer);
mux16to1_4bit mux16to1e(bufferindex0, bufferindex1, bufferindex2, bufferindex3, bufferindex4, bufferindex5, bufferindex6, bufferindex7, bufferindex8, bufferindex9, bufferindex10, bufferindex11, bufferindex12, bufferindex13, bufferindex14, bufferindex15, index, bufferindex);
CacheRam64MB CacheRam64MB(clk, request, RAMhit, buffer, bufferindex, DataFromMem, DataRamOut);

mux21 mux21(DataR, RAMhit[1], DataCacheOut, DataRamOut); // 1: hit   //0: miss

endmodule


