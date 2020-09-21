`define SE20_UI 3'b001
`define SE12_LI 3'b010
`define SE05    3'b011
`define SE12_BR 3'b100
`define SE12_ST 3'b101
`define SE20_JP 3'b110

module signextend(in, out, sel);
	parameter nin = 32;
	parameter nout = 32;
	input [nin-1:nin-25] in;
	input [2:0] sel;
	output reg [nout-1:0] out;
	

	always @(*)
	begin	
	if (sel == `SE20_UI)					// U TYPE
		begin
			out[31:12] = in[31:12];
			out[11:0] = {12{1'b0}};
		end
	else if (sel == `SE12_LI)				//  I TYPE - LOAD INSTRUCTION
		begin
			out[11:0] = in[31:20];
			out[31:12] = {20{in[31]}};
		end
	else if (sel == `SE05)					// SHIFT IMMEDIATE
		begin
			out[4:0] = in[24:20];
			out[31:5] = 0;
		end
	else if (sel == `SE12_BR)				// B TYPE
		begin
			out[0] = {1'b0};
			out[4:1] = in[11:8];
			out[10:5] = in[30:25];
			out[11] = in[7];
			out[12] = in[31];
			out[31:13] = {20{in[31]}};
		end
	else if (sel == `SE12_ST)				// S TYPE
		begin
			out[4:0] = in[11:7];
			out[11:5] = in[31:25];
			out[31:12] = {20{in[31]}};
		end
	else if (sel == `SE20_JP)				// JAL
		begin
			out[9:0] = in[21:30];
			out[10] = in[20];
			out[18:11] = in[19:12];
			out[19] = in[31];
			out[31:20] = {12{in[31]}};
		end	
	else 
		out = 32'hxxxx;	
	end
endmodule
 