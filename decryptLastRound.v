module decryptLastRound(input [0:127] message, input [0:127] key, output [0:127] decrypted);

wire[0:127] afterInvSubBytes, afterInvShiftRows;

invSubBytes invsubB(message, afterInvSubBytes);
invShiftRows invshiftR(afterInvSubBytes, afterInvShiftRows);
addRoundKey invaddR(afterInvShiftRows, key, decrypted);

endmodule