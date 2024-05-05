module keyExpansion #(parameter nk=4, parameter nr=10)(input [0 : 32 * nk - 1] key, output [0 : 128 * (nr + 1) - 1] keyschedule);

assign keyschedule[0 : (nk * 32) - 1] = key;

wire [0 : (128 * nr / nk) - 1] sWord;
wire [0 : 191] sWord256;

 genvar i;
    generate
    if(nk < 8)
        assign sWord256 = 192'h0;
    for (i=nk;i< 4 * (nr + 1);i=i+1)begin: GenerateBlockS

        if(i%nk==0)begin
	    subword swa(rotword(keyschedule[((i - 1) * 32) +: 32]), sWord[(((i / nk) - 1) * 32) +: 32]);
        assign keyschedule[(i * 32) +: 32]=  keyschedule[((i - nk) * 32) +: 32]  ^ sWord[(((i / nk) - 1) * 32) +: 32] ^ rconx(i/nk);
        end
		else if (nk > 6 && i % 8 == 4)begin
    	subword sw256(keyschedule[(i - 1)* 32 +: 32], sWord256[((i - 12) * 4) +: 32]);
        assign keyschedule[(i * 32) +: 32]= sWord256[((i - 12) * 4) +: 32] ^ keyschedule[(( i - 8) * 32) +: 32];
        end        
        else 
        assign keyschedule[((i)*32) +: 32]=  keyschedule[((i - 1) * 32) +: 32] ^ keyschedule[ ((i-nk)*32) +: 32];
        
    end

endgenerate


function[0:31] rconx;
input [0:31] r; 
begin
 case(r)
    4'h1: rconx=32'h01000000;
    4'h2: rconx=32'h02000000;
    4'h3: rconx=32'h04000000;
    4'h4: rconx=32'h08000000;
    4'h5: rconx=32'h10000000;
    4'h6: rconx=32'h20000000;
    4'h7: rconx=32'h40000000;
    4'h8: rconx=32'h80000000;
    4'h9: rconx=32'h1b000000;
    4'ha: rconx=32'h36000000;
    default: rconx=32'h00000000;
  endcase
  end
endfunction


module subword(input [31:0] in, output [31:0] out);
begin
	sBox sbo1(in[7 -: 8], out[7 -: 8]);
	sBox sbo2(in[15 -: 8], out[15 -: 8]);
	sBox sbo3(in[23 -: 8], out[23 -: 8]);
	sBox sbo4(in[31 -: 8], out[31 -: 8]);
end
endmodule


function [0:31] rotword;
	input [0:31] x;
		rotword = {x[8:31], x[0:7]};
endfunction

endmodule

module KeyExpansion128_tbgemy();
	reg [0:255] keyin;
	wire [0:(128*15) - 1] keys;

	KeyExpansion #(8,14) uut(keyin,keys);

	integer i;

	initial begin
		//keyin = 128'h2b7e151628aed2a6abf7158809cf4f3c;
		//keyin = 192'h8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b;
		keyin = 256'h603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4;
		#10;

		for (i = 0; i < 60; i = i + 1) begin
			$display("keys[%0d] = %h", i, keys[(i * 32) +: 32]);
		end
	end
endmodule