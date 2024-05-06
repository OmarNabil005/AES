module encryptLastRound(input [0:127] state, input [0:127] key, output [0:127] nstate);

wire[0:127] afterSubBytes, afterShiftRows;

subBytes subB(state, afterSubBytes);
shiftRows shiftR(afterSubBytes, afterShiftRows);
addRoundKey addR(afterShiftRows, key, nstate);

endmodule