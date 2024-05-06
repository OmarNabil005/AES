module invSubBytes(input[127:0] state, output [127:0] nstate);

genvar i;
generate
    for (i = 0; i < 16; i = i + 1)begin: invSBloop
       invSBox sb(state[(i * 8) +: 8], nstate[(i * 8) +: 8]);
    end
endgenerate

endmodule