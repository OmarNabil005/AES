module encryptLastRound(input [0:127] message, input [0:127] key, output [0:127] encrpted);

wire[0:127] afterSubBytes, afterShiftRows;

subBytes subB(message, afterSubBytes);
shiftRows shiftR(afterSubBytes, afterShiftRows);
addRoundKey addR(afterShiftRows, key, encrpted);

endmodule