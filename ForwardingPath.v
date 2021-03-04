`timescale 1ns/1ns
module ForwardingPath(clk);

input clk;
wire outPC;
wire outI;
wire[6:0] opcode2, opcode6, opcode10, opcode12;
wire[31:0] pc_in, pc_out, pc42, inst, imm_out, memsel_out, D, out1, out8, out9;
wire[31:0] tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, tmp10, tmp12;
wire[31:0] DataD, DataA, DataB, DataW, DataR;
wire[31:0] ALU_Out, ALU_In_1, ALU_In_2;
wire[31:0] mux31_out;
wire[24:0] imm_in;
wire[8:0] instrom1, instrom2, instrom3, instrom4, instrom5;
wire[4:0] AddrD, AddrA, AddrB;
wire[3:0] ALU_Sel1, ALU_Sel2, ALU_Sel3, ALU_Sel4;
wire[2:0] ImmSel1, MemSel1, ImmSel2, MemSel2, ImmSel3, MemSel3,ImmSel4, MemSel4;
wire[1:0] WBSel1, MemCtr1, WBSel2, MemCtr2, WBSel3, MemCtr3,WBSel4, MemCtr4;
wire[1:0] outA, outB, outC1,outC2,outC3, outD;
wire[1:0] clear;
wire[1:0] koplus;
wire clear1;
wire[2:0] type;
wire RegWEn1, BrEq1, BrLT1, PCSel1, BrUn1, ASel1, BSel1, MemRW1;
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

//Forwarding control logic
fforwardCtrlab forwardCtrlab(outI, outA, outB, outC1, outC2, outC3, outD, outPC, tmp2, tmp6, tmp10, tmp12, type, BrEq2, BrLT2);

//Instruction fetch
pc pc(pc_out, out1, outI, clk);
//pc4 pc4(pc_in, out1);
mux21 PCmux(out1, outPC, ALU_Out, pc_out);
IMEM1 IMEM1(inst, out1);
Dff Dff1(tmp1, outC1, out1, tmp1, clk);
Dff Dff2(tmp2, outC1, inst, tmp2, clk);

//Instruction decode
assign AddrA = {tmp2[19:15]};
assign AddrB = {tmp2[24:20]};
assign instrom1 = {tmp2[30],tmp2[14:12],tmp2[6:2]};

register register(AddrD,AddrA,AddrB,DataD,RegWEn4,DataA,DataB,clk);
Dff Dff3(tmp3, outC2, tmp1, tmp3, clk);
Dff Dff4(tmp4, outC2, DataA, tmp4, clk);
Dff Dff5(tmp5, outC2, DataB, tmp5, clk);
Dff Dff6(tmp6, outC2, tmp2, tmp6, clk);	
Dffrom Dffrom1(instrom2, outC2, clear1, instrom1, instrom2, clk);

//Execute
assign imm_in = {tmp6[31:7]};
se se(imm_out,ImmSel2, imm_in);
mux21 muxA(ALU_In_1, ASel2, tmp3, out9); //pc, reg, dmem, wb
mux21 muxB(ALU_In_2, BSel2, imm_out, out8); // imm, reg, dmem, wb
mux31 mux311(D, outD, tmp5, DataD, tmp8);
mux31 mux312(out9, outA, tmp4, DataD, tmp8);
mux31 mux313(out8, outB, tmp5, DataD, tmp8);
branch branch(BrEq2, BrLT2, out9, out8, BrUn2);
alu alu(ALU_Out, ALU_Sel2, ALU_In_1, ALU_In_2);
Dff Dff7(tmp7, clear, tmp3, tmp7, clk);		//
Dff Dff8(tmp8, clear, ALU_Out, tmp8, clk);	//
Dff Dff9(tmp9, clear, D, tmp9, clk);		//
Dff Dff10(tmp10, clear, tmp6, tmp10, clk);	//
rom11 rom2(instrom2, BrEq2, BrLT2, PCSel2, ImmSel2, BrUn2, ASel2, BSel2, ALU_Sel2, MemRW2, RegWEn2, MemSel2, MemCtr2, WBSel2);
Dffrom Dffrom2(instrom3, outC2, outI, instrom2,instrom3, clk);

//Memory access
pc4 pc4_2(pc42, tmp7);
memctr memctr(DataW, MemCtr3, tmp9);
dmem dmem(DataR, MemRW3,tmp8, DataW, clk);
memsel memsel(memsel_out, MemSel3, DataR);	
mux31 mux31(mux31_out, WBSel3, memsel_out, tmp8, pc42);
Dff Dff11(DataD, clear, mux31_out, DataD, clk);
Dff Dff13(tmp12, clear, tmp10, tmp12, clk);
Dff325 Dff12(AddrD, clear1, tmp10, clk);
assign BrEq3 = 1'b0;
assign BrLT3 = 1'b0;
rom11 rom3(instrom3,BrEq3, BrLT3, PCSel3, ImmSel3, BrUn3, ASel3, BSel3, ALU_Sel3, MemRW3, RegWEn3, MemSel3, MemCtr3, WBSel3);
Dffrom Dffrom3(instrom4, clear, outI, instrom3,instrom4, clk);	//

//Write back
assign BrEq4 = 1'b0;
assign BrLT4 = 1'b0;
rom12 rom4(instrom4, PCSel4, ImmSel4, BrUn4, ASel4, BSel4, ALU_Sel4, MemRW4, RegWEn4, MemSel4, MemCtr4, WBSel4);
Dffrom Dffrom4(instrom5, clear,clear1, instrom4, instrom5, clk);
endmodule

