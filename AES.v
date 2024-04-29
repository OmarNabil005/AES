///////////////////////////////////////////////////KeyExpansion//////////////////////////////////
module KeyExpansion (input [0:127] key, output [0:1407] keyschedule );


assign keyschedule[0:127]=key;


genvar i;

generate
    for(i=4;i<44;i=i+1)begin : GenerateBlock //generate word by word from (4) to (43)
        if(i%4==0)begin
        assign keyschedule[(i * 32) +: 32]=Rotate(subword(keyschedule[(i - 1)* 32 +: 32]))^ keyschedule[( i - 4) * 32 +: 32] ^Rcon(i/4);
        end
        else begin
        assign keyschedule[(i * 32) +: 32]= keyschedule[( i - 4) * 32 +: 32] ^ keyschedule[(i - 1)* 32 +: 32];
        end
    end
endgenerate






function[0:31] Rcon;
input [0:31] r; 
begin
 case(r)
    4'h1: Rcon=32'h01000000;
    4'h2: Rcon=32'h02000000;
    4'h3: Rcon=32'h04000000;
    4'h4: Rcon=32'h08000000;
    4'h5: Rcon=32'h10000000;
    4'h6: Rcon=32'h20000000;
    4'h7: Rcon=32'h40000000;
    4'h8: Rcon=32'h80000000;
    4'h9: Rcon=32'h1b000000;
    4'ha: Rcon=32'h36000000;
    default: Rcon=32'h00000000;
  endcase
  end
endfunction






function[31:0] subword(input [31:0] in);
begin
subword[7:0]=c(in[7:0]);
subword[15:8]=c(in[15:8]);
subword[23:16]=c(in[23:16]);
subword[31:24]=c(in[31:24]);
end
endfunction


