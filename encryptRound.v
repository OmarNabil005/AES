module encryptRound(input [0:127] message, input [0:127] key, output [0:127] encrpted);

wire[0:127] afterSubBytes, afterShiftRows, afterMixColumns;

subBytes subbytes(message, afterSubBytes);
shiftRows shiftrows(afterSubBytes, afterShiftRows);
mixColumns mixcol(afterShiftRows, afterMixColumns);
addRoundKey addround(afterMixColumns, key, encrpted);

endmodule