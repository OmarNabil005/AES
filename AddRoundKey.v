module addRoundKey(input[127:0] state, input[127:0] key, output [127:0]nstate);

    assign nstate = state ^ key;

endmodule