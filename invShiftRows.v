module invShiftRows(input [127:0] state, output[127:0] nstate);
    assign nstate[127:120] = state[127:120];        // [0] = [0]
    assign nstate[119:112] = state[23:16];          // [1] = [13]
    assign nstate[111:104] = state[47:40];          // [2] = [10]
    assign nstate[103:96]  = state[71:64];          // [3] = [7]
    assign nstate[95:88]   = state[95:88];          // [4] = [4]
    assign nstate[87:80]   = state[119:112];        // [5] = [1]
    assign nstate[79:72]   = state[15:8];           // [6] = [14]
    assign nstate[71:64]   = state[39:32];          // [7] = [11]
    assign nstate[63:56]   = state[63:56];          // [8] = [8]
    assign nstate[55:48]   = state[87:80];          // [9] = [5]
    assign nstate[47:40]   = state[111:104];        // [10] = [2]
    assign nstate[39:32]   = state[7:0];            // [11] = [15]
    assign nstate[31:24]   = state[31:24];          // [12] = [12]
    assign nstate[23:16]   = state[55:48];          // [13] = [9]
    assign nstate[15:8]    = state[79:72];          // [14] = [6]
    assign nstate[7:0]     = state[103:96];         // [15] = [3]
endmodule