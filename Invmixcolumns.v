module inverseMixColumns(state_in,state_out);
input [127:0] state_in;
output [127:0] state_out;

function[7:0] mult(input [7:0]in,input integer z);
integer i;
begin
	for(i=0;i<z;i=i+1)begin
		if(in[7] == 1) in = ((in << 1) ^ 8'h1b);
		else in = in<< 1; 
	end
	mult=in;
end

endfunction


function [7:0] mb_e; 
input [7:0] in;
begin
	mb_e=mult(in,3) ^ mult(in,2)^ mult(in,1);
end
endfunction


function [7:0] mb_d;
input [7:0] in;
begin
	mb_d=mult(in,3) ^ mult(in,2)^ in;
end
endfunction



function [7:0] mb_b; 
input [7:0] in;
begin
	mb_b=mult(in,3) ^ mult(in,1)^ in;
end
endfunction

function [7:0] mb_9;
input [7:0] in;
begin
	mb_9=mult(in,3) ^  in;
end
endfunction
genvar i;
generate 
for(i=0;i< 4;i=i+1) begin : m_col
	assign state_out[(i*32 + 24)+:8]= mb_e(state_in[(i*32 + 24)+:8]) ^ mb_b(state_in[(i*32 + 16)+:8]) ^ mb_d(state_in[(i*32 + 8)+:8]) ^ mb_9(state_in[i*32+:8]);
	assign state_out[(i*32 + 16)+:8]= mb_9(state_in[(i*32 + 24)+:8]) ^ mb_e(state_in[(i*32 + 16)+:8]) ^ mb_b(state_in[(i*32 + 8)+:8]) ^ mb_d(state_in[i*32+:8]);
	assign state_out[(i*32 + 8)+:8]= mb_d(state_in[(i*32 + 24)+:8]) ^ mb_9(state_in[(i*32 + 16)+:8]) ^ mb_e(state_in[(i*32 + 8)+:8]) ^ mb_b(state_in[i*32+:8]);
   assign state_out[i*32+:8]= mb_b(state_in[(i*32 + 24)+:8]) ^ mb_d(state_in[(i*32 + 16)+:8]) ^ mb_9(state_in[(i*32 + 8)+:8]) ^ mb_e(state_in[i*32+:8]);
end
endgenerate
endmodule

module InvMixColumns_tb;
reg [127:0] in;
wire [127:0] out;
wire [127:0] in_wire;
assign in_wire = in;
inverseMixColumns tst(in_wire, out);
initial
begin 
    $monitor("[monitor] in = %h, out = %h", in_wire, out);
    in <= 128'hbd6e7c3df2b5779e0b61216e8b10b689;
    #10;
    in <= 128'hfde3bad205e5d0d73547964ef1fe37f1;
    #10;
    in <= 128'hd1876c0f79c4300ab45594add66ff41f;
    #10;
    in <= 128'hc62fe109f75eedc3cc79395d84f9cf5d;
    #10;
    in <= 128'hc81677bc9b7ac93b25027992b0261996;
    #10;
    in <= 128'h247240236966b3fa6ed2753288425b6c;
    #10;
    in <= 128'hfa636a2825b339c940668a3157244d17;    
    #10;
    in <= 128'h247240236966b3fa6ed2753288425b6c;
    #10;
    in <= 128'h4915598f55e5d7a0daca94fa1f0a63f7;
    #10;
    in <= 128'h89d810e8855ace682d1843d8cb128fe4;
end
    
endmodule