function [7:0] c(input [7:0] in);  
begin
    case (in)
      8'h00: c=8'h63;
	   8'h01: c=8'h7c;
	   8'h02: c=8'h77;
	   8'h03: c=8'h7b;
	   8'h04: c=8'hf2;
	   8'h05: c=8'h6b;
	   8'h06: c=8'h6f;
	   8'h07: c=8'hc5;
	   8'h08: c=8'h30;
	   8'h09: c=8'h01;
	   8'h0a: c=8'h67;
	   8'h0b: c=8'h2b;
	   8'h0c: c=8'hfe;
	   8'h0d: c=8'hd7;
	   8'h0e: c=8'hab;
	   8'h0f: c=8'h76;
	   8'h10: c=8'hca;
	   8'h11: c=8'h82;
	   8'h12: c=8'hc9;
	   8'h13: c=8'h7d;
	   8'h14: c=8'hfa;
	   8'h15: c=8'h59;
	   8'h16: c=8'h47;
	   8'h17: c=8'hf0;
	   8'h18: c=8'had;
	   8'h19: c=8'hd4;
	   8'h1a: c=8'ha2;
	   8'h1b: c=8'haf;
	   8'h1c: c=8'h9c;
	   8'h1d: c=8'ha4;
	   8'h1e: c=8'h72;
	   8'h1f: c=8'hc0;
	   8'h20: c=8'hb7;
	   8'h21: c=8'hfd;
	   8'h22: c=8'h93;
	   8'h23: c=8'h26;
	   8'h24: c=8'h36;
	   8'h25: c=8'h3f;
	   8'h26: c=8'hf7;
	   8'h27: c=8'hcc;
	   8'h28: c=8'h34;
	   8'h29: c=8'ha5;
	   8'h2a: c=8'he5;
	   8'h2b: c=8'hf1;
	   8'h2c: c=8'h71;
	   8'h2d: c=8'hd8;
	   8'h2e: c=8'h31;
	   8'h2f: c=8'h15;
	   8'h30: c=8'h04;
	   8'h31: c=8'hc7;
	   8'h32: c=8'h23;
	   8'h33: c=8'hc3;
	   8'h34: c=8'h18;
	   8'h35: c=8'h96;
	   8'h36: c=8'h05;
	   8'h37: c=8'h9a;
	   8'h38: c=8'h07;
	   8'h39: c=8'h12;
	   8'h3a: c=8'h80;
	   8'h3b: c=8'he2;
	   8'h3c: c=8'heb;
	   8'h3d: c=8'h27;
	   8'h3e: c=8'hb2;
	   8'h3f: c=8'h75;
	   8'h40: c=8'h09;
	   8'h41: c=8'h83;
	   8'h42: c=8'h2c;
	   8'h43: c=8'h1a;
	   8'h44: c=8'h1b;
	   8'h45: c=8'h6e;
	   8'h46: c=8'h5a;
	   8'h47: c=8'ha0;
	   8'h48: c=8'h52;
	   8'h49: c=8'h3b;
	   8'h4a: c=8'hd6;
	   8'h4b: c=8'hb3;
	   8'h4c: c=8'h29;
	   8'h4d: c=8'he3;
	   8'h4e: c=8'h2f;
	   8'h4f: c=8'h84;
	   8'h50: c=8'h53;
	   8'h51: c=8'hd1;
	   8'h52: c=8'h00;
	   8'h53: c=8'hed;
	   8'h54: c=8'h20;
	   8'h55: c=8'hfc;
	   8'h56: c=8'hb1;
	   8'h57: c=8'h5b;
	   8'h58: c=8'h6a;
	   8'h59: c=8'hcb;
	   8'h5a: c=8'hbe;
	   8'h5b: c=8'h39;
	   8'h5c: c=8'h4a;
	   8'h5d: c=8'h4c;
	   8'h5e: c=8'h58;
	   8'h5f: c=8'hcf;
	   8'h60: c=8'hd0;
	   8'h61: c=8'hef;
	   8'h62: c=8'haa;
	   8'h63: c=8'hfb;
	   8'h64: c=8'h43;
	   8'h65: c=8'h4d;
	   8'h66: c=8'h33;
	   8'h67: c=8'h85;
	   8'h68: c=8'h45;
	   8'h69: c=8'hf9;
	   8'h6a: c=8'h02;
	   8'h6b: c=8'h7f;
	   8'h6c: c=8'h50;
	   8'h6d: c=8'h3c;
	   8'h6e: c=8'h9f;
	   8'h6f: c=8'ha8;
	   8'h70: c=8'h51;
	   8'h71: c=8'ha3;
	   8'h72: c=8'h40;
	   8'h73: c=8'h8f;
	   8'h74: c=8'h92;
	   8'h75: c=8'h9d;
	   8'h76: c=8'h38;
	   8'h77: c=8'hf5;
	   8'h78: c=8'hbc;
	   8'h79: c=8'hb6;
	   8'h7a: c=8'hda;
	   8'h7b: c=8'h21;
	   8'h7c: c=8'h10;
	   8'h7d: c=8'hff;
	   8'h7e: c=8'hf3;
	   8'h7f: c=8'hd2;
	   8'h80: c=8'hcd;
	   8'h81: c=8'h0c;
	   8'h82: c=8'h13;
	   8'h83: c=8'hec;
	   8'h84: c=8'h5f;
	   8'h85: c=8'h97;
	   8'h86: c=8'h44;
	   8'h87: c=8'h17;
	   8'h88: c=8'hc4;
	   8'h89: c=8'ha7;
	   8'h8a: c=8'h7e;
	   8'h8b: c=8'h3d;
	   8'h8c: c=8'h64;
	   8'h8d: c=8'h5d;
	   8'h8e: c=8'h19;
	   8'h8f: c=8'h73;
	   8'h90: c=8'h60;
	   8'h91: c=8'h81;
	   8'h92: c=8'h4f;
	   8'h93: c=8'hdc;
	   8'h94: c=8'h22;
	   8'h95: c=8'h2a;
	   8'h96: c=8'h90;
	   8'h97: c=8'h88;
	   8'h98: c=8'h46;
	   8'h99: c=8'hee;
	   8'h9a: c=8'hb8;
	   8'h9b: c=8'h14;
	   8'h9c: c=8'hde;
	   8'h9d: c=8'h5e;
	   8'h9e: c=8'h0b;
	   8'h9f: c=8'hdb;
	   8'ha0: c=8'he0;
	   8'ha1: c=8'h32;
	   8'ha2: c=8'h3a;
	   8'ha3: c=8'h0a;
	   8'ha4: c=8'h49;
	   8'ha5: c=8'h06;
	   8'ha6: c=8'h24;
	   8'ha7: c=8'h5c;
	   8'ha8: c=8'hc2;
	   8'ha9: c=8'hd3;
	   8'haa: c=8'hac;
	   8'hab: c=8'h62;
	   8'hac: c=8'h91;
	   8'had: c=8'h95;
	   8'hae: c=8'he4;
	   8'haf: c=8'h79;
	   8'hb0: c=8'he7;
	   8'hb1: c=8'hc8;
	   8'hb2: c=8'h37;
	   8'hb3: c=8'h6d;
	   8'hb4: c=8'h8d;
	   8'hb5: c=8'hd5;
	   8'hb6: c=8'h4e;
	   8'hb7: c=8'ha9;
	   8'hb8: c=8'h6c;
	   8'hb9: c=8'h56;
	   8'hba: c=8'hf4;
	   8'hbb: c=8'hea;
	   8'hbc: c=8'h65;
	   8'hbd: c=8'h7a;
	   8'hbe: c=8'hae;
	   8'hbf: c=8'h08;
	   8'hc0: c=8'hba;
	   8'hc1: c=8'h78;
	   8'hc2: c=8'h25;
	   8'hc3: c=8'h2e;
	   8'hc4: c=8'h1c;
	   8'hc5: c=8'ha6;
	   8'hc6: c=8'hb4;
	   8'hc7: c=8'hc6;
	   8'hc8: c=8'he8;
	   8'hc9: c=8'hdd;
	   8'hca: c=8'h74;
	   8'hcb: c=8'h1f;
	   8'hcc: c=8'h4b;
	   8'hcd: c=8'hbd;
	   8'hce: c=8'h8b;
	   8'hcf: c=8'h8a;
	   8'hd0: c=8'h70;
	   8'hd1: c=8'h3e;
	   8'hd2: c=8'hb5;
	   8'hd3: c=8'h66;
	   8'hd4: c=8'h48;
	   8'hd5: c=8'h03;
	   8'hd6: c=8'hf6;
	   8'hd7: c=8'h0e;
	   8'hd8: c=8'h61;
	   8'hd9: c=8'h35;
	   8'hda: c=8'h57;
	   8'hdb: c=8'hb9;
	   8'hdc: c=8'h86;
	   8'hdd: c=8'hc1;
	   8'hde: c=8'h1d;
	   8'hdf: c=8'h9e;
	   8'he0: c=8'he1;
	   8'he1: c=8'hf8;
	   8'he2: c=8'h98;
	   8'he3: c=8'h11;
	   8'he4: c=8'h69;
	   8'he5: c=8'hd9;
	   8'he6: c=8'h8e;
	   8'he7: c=8'h94;
	   8'he8: c=8'h9b;
	   8'he9: c=8'h1e;
	   8'hea: c=8'h87;
	   8'heb: c=8'he9;
	   8'hec: c=8'hce;
	   8'hed: c=8'h55;
	   8'hee: c=8'h28;
	   8'hef: c=8'hdf;
	   8'hf0: c=8'h8c;
	   8'hf1: c=8'ha1;
	   8'hf2: c=8'h89;
	   8'hf3: c=8'h0d;
	   8'hf4: c=8'hbf;
	   8'hf5: c=8'he6;
	   8'hf6: c=8'h42;
	   8'hf7: c=8'h68;
	   8'hf8: c=8'h41;
	   8'hf9: c=8'h99;
	   8'hfa: c=8'h2d;
	   8'hfb: c=8'h0f;
	   8'hfc: c=8'hb0;
	   8'hfd: c=8'h54;
	   8'hfe: c=8'hbb;
	   8'hff: c=8'h16;
	endcase
