module decryptRound(input [0:127] state, input [0:127] key, output [0:127] nstate);

wire[0:127] afterInvSubBytes, afterInvShiftRows, afterRoundKey;

invSubBytes invsubbytes(state, afterInvSubBytes);
invShiftRows invshiftrows(afterInvSubBytes, afterInvShiftRows);
addRoundKey invaddround(afterInvShiftRows, key, afterRoundKey);
invMixColumns invmixcol(afterRoundKey, nstate);

endmodule
