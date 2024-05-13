module mixColumns (input[127:0] state, output[127:0] nstate);

function [7:0]mb_2;
input [7:0]in;
begin
if(in[7] == 1)
mb_2=(in << 1)^8'h1b;
else
mb_2=(in << 1);
end
endfunction

function [7:0]mb_3;
input [7:0]in;
begin
mb_3=mb_2(in)^in;
end
endfunction

genvar i;
generate
for (i=0;i<4;i=i+1)begin: mixCol
assign nstate[(i*32)+:8]=mb_2(state[(i*32)+:8])^(state[(i*32+8)+:8])^state[(i*32+16)+:8]^mb_3(state[(i*32+24)+:8]);
assign nstate[(i*32+8)+:8]=mb_3(state[(i*32)+:8])^mb_2(state[(i*32+8)+:8])^(state[(i*32+16)+:8])^state[(i*32+24)+:8];
assign nstate[(i*32+16)+:8]=(state[(i*32)+:8])^mb_3(state[(i*32+8)+:8])^mb_2(state[(i*32+16)+:8])^(state[(i*32+24)+:8]);
assign nstate[(i*32+24)+:8]=(state[(i*32)+:8])^(state[(i*32+8)+:8])^mb_3(state[(i*32+16)+:8])^mb_2(state[(i*32+24)+:8]);
end

endgenerate

endmodule