end
endfunction





function [31:0] Rotate(input[0:31] in);
    Rotate = {in[8:31], in[0:7]};
endfunction



endmodule

//AddRoundKey
module AddRoundKey(input[127:0] state, input[127:0]Key, output [127:0]nstate);

assign nstate = state ^ Key;

endmodule



///////////////////////////////////////////////////////MixColumns&Inv MixCoilumns/////////////////////////////////////////////

module mixcolumns (input[127:0] state,
output[127:0]nstate

);

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
for(i=0;i<4;i=i+1)begin
assign nstate[(i*32)+:8]=mb_2(state[(i*32)+:8])^(state[(i*32+8)+:8])^state[(i*32+16)+:8]^mb_3(state[(i*32+24)+:8]);
assign nstate[(i*32+8)+:8]=mb_3(state[(i*32)+:8])^mb_2(state[(i*32+8)+:8])^(state[(i*32+16)+:8])^state[(i*32+24)+:8];
assign nstate[(i*32+16)+:8]=(state[(i*32)+:8])^mb_3(state[(i*32+8)+:8])^mb_2(state[(i*32+16)+:8])^(state[(i*32+24)+:8]);
assign nstate[(i*32+24)+:8]=(state[(i*32)+:8])^(state[(i*32+8)+:8])^mb_3(state[(i*32+16)+:8])^mb_2(state[(i*32+24)+:8]);
end

endgenerate

endmodule




////Inv////


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


/////////////////////////////////////////SubBytes&&Inv SubBytes///////////////////////////////////////

@ -1,272 +0,0 @@
module SubBytes(input[127:0] state, output reg[127:0] out);

reg[7:0] s_box[0:255];

