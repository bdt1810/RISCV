`timescale 1 ns/ 1 ns
`include "mux21.v"
`include "pc.v"
`include "IMEM.v"
`include "register.v"
`include "branch.v"
`include "ALU.v"
`include "muu31.v"
`include "rom.v"
`include "se.v"
`include "memctr.v"
`include "memsel.v"

module RISCV(clk);
input clk;
wire[31:0] pc_out, inst, ALU_Result, ALU_Out, DataR, DataA, DataB, DataD, tmp2, tmp3, DataW, pc_in, pc4, imm_out, tmp4;
wire[19:0] temp;
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

mux21 PCmux(pc_in, PCsel, ALU_Out, pc4);
pc PC(clk,pc_in ,pc_out);
add4 add4(pc_out, pc4);
IMEM IMEM(inst, pc_out);
register RegisterFile(AddrD,AddrA,AddrB,DataD,clk,RegWEn,DataA,DataB);
branch branch(DataA, DataB, BrUn, BrEq, BrLT);
mux21 muxA(tmp2, ASel, DataA, pc_out);
mux21 muxB(tmp3, BSel, DataB, imm_out);
signextend signextend1(imm_in, imm_out, ImmSel);
alu alu(tmp2, tmp3, ALU_Sel, ALU_Out);
mux31 mux31(DataD,WBSel, pc4, ALU_Out, tmp4);
rom rom(instrom, BrEq, BrLT, PCsel, ImmSel, BrUN, Asel, Bsel, ALU_Sel, MemRW, RegWEn, MemSel, MemCtr, WBSel,temp);
dmem dmem(clk, DataR, MemRW, ALU_Out, DataW);
memctr memctr1(DataB, DataW, MemCtr);
memsel memse1(DataR, MemSel, tmp4);  
           
 endmodule       

