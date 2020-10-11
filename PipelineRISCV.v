`define clear 1'b0
module ForwardingPath(clk);

input clk;
wire[31:0] pc_in, pc_4, pc_out, pc42, inst, imm_out, memsel_out;
wire[31:0] tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, tmp10, tmp12, tmp11;
wire[31:0] DataD, DataA, DataB, DataW, DataR;
wire[31:0] ALU_Out, ALU_In_1, ALU_In_2;
wire[31:0] mux31_out;
wire[24:0] imm_in;
wire[8:0] instrom1, instrom2, instrom3, instrom4;
wire[4:0] AddrD, AddrA, AddrB;
wire[3:0] ALU_Sel1, ALU_Sel2, ALU_Sel3;
wire[2:0] ImmSel1, MemSel1, ImmSel2, MemSel2, ImmSel3, MemSel3;
wire[1:0] WBSel1, MemCtr1, WBSel2, MemCtr2, WBSel3, MemCtr3;
wire clear;
wire RegWEn1, BrEq1, BrLT1, PCSel1, BrUn1, ASel1, BSel1, MemRW1;
wire RegWEn2, BrEq2, BrLT2, PCSel2, BrUn2, ASel2, BSel2, MemRW2;
wire RegWEn3, BrEq3, BrLT3, PCSel3, BrUn3, ASel3, BSel3, MemRW3;


//Instruction fetch
pc pc(pc_out, pc_in, clk);
pc4 pc4(pc_4, pc_out);
mux21 PCmux(pc_in, PCSel3, ALU_Out, pc_4);
IMEM1 IMEM1(inst,pc_out);
Dff Dff1(tmp1, `clear, pc_out, clk);
Dff Dff2(tmp2, `clear, inst, clk);

//Instruction decode
assign AddrA = {tmp2[19:15]};
assign AddrB = {tmp2[24:20]};
assign instrom1 = {tmp2[30],tmp2[14:12],tmp2[6:2]};
register register(AddrD,AddrA,AddrB,DataD,RegWEn3,DataA,DataB,clk);
Dff Dff3(tmp3, `clear, tmp1, clk);
Dff Dff4(tmp4, `clear, DataA, clk);
Dff Dff5(tmp5, `clear, DataB, clk);
Dff Dff6(tmp6, `clear, tmp2, clk);
rom rom1(instrom1, BrEq1, BrLT1, PCSel1, ImmSel1, BrUn1, ASel1, BSel1, ALU_Sel1, MemRW1, RegWEn1, MemSel1, MemCtr1, WBSel1);
Dffrom Dffrom1(instrom2, `clear, instrom1, clk);

//Execute
assign imm_in = {tmp6[31:7]};
mux21 muxA(ALU_In_1, ASel2, tmp3, tmp4);
mux21 muxB(ALU_In_2, BSel2, imm_out, DataB);
se se(imm_out,ImmSel2, imm_in);
branch branch(BrEq2, BrLT2, tmp4, tmp6, BrUn2);
alu alu(ALU_Out, ALU_Sel2, ALU_In_1, ALU_In_2);
Dff Dff7(tmp7, `clear, tmp3, clk);
Dff Dff8(tmp8, `clear, ALU_Out, clk);
Dff Dff9(tmp9, `clear, tmp5, clk);
Dff Dff10(tmp10, `clear, tmp6, clk);
rom rom2(instrom2, BrEq2, BrLT2, PCSel2, ImmSel2, BrUn2, ASel2, BSel2, ALU_Sel2, MemRW2, RegWEn2, MemSel2, MemCtr2, WBSel2);
Dffrom Dffrom2(instrom3, `clear, instrom2, clk);

//Memory access
pc4 pc4_2(pc42, tmp7);
memctr memctr(DataW, MemCtr3, tmp9);
dmem dmem(DataR,MemRW3,tmp8, DataW, clk);
memsel memsel(memsel_out, MemSel3, DataR);	
mux31 mux31(mux31_out, WBSel3, pc42, tmp8, memsel_out); //pc42(00), tmp8(01), memsel_out(10)
Dff Dff11(tmp11, `clear, mux31_out, clk);
Dff Dff12(tmp12, `clear, tmp10, clk);
rom rom3(instrom3, BrEq3, BrLT3, PCSel3, ImmSel3, BrUn3, ASel3, BSel3, ALU_Sel3, MemRW3, RegWEn3, MemSel3, MemCtr3, WBSel3);
Dffrom Dffrom3(instrom4, `clear, instrom3, clk);

//Write back
assign DataD = tmp11;
assign AddrD = {tmp12[11:7]};

endmodule