initial begin
    s_box[0] = 8'h63;
    s_box[1] = 8'h7c;
    s_box[2] = 8'h77;
    s_box[3] = 8'h7b;
    s_box[4] = 8'hf2;
    s_box[5] = 8'h6b;
    s_box[6] = 8'h6f;
    s_box[7] = 8'hc5;
    s_box[8] = 8'h30;
    s_box[9] = 8'h01;
    s_box[10] = 8'h67;
    s_box[11] = 8'h2b;
    s_box[12] = 8'hfe;
    s_box[13] = 8'hd7;
    s_box[14] = 8'hab;
    s_box[15] = 8'h76;
    s_box[16] = 8'hca;
    s_box[17] = 8'h82;
    s_box[18] = 8'hc9;
    s_box[19] = 8'h7d;
    s_box[20] = 8'hfa;
    s_box[21] = 8'h59;
    s_box[22] = 8'h47;
    s_box[23] = 8'hf0;
    s_box[24] = 8'had;
    s_box[25] = 8'hd4;
    s_box[26] = 8'ha2;
    s_box[27] = 8'haf;
    s_box[28] = 8'h9c;
    s_box[29] = 8'ha4;
    s_box[30] = 8'h72;
    s_box[31] = 8'hc0;
    s_box[32] = 8'hb7;
    s_box[33] = 8'hfd;
    s_box[34] = 8'h93;
    s_box[35] = 8'h26;
    s_box[36] = 8'h36;
    s_box[37] = 8'h3f;
    s_box[38] = 8'hf7;
    s_box[39] = 8'hcc;
    s_box[40] = 8'h34;
    s_box[41] = 8'ha5;
    s_box[42] = 8'he5;
    s_box[43] = 8'hf1;
    s_box[44] = 8'h71;
    s_box[45] = 8'hd8;
    s_box[46] = 8'h31;
    s_box[47] = 8'h15;
    s_box[48] = 8'h04;
    s_box[49] = 8'hc7;
    s_box[50] = 8'h23;
    s_box[51] = 8'hc3;
    s_box[52] = 8'h18;
    s_box[53] = 8'h96;
    s_box[54] = 8'h05;
    s_box[55] = 8'h9a;
    s_box[56] = 8'h07;
    s_box[57] = 8'h12;
    s_box[58] = 8'h80;
    s_box[59] = 8'he2;
    s_box[60] = 8'heb;
    s_box[61] = 8'h27;
    s_box[62] = 8'hb2;
    s_box[63] = 8'h75;
    s_box[64] = 8'h09;
    s_box[65] = 8'h83;
    s_box[66] = 8'h2c;
    s_box[67] = 8'h1a;
    s_box[68] = 8'h1b;
    s_box[69] = 8'h6e;
    s_box[70] = 8'h5a;
    s_box[71] = 8'ha0;
    s_box[72] = 8'h52;
    s_box[73] = 8'h3b;
    s_box[74] = 8'hd6;
    s_box[75] = 8'hb3;
    s_box[76] = 8'h29;
    s_box[77] = 8'he3;
    s_box[78] = 8'h2f;
    s_box[79] = 8'h84;
    s_box[80] = 8'h53;
    s_box[81] = 8'hd1;
    s_box[82] = 8'h00;
    s_box[83] = 8'hed;
    s_box[84] = 8'h20;
    s_box[85] = 8'hfc;
    s_box[86] = 8'hb1;
    s_box[87] = 8'h5b;
    s_box[88] = 8'h6a;
    s_box[89] = 8'hcb;
    s_box[90] = 8'hbe;
    s_box[91] = 8'h39;
    s_box[92] = 8'h4a;
    s_box[93] = 8'h4c;
    s_box[94] = 8'h58;
    s_box[95] = 8'hcf;
    s_box[96] = 8'hd0;
    s_box[97] = 8'hef;
    s_box[98] = 8'haa;
    s_box[99] = 8'hfb;
    s_box[100] = 8'h43;
    s_box[101] = 8'h4d;
    s_box[102] = 8'h33;
    s_box[103] = 8'h85;
    s_box[104] = 8'h45;
    s_box[105] = 8'hf9;
    s_box[106] = 8'h02;
    s_box[107] = 8'h7f;
    s_box[108] = 8'h50;
    s_box[109] = 8'h3c;
    s_box[110] = 8'h9f;
    s_box[111] = 8'ha8;
    s_box[112] = 8'h51;
    s_box[113] = 8'ha3;
    s_box[114] = 8'h40;
    s_box[115] = 8'h8f;
    s_box[116] = 8'h92;
    s_box[117] = 8'h9d;
    s_box[118] = 8'h38;
    s_box[119] = 8'hf5;
    s_box[120] = 8'hbc;
    s_box[121] = 8'hb6;
    s_box[122] = 8'hda;
    s_box[123] = 8'h21;
    s_box[124] = 8'h10;
    s_box[125] = 8'hff;
    s_box[126] = 8'hf3;
    s_box[127] = 8'hd2;
    s_box[128] = 8'hcd;
    s_box[129] = 8'h0c;
    s_box[130] = 8'h13;
    s_box[131] = 8'hec;
    s_box[132] = 8'h5f;
    s_box[133] = 8'h97;
    s_box[134] = 8'h44;
    s_box[135] = 8'h17;
    s_box[136] = 8'hc4;
    s_box[137] = 8'ha7;
    s_box[138] = 8'h7e;
    s_box[139] = 8'h3d;
    s_box[140] = 8'h64;
    s_box[141] = 8'h5d;
    s_box[142] = 8'h19;
    s_box[143] = 8'h73; 
    s_box[144] = 8'h60;
    s_box[145] = 8'h81;
    s_box[146] = 8'h4f;
    s_box[147] = 8'hdc;
    s_box[148] = 8'h22;
    s_box[149] = 8'h2a;
    s_box[150] = 8'h90;
    s_box[151] = 8'h88;
    s_box[152] = 8'h46;
    s_box[153] = 8'hee;
    s_box[154] = 8'hb8;
    s_box[155] = 8'h14;
    s_box[156] = 8'hde;
    s_box[157] = 8'h5e;
    s_box[158] = 8'h0b;
    s_box[159] = 8'hdb; 
    s_box[160] = 8'he0;
    s_box[161] = 8'h32;
    s_box[162] = 8'h3a;
    s_box[163] = 8'h0a;
    s_box[164] = 8'h49;
    s_box[165] = 8'h06;
    s_box[166] = 8'h24;
    s_box[167] = 8'h5c;
    s_box[168] = 8'hc2;
    s_box[169] = 8'hd3;
    s_box[170] = 8'hac;
    s_box[171] = 8'h62;
    s_box[172] = 8'h91;
    s_box[173] = 8'h95;
    s_box[174] = 8'he4;
    s_box[175] = 8'h79; 
    s_box[176] = 8'he7;
    s_box[177] = 8'hc8;
    s_box[178] = 8'h37;
    s_box[179] = 8'h6d;
    s_box[180] = 8'h8d;
    s_box[181] = 8'hd5;
    s_box[182] = 8'h4e;
    s_box[183] = 8'ha9;
    s_box[184] = 8'h6c;
    s_box[185] = 8'h56;
    s_box[186] = 8'hf4;
    s_box[187] = 8'hea;
    s_box[188] = 8'h65;
    s_box[189] = 8'h7a;
    s_box[190] = 8'hae;
    s_box[191] = 8'h08; 
    s_box[192] = 8'hba;
    s_box[193] = 8'h78;
    s_box[194] = 8'h25;
    s_box[195] = 8'h2e;
    s_box[196] = 8'h1c;
    s_box[197] = 8'ha6;
    s_box[198] = 8'hb4;
    s_box[199] = 8'hc6;
    s_box[200] = 8'he8;
    s_box[201] = 8'hdd;
    s_box[202] = 8'h74;
    s_box[203] = 8'h1f;
    s_box[204] = 8'h4b;
    s_box[205] = 8'hbd;
    s_box[206] = 8'h8b;
    s_box[207] = 8'h8a; 
    s_box[208] = 8'h70;
    s_box[209] = 8'h3e;
    s_box[210] = 8'hb5;
    s_box[211] = 8'h66;
    s_box[212] = 8'h48;
    s_box[213] = 8'h03;
    s_box[214] = 8'hf6;
    s_box[215] = 8'h0e;
    s_box[216] = 8'h61;
    s_box[217] = 8'h35;
    s_box[218] = 8'h57;
    s_box[219] = 8'hb9;
    s_box[220] = 8'h86;
    s_box[221] = 8'hc1;
    s_box[222] = 8'h1d;
    s_box[223] = 8'h9e; 
    s_box[224] = 8'he1;
    s_box[225] = 8'hf8;
    s_box[226] = 8'h98;
    s_box[227] = 8'h11;
    s_box[228] = 8'h69;
    s_box[229] = 8'hd9;
    s_box[230] = 8'h8e;
    s_box[231] = 8'h94;
    s_box[232] = 8'h9b;
    s_box[233] = 8'h1e;
    s_box[234] = 8'h87;
    s_box[235] = 8'he9;
    s_box[236] = 8'hce;
    s_box[237] = 8'h55;
    s_box[238] = 8'h28;
    s_box[239] = 8'hdf; 
    s_box[240] = 8'h8c;
    s_box[241] = 8'ha1;
    s_box[242] = 8'h89;
    s_box[243] = 8'h0d;
    s_box[244] = 8'hbf;
    s_box[245] = 8'he6;
    s_box[246] = 8'h42;
    s_box[247] = 8'h68;
    s_box[248] = 8'h41;
    s_box[249] = 8'h99;
    s_box[250] = 8'h2d;
    s_box[251] = 8'h0f;
    s_box[252] = 8'hb0;
    s_box[253] = 8'h54;
    s_box[254] = 8'hbb;
    s_box[255] = 8'h16;
