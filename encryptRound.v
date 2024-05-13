module encryptRound(input [0:127] state, input [0:127] key, output [0:127] nstate);

wire[0:127] afterSubBytes, afterShiftRows, afterMixColumns;

subBytes subbytes(state, afterSubBytes);
shiftRows shiftrows(afterSubBytes, afterShiftRows);
mixColumns mixcol(afterShiftRows, afterMixColumns);
addRoundKey addround(afterMixColumns, key, nstate);

endmodule