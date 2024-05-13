module decryptLastRound(input [0:127] state, input [0:127] key, output [0:127] nstate);

wire[0:127] afterInvSubBytes, afterInvShiftRows;

invSubBytes invsubB(state, afterInvSubBytes);
invShiftRows invshiftR(afterInvSubBytes, afterInvShiftRows);
addRoundKey invaddR(afterInvShiftRows, key, nstate);

endmodule