end

integer i;

  always @(*) begin
    for (i = 0; i < 16; i = i + 1) begin
      out[(i * 8) +: 8] = s_box[state[(i * 8) +: 8]];
    end
  end
    
endmodule

////inv////


@ -1,272 +0,0 @@
module inv_SubBytes(input[127:0] state, output reg[127:0] out);

reg[7:0] inv_s_box[0:255];

initial begin
    inv_s_box[0] = 8'h52;
    inv_s_box[1] = 8'h09;
    inv_s_box[2] = 8'h6a;
    inv_s_box[3] = 8'hd5;
    inv_s_box[4] = 8'h30;
    inv_s_box[5] = 8'h36;
    inv_s_box[6] = 8'ha5;
    inv_s_box[7] = 8'h38;
    inv_s_box[8] = 8'hbf;
    inv_s_box[9] = 8'h40;
    inv_s_box[10] = 8'ha3;
    inv_s_box[11] = 8'h9e;
    inv_s_box[12] = 8'h81;
    inv_s_box[13] = 8'hf3;
    inv_s_box[14] = 8'hd7;
    inv_s_box[15] = 8'hfb;
    inv_s_box[16] = 8'h7c;
    inv_s_box[17] = 8'he3;
    inv_s_box[18] = 8'h39;
    inv_s_box[19] = 8'h82;
    inv_s_box[20] = 8'h9b;
    inv_s_box[21] = 8'h2f;
    inv_s_box[22] = 8'hff;
    inv_s_box[23] = 8'h87;
    inv_s_box[24] = 8'h34;
    inv_s_box[25] = 8'h8e;
    inv_s_box[26] = 8'h43;
    inv_s_box[27] = 8'h44;
    inv_s_box[28] = 8'hc4;
    inv_s_box[29] = 8'hde;
    inv_s_box[30] = 8'he9;
    inv_s_box[31] = 8'hcb;
    inv_s_box[32] = 8'h54;
    inv_s_box[33] = 8'h7b;
    inv_s_box[34] = 8'h94;
    inv_s_box[35] = 8'h32;
    inv_s_box[36] = 8'ha6;
    inv_s_box[37] = 8'hc2;
    inv_s_box[38] = 8'h23;
    inv_s_box[39] = 8'h3d;
    inv_s_box[40] = 8'hee;
    inv_s_box[41] = 8'h4c;
    inv_s_box[42] = 8'h95;
    inv_s_box[43] = 8'h0b;
    inv_s_box[44] = 8'h42;
    inv_s_box[45] = 8'hfa;
    inv_s_box[46] = 8'hc3;
    inv_s_box[47] = 8'h4e;
    inv_s_box[48] = 8'h08;
    inv_s_box[49] = 8'h2e;
    inv_s_box[50] = 8'ha1;
    inv_s_box[51] = 8'h66;
    inv_s_box[52] = 8'h28;
    inv_s_box[53] = 8'hd9;
    inv_s_box[54] = 8'h24;
    inv_s_box[55] = 8'hb2;
    inv_s_box[56] = 8'h76;
    inv_s_box[57] = 8'h5b;
    inv_s_box[58] = 8'ha2;
    inv_s_box[59] = 8'h49;
    inv_s_box[60] = 8'h6d;
    inv_s_box[61] = 8'h8b;
    inv_s_box[62] = 8'hd1;
    inv_s_box[63] = 8'h25;
    inv_s_box[64] = 8'h72;
    inv_s_box[65] = 8'hf8;
    inv_s_box[66] = 8'hf6;
    inv_s_box[67] = 8'h64;
    inv_s_box[68] = 8'h86;
    inv_s_box[69] = 8'h68;
    inv_s_box[70] = 8'h98;
    inv_s_box[71] = 8'h16;
    inv_s_box[72] = 8'hd4;
    inv_s_box[73] = 8'ha4;
    inv_s_box[74] = 8'h5c;
    inv_s_box[75] = 8'hcc;
    inv_s_box[76] = 8'h5d;
    inv_s_box[77] = 8'h65;
    inv_s_box[78] = 8'hb6;
    inv_s_box[79] = 8'h92;
    inv_s_box[80] = 8'h6c;
    inv_s_box[81] = 8'h70;
    inv_s_box[82] = 8'h48;
    inv_s_box[83] = 8'h50;
    inv_s_box[84] = 8'hfd;
    inv_s_box[85] = 8'hed;
    inv_s_box[86] = 8'hb9;
    inv_s_box[87] = 8'hda;
    inv_s_box[88] = 8'h5e;
    inv_s_box[89] = 8'h15;
    inv_s_box[90] = 8'h46;
    inv_s_box[91] = 8'h57;
    inv_s_box[92] = 8'ha7;
    inv_s_box[93] = 8'h8d;
    inv_s_box[94] = 8'h9d;
    inv_s_box[95] = 8'h84;
    inv_s_box[96] = 8'h90;
    inv_s_box[97] = 8'hd8;
    inv_s_box[98] = 8'hab;
    inv_s_box[99] = 8'h00;
    inv_s_box[100] = 8'h8c;
    inv_s_box[101] = 8'hbc;
    inv_s_box[102] = 8'hd3;
    inv_s_box[103] = 8'h0a;
    inv_s_box[104] = 8'hf7;
    inv_s_box[105] = 8'he4;
    inv_s_box[106] = 8'h58;
    inv_s_box[107] = 8'h05;
    inv_s_box[108] = 8'hb8;
    inv_s_box[109] = 8'hb3;
    inv_s_box[110] = 8'h45;
    inv_s_box[111] = 8'h06;
    inv_s_box[112] = 8'hd0;
    inv_s_box[113] = 8'h2c;
    inv_s_box[114] = 8'h1e;
    inv_s_box[115] = 8'h8f;
    inv_s_box[116] = 8'hca;
    inv_s_box[117] = 8'h3f;
    inv_s_box[118] = 8'h0f;
    inv_s_box[119] = 8'h02;
    inv_s_box[120] = 8'hc1;
    inv_s_box[121] = 8'haf;
    inv_s_box[122] = 8'hbd;
    inv_s_box[123] = 8'h03;
    inv_s_box[124] = 8'h01;
    inv_s_box[125] = 8'h13;
    inv_s_box[126] = 8'h8a;
    inv_s_box[127] = 8'h6b;
    inv_s_box[128] = 8'h3a;
    inv_s_box[129] = 8'h91;
    inv_s_box[130] = 8'h11;
    inv_s_box[131] = 8'h41;
    inv_s_box[132] = 8'h4f;
    inv_s_box[133] = 8'h67;
    inv_s_box[134] = 8'hdc;
    inv_s_box[135] = 8'hea;
    inv_s_box[136] = 8'h97;
    inv_s_box[137] = 8'hf2;
    inv_s_box[138] = 8'hcf;
    inv_s_box[139] = 8'hce;
    inv_s_box[140] = 8'hf0;
    inv_s_box[141] = 8'hb4;
    inv_s_box[142] = 8'he6;
    inv_s_box[143] = 8'h73;
    inv_s_box[144] = 8'h96;
    inv_s_box[145] = 8'hac;
    inv_s_box[146] = 8'h74;
    inv_s_box[147] = 8'h22;
    inv_s_box[148] = 8'he7;
    inv_s_box[149] = 8'had;
    inv_s_box[150] = 8'h35;
    inv_s_box[151] = 8'h85;
    inv_s_box[152] = 8'he2;
    inv_s_box[153] = 8'hf9;
    inv_s_box[154] = 8'h37;
    inv_s_box[155] = 8'he8;
    inv_s_box[156] = 8'h1c;
    inv_s_box[157] = 8'h75;
    inv_s_box[158] = 8'hdf;
    inv_s_box[159] = 8'h6e;
    inv_s_box[160] = 8'h47;
    inv_s_box[161] = 8'hf1;
    inv_s_box[162] = 8'h1a;
    inv_s_box[163] = 8'h71;
    inv_s_box[164] = 8'h1d;
    inv_s_box[165] = 8'h29;
    inv_s_box[166] = 8'hc5;
    inv_s_box[167] = 8'h89;
    inv_s_box[168] = 8'h6f;
    inv_s_box[169] = 8'hb7;
    inv_s_box[170] = 8'h62;
    inv_s_box[171] = 8'h0e;
    inv_s_box[172] = 8'haa;
    inv_s_box[173] = 8'h18;
    inv_s_box[174] = 8'hbe;
    inv_s_box[175] = 8'h1b;
    inv_s_box[176] = 8'hfc;
    inv_s_box[177] = 8'h56;
    inv_s_box[178] = 8'h3e;
    inv_s_box[179] = 8'h4b;
    inv_s_box[180] = 8'hc6;
    inv_s_box[181] = 8'hd2;
    inv_s_box[182] = 8'h79;
    inv_s_box[183] = 8'h20;
    inv_s_box[184] = 8'h9a;
    inv_s_box[185] = 8'hdb;
    inv_s_box[186] = 8'hc0;
    inv_s_box[187] = 8'hfe;
    inv_s_box[188] = 8'h78;
    inv_s_box[189] = 8'hcd;
    inv_s_box[190] = 8'h5a;
    inv_s_box[191] = 8'hf4;
    inv_s_box[192] = 8'h1f;
    inv_s_box[193] = 8'hdd;
    inv_s_box[194] = 8'ha8;
    inv_s_box[195] = 8'h33;
    inv_s_box[196] = 8'h88;
    inv_s_box[197] = 8'h07;
    inv_s_box[198] = 8'hc7;
    inv_s_box[199] = 8'h31;
    inv_s_box[200] = 8'hb1;
    inv_s_box[201] = 8'h12;
    inv_s_box[202] = 8'h10;
    inv_s_box[203] = 8'h59;
    inv_s_box[204] = 8'h27;
    inv_s_box[205] = 8'h80;
    inv_s_box[206] = 8'hec;
    inv_s_box[207] = 8'h5f;
    inv_s_box[208] = 8'h60;
    inv_s_box[209] = 8'h51;
    inv_s_box[210] = 8'h7f;
    inv_s_box[211] = 8'ha9;
    inv_s_box[212] = 8'h19;
    inv_s_box[213] = 8'hb5;
    inv_s_box[214] = 8'h4a;
    inv_s_box[215] = 8'h0d;
    inv_s_box[216] = 8'h2d;
    inv_s_box[217] = 8'he5;
    inv_s_box[218] = 8'h7a;
    inv_s_box[219] = 8'h9f;
    inv_s_box[220] = 8'h93;
    inv_s_box[221] = 8'hc9;
    inv_s_box[222] = 8'h9c;
    inv_s_box[223] = 8'hef;
    inv_s_box[224] = 8'ha0;
    inv_s_box[225] = 8'he0;
    inv_s_box[226] = 8'h3b;
    inv_s_box[227] = 8'h4d;
    inv_s_box[228] = 8'hae;
    inv_s_box[229] = 8'h2a;
    inv_s_box[230] = 8'hf5;
    inv_s_box[231] = 8'hb0;
    inv_s_box[232] = 8'hc8;
    inv_s_box[233] = 8'heb;
    inv_s_box[234] = 8'hbb;
    inv_s_box[235] = 8'h3c;
    inv_s_box[236] = 8'h83;
    inv_s_box[237] = 8'h53;
    inv_s_box[238] = 8'h99;
    inv_s_box[239] = 8'h61;
    inv_s_box[240] = 8'h17;
    inv_s_box[241] = 8'h2b;
    inv_s_box[242] = 8'h04;
    inv_s_box[243] = 8'h7e;
    inv_s_box[244] = 8'hba;
    inv_s_box[245] = 8'h77;
    inv_s_box[246] = 8'hd6;
    inv_s_box[247] = 8'h26;
    inv_s_box[248] = 8'he1;
    inv_s_box[249] = 8'h69;
    inv_s_box[250] = 8'h14;
    inv_s_box[251] = 8'h63;
    inv_s_box[252] = 8'h55;
    inv_s_box[253] = 8'h21;
    inv_s_box[254] = 8'h0c;
    inv_s_box[255] = 8'h7d;
