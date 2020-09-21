`timescale 1 ns/ 1 ns
`include "mux21.v"
`include "pc.v"
`include "imem.v"
`include "register.v"
`include "branch.v"
`include "alu.v"
`include "mux31.v"
`include "rom.v"
`include "se.v"
`include "memctr.v"
`include "memsel.v"

module RISCV(clk);
input clk;
wire[31:0] pc_out, inst, ALU_Result, ALU_Out, DataR, DataA, DataB, DataD, tmp2, tmp3, DataW, pc_in, pc_4, imm_out, memsel_out;
wire[4:0] AddrD, AddrA, AddrB;
wire[3:0] ALU_Sel;
wire[2:0] ImmSel, MemSel;
wire[1:0] WBSel, MemCtr;
wire RegWEn, BrEq, BrLT, PCsel, BrUN, Asel, Bsel, MemRW;
wire [8:0] instrom;

wire [24:0] imm_in;
wire [3:0] ALUsel;

assign AddrA = {inst[19:15]};
assign AddrB = {inst[24:20]};
assign AddrD = {inst[11:7]};
assign instrom = {inst[30],inst[14:12],inst[6:2]};

mux21 PCmux(pc_in, PCsel, ALU_Out, pc_4);
pc pc(pc_out, pc_in, clk);
pc4 pc4(pc_4, pc_out);
imem imem(inst, pc_out);

register register(AddrD,AddrA,AddrB,DataD,RegWEn,DataA,DataB,clk);

branch branch(BrEq, BrLT, DataA, DataB, BrUn);
mux21 muxA(tmpA, ASel, DataA, pc_out);
mux21 muxB(tmpB, BSel, DataB, imm_out);
se se(imm_out,ImmSel, imm_in);
alu alu(ALU_Out, ALU_Sel, tmpA, tmpB);
mux31 mux31(DataD,WBSel, pc_4, ALU_Out, memsel_out);
rom rom(instrom, BrEq, BrLT, PCsel, ImmSel, BrUN, Asel, Bsel, ALU_Sel, MemRW, RegWEn, MemSel, MemCtr, WBSel);
dmem dmem(DataR, ALU_Out, MemRW, DataW, clk );
memctr memctr(DataW, MemCtr, DataB);
memsel memsel(memsel_out, MemSel, DataR);	
           
 endmodule       
