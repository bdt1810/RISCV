//`include "dynamic.v"
//`include "pattern.v"
//`include "GPT.v"
//`include "choice.v"
//`include "GHT.v"
//`include "taken.v"
//`include "Dffx.v"
module Dbranch(prediction, true, pprediction, PCsel, clk, PC, inst, pastPC, flush);
input PCsel, clk;
input [1:0] flush;
input [31:0] PC, inst, pastPC;
output prediction, true, pprediction;
wire lpredict, gpredict, select, plpredict, pgpredict, taken1, taken2;
wire [9:0] addr1, past1;
wire [9:0] addr2, past2;
wire [22:0] addr, temp;
assign addr = {addr2,addr1,gpredict,lpredict,prediction};
dynamic LHR(addr1, PC, inst, PCsel, pastPC);
pattern LHT(lpredict, addr1, past1, taken1, inst);
GHT GHT(addr2, PCsel, inst);
GPT GPT(gpredict, addr2, past2, taken2, inst);
choice CPT(select, addr2, past2, taken1, taken2, inst);
taken taken(true, taken1, taken2, inst, pprediction, plpredict, pgpredict, PCsel, clk);
D_ff #(23) Dff1(temp, flush, addr, temp, clk);
D_ff #(23) Dff2({past2,past1,pgpredict,plpredict,pprediction}, flush, temp, {past2,past1,pgpredict,plpredict,pprediction}, clk);
//Dffx #(1)  Dff3(pprediction,1'b0,prediction,clk); 
assign prediction = select ? gpredict : lpredict;
endmodule
