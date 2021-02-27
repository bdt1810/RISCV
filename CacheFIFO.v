`include "CacheSelectIndex.v"
module CacheFIFO(In,Index, Sel, Out);
input [144:0] In;
input [3:0] Index;
output reg [1:0]Sel;
output reg [144:0] Out;

initial 
begin
Sel = 2'b11;
end

always @(*)
begin
	if(In !== 144'b0)
	begin
		if(Sel === 2'b11)
		begin
		Out = In;
		Sel = 2'b00;
		end
	else
		begin
		Out = In;
		Sel = Sel + 1'b1;
		end
	end
	else
		begin
		Sel = Sel;
		end
	
end
endmodule