end

integer i;

  always @(*) begin
    for (i = 0; i < 16; i = i + 1) begin
      out[(i * 8) +: 8] = inv_s_box[state[(i * 8) +: 8]];
    end
  end
    
endmodule


////////////////////////////////////ShiftRows&Inv ShiftRows////////////////////////////////////


module ShiftRows(input [127:0] state, output[127:0] nstate);
    assign nstate[127:120] = state[127:120];         // [0] = [0]
    assign nstate[119:112] = state[87:80];           // [1] = [5]
    assign nstate[111:104] = state[47:40];           // [2] = [10]
    assign nstate[103:96]  = state[7:0];             // [3] = [15]
    assign nstate[95:88]   = state[95:88];           // [4] = [4]
    assign nstate[87:80]   = state[55:48];           // [5] = [9]
    assign nstate[79:72]   = state[15:8];            // [6] = [14]
    assign nstate[71:64]   = state[103:96];          // [7] = [3]
    assign nstate[63:56]   = state[63:56];           // [8] = [8]
    assign nstate[55:48]   = state[23:16];           // [9] = [13]
    assign nstate[47:40]   = state[111:104];         // [10] = [2]
    assign nstate[39:32]   = state[71:64];           // [11] = [7]
    assign nstate[31:24]   = state[31:24];           // [12] = [12]
    assign nstate[23:16]   = state[119:112];         // [13] = [1]
    assign nstate[15:8]    = state[79:72];           // [14] = [6]
    assign nstate[7:0]     = state[39:32];           // [15] = [11]
