`timescale 1ns/1ns
module CacheTestFullPath(clk, clkram, valid, request, datai, cs, we_n, re_n, addro, datao);
output [31:0] addro;
output [15:0] datao;
output cs, we_n, re_n;
input [15:0] datai;
input clk, clkram, valid, request;
wire outPC;
wire outI;
wire[6:0] opcode2, opcode6, opcode10, opcode12;
wire[31:0] pc4 ,pc42, inst, imm_out, memsel_out, D, out1, out8, out9;
wire[31:0] tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, tmp10, tmp12, tmpImm;
wire[31:0] DataD, DataA, DataB, DataW, DataR;
wire[31:0] ALU_Out, ALU_In_1, ALU_In_2;
wire[31:0] mux31_out, addr, PC, Imm_Out;
wire[31:0] out21, out3;
wire[24:0] Imm_In, imm_in;
wire[8:0] instrom1, instrom2, instrom3, instrom4;
wire[4:0] AddrD, AddrA, AddrB;
wire[3:0] ALU_Sel2, ALU_Sel3, ALU_Sel4;
wire[2:0] ImmSel2, MemSel2, ImmSel3, MemSel3,ImmSel4, MemSel4;
wire[1:0] WBSel2, MemCtr2, WBSel3, MemCtr3,WBSel4, MemCtr4;
wire[1:0] outA, outB, outC1,outC2,outC3, outD;
wire[1:0] clear, flush2, flush1;
wire[1:0] koplus;
wire prediction, pprediction;
wire clear1, PCSelx, true;
wire V;
wire RegWEn2, BrEq2, BrLT2, PCSel2, BrUn2, ASel2, BSel2, MemRW2;
wire RegWEn3, BrEq3, BrLT3, PCSel3, BrUn3, ASel3, BSel3, MemRW3;
wire RegWEn4, BrEq4, BrLT4, PCSel4, BrUn4, ASel4, BSel4, MemRW4;
assign clear = 2'b00;
assign clear1 = 1'b0;
assign koplus = 2'b00;
assign opcode2 = tmp2[6:0];
assign opcode6 = tmp6[6:0];
assign opcode10 = tmp10[6:0];
assign opcode12 = tmp12[6:0];
assign V = ~MemRW3;

//Forwarding control logic
fforwardCtrlab forwardCtrlab(outI, outA, outB, outC1, outC2, outC3, outD, outPC, tmp2, tmp6, tmp10, tmp12, BrEq2, BrLT2);

//Instruction fetch
IMEM1 IMEM1(inst, PC, clk); //Out, In
assign Imm_In = {inst[31:7]};
se se1(Imm_Out, 3'b100, Imm_In);
pre_add pre_add(addr, PC, Imm_Out);
Dbranch Dbranch(prediction, true, pprediction, outPC, clk, PC, tmp6, pc42, flush1);
pc pc(PC, out1, outI, clk);
pc4 pcA(pc4, PC);
mux21 mux21g(out3, prediction, addr, pc4);
mux31 mux31f(out21, {PCSelx,outPC}, pc42 , ALU_Out, pc4);
ABD ABD(out21, out3, inst, tmp6, outI, true, out1);
truth truth(flush2, flush1, PCSelx, pprediction, outC2, tmp6, outI);
Dff Dff1(tmp1, flush1, PC, tmp1, clk);
Dff Dff2(tmp2, flush1, inst, tmp2, clk);
Dff Dff_Imm(tmpImm, flush1, Imm_Out, tmpImm, clk);

//Instruction decode
assign AddrA = {tmp2[19:15]};
assign AddrB = {tmp2[24:20]};
assign instrom1 = {tmp2[30],tmp2[14:12],tmp2[6:2]};
register register(AddrD,AddrA,AddrB,DataD,RegWEn4,DataA,DataB,clk);
Dff Dff3(tmp3, flush2, tmp1, tmp3, clk);
Dff Dff4(tmp4, flush2, DataA, tmp4, clk);
Dff Dff5(tmp5, flush2, DataB, tmp5, clk);
Dff Dff6(tmp6, flush2, tmp2, tmp6, clk);	
Dff #(9) Dffrom1(instrom2, flush2, instrom1, instrom2, clk);

//Execute
pc4 pc4_2(pc42, tmp3);
assign imm_in = {tmp6[31:7]};
se se(imm_out,ImmSel2, imm_in);
mux21 muxA(ALU_In_1, ASel2, tmp3, out9); //pc, reg, dmem, wb
mux21 muxB(ALU_In_2, BSel2, imm_out, out8); // imm, reg, dmem, wb
mux31 mux311(D, outB, tmp5, DataD, tmp8);
mux31 mux312(out9, outA, tmp4, DataD, tmp8);
mux31 mux313(out8, outB, tmp5, DataD, tmp8);
branch branch(BrEq2, BrLT2, out9, out8, BrUn2);
alu alu(ALU_Out, ALU_Sel2, ALU_In_1, ALU_In_2);
Dff Dff7(tmp7, clear, pc42, tmp7, clk);				
Dff Dff8(tmp8, clear, ALU_Out, tmp8, clk);		
Dff Dff9(tmp9, clear, out8, tmp9, clk);				
Dff Dff10(tmp10, clear, tmp6, tmp10, clk);		
rom11 rom2(instrom2, BrEq2, BrLT2, PCSel2, ImmSel2, BrUn2, ASel2, BSel2, ALU_Sel2, MemRW2, RegWEn2, MemSel2, MemCtr2, WBSel2);
Dff #(9) Dffrom2(instrom3, clear, instrom2, instrom3, clk);

//Memory acces
memctr memctr(DataW, MemCtr3, tmp9);
//CacheModule1 CacheModule1(clk, tmp8, DataW, V, DataR);
//dmem dmem(DataR, MemRW3,tmp8, DataW, clk );
memsel memsel(memsel_out, MemSel3, DataR);	
mux31 mux31(mux31_out, WBSel3, memsel_out, tmp8, tmp7);
ramcontrol ramcontrol(tmp10, DataW, tmp8, valid, request, clk, clkram, cs, we_n, re_n, be_n, datao, addro, rflag);
ramdata ramdata(datai, valid, clkram, rflag, DataR);
Dff Dff11(DataD, clear, mux31_out, DataD, clk);
Dff Dff13(tmp12, clear, tmp10, tmp12, clk);
Dff325 Dff12(AddrD, clear1, tmp10, clk);
assign BrEq3 = 1'b0;
assign BrLT3 = 1'b0;
rom11 rom3(instrom3,BrEq3, BrLT3, PCSel3, ImmSel3, BrUn3, ASel3, BSel3, ALU_Sel3, MemRW3, RegWEn3, MemSel3, MemCtr3, WBSel3);
Dff #(9) Dffrom3(instrom4, clear, instrom3,instrom4, clk);	
//Write back
assign BrEq4 = 1'b0;
assign BrLT4 = 1'b0;
rom11 rom4(instrom4, PCSel4, ImmSel4, BrUn4, ASel4, BSel4, ALU_Sel4, MemRW4, RegWEn4, MemSel4, MemCtr4, WBSel4);
endmodule

