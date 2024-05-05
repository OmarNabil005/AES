module decryptRound(input [0:127] message, input [0:127] key, output [0:127] decrypted);

wire[0:127] afterInvSubBytes, afterInvShiftRows, afterRoundKey;

invSubBytes invsubbytes(message, afterInvSubBytes);
invShiftRows invshiftrows(afterInvSubBytes, afterInvShiftRows);
addRoundKey invaddround(afterInvShiftRows, key, afterRoundKey);
invMixColumns invmixcol(afterRoundKey, decrypted);

endmodule