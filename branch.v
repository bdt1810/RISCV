`include "dynamic.v"
`include "pattern.v"
`include "GPT.v"
`include "choice.v"
`include "GHT.v"
`include "taken.v"
`include "Dff.v"
module branch(prediction, PCsel, clk, PC, inst);
input PCsel, clk;
input [31:0] PC, inst;
output prediction;
wire lpredict, gpredict, select, plpredict, pgpredict;
wire [9:0] addr1, past1;
wire [11:0] addr2, past2;
wire [21:0] addr, temp;
assign addr = {addr2,addr1,gpredict,lpredict};
dynamic LHR(addr1, PC, inst, PCsel, clk, past1);
pattern LHT(lpredict, addr1, past1, clk, taken1, inst);
GHT GHT(addr2, PCsel, inst, clk);
GPT GPT(gpredict, addr2, past2, clk, taken2, inst);
choice CPT(select, addr2, past2, taken1, taken2, clk, inst);
taken taken(taken1, taken2, inst, plpredict, pgpredict, PCsel, clk);
Dff #(24) Dff1(temp,1'b0,addr,clk);
Dff #(24) Dff2({past2,past1,pgpredict,plpredict},1'b0,temp,clk);
assign prediction = select ? gpredict : lpredict;
endmodule
