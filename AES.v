module AES #(parameter nk=4, parameter nr=10)(input clk, input [0:127] Message,
                                              input [0:(32 * nk) - 1] Key, output [6:0] HEX2,
                                              output [6:0] HEX1, output [6:0] HEX0);

wire [0: 128 * (nr + 1) -1] KeySchedule;
wire [0:127] afterEncrypt, outwire;

keyExpansion #(nk, nr) keyExp(Key, KeySchedule);
encrypt #(nk, nr) enc(clk, Message, KeySchedule, afterEncrypt);
decrypt #(nk, nr) dec(clk, afterEncrypt, KeySchedule, outwire);
binaryToSevenSegment hexa(outwire[120 +: 8], HEX2, HEX1, HEX0);

endmodule


module testbench1();

// Parameters
wire [127:0] message =128'h00112233445566778899aabbccddeeff; // Fixed message
wire [255:0] key = 256'h603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4; // Fixed key
// Signals
wire [6:0] HEx2;
wire [6:0] HEx1;
wire [6:0] HEx0;
reg clk;

///



// Instantiate the module under test
AES #(8, 14) encrypt_inst (
    .clk(clk),
    .Message(message),
    .Key(key),
    .HEX2(HEx2),
    .HEX1(HEx1),
    .HEX0(HEx0)
);

// Test stimulus
initial begin
    clk = 0;

    // Display inputs
    $monitor("Input Message: %h", message);
    $monitor("Input Key: %h", key);

    forever #5 clk = ~clk;

    // Display output

    $monitor("Key Schedule %h", encrypt_inst.KeySchedule);
end

endmodule