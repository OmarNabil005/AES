module inv_SubBytes(input[127:0] state, output [127:0] out);

genvar i;
generate
    for (i = 0; i < 16; i = i + 1)begin: invSBloop
       inv_sBox sb(state[(i * 8) +: 8], out[(i * 8) +: 8]);
    end
endgenerate

endmodule