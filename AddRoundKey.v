module AddRoundKey(input[127:0] state, input[127:0]Key, output [127:0]nstate);

assign nstate = state ^ Key;

endmodule