endmodule



////Inv////


module invShiftRows(input [127:0] state, output[127:0] nstate);
    assign nstate[127:120] = state[127:120];        // [0] = [0]
    assign nstate[119:112] = state[23:16];          // [1] = [13]
    assign nstate[111:104] = state[47:40];          // [2] = [10]
    assign nstate[103:96]  = state[71:64];          // [3] = [7]
    assign nstate[95:88]   = state[95:88];          // [4] = [4]
    assign nstate[87:80]   = state[119:112];        // [5] = [1]
    assign nstate[79:72]   = state[15:8];           // [6] = [14]
    assign nstate[71:64]   = state[39:32];          // [7] = [11]
    assign nstate[63:56]   = state[63:56];          // [8] = [8]
    assign nstate[55:48]   = state[87:80];          // [9] = [5]
    assign nstate[47:40]   = state[111:104];        // [10] = [2]
    assign nstate[39:32]   = state[7:0];            // [11] = [15]
    assign nstate[31:24]   = state[31:24];          // [12] = [12]
    assign nstate[23:16]   = state[55:48];          // [13] = [9]
    assign nstate[15:8]    = state[79:72];          // [14] = [6]
    assign nstate[7:0]     = state[103:96];         // [15] = [3]
endmodule

////////////////////////////////////////Cypher//////////////////////////////////////////






