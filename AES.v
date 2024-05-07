module AES #(parameter nk=8, parameter nr=14)(input clk, output [6:0] HEX2,
                                              output [6:0] HEX1, output [6:0] HEX0);

wire [127:0] Message =128'h00112233445566778899aabbccddeeff; // Fixed message
wire [0:255] Key = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f; // Fixed key
wire [0: 128 * (nr + 1) -1] KeySchedule;
wire [0:127] afterEncrypt, outwire;

reg [0:4] i = 5'b00000;
reg [0:127] outReg;

keyExpansion #(nk, nr) keyExp(Key, KeySchedule);
encrypt #(nk, nr) enc(clk, Message, KeySchedule, afterEncrypt);
decrypt #(nk, nr) dec(clk, afterEncrypt, KeySchedule, outwire);
binaryToSevenSegment BCDconvert(outReg, HEX2, HEX1, HEX0);

always @(posedge clk)
begin
    if (i < 1)begin
        outReg <= Message;
        i <= i + 1;
    end
    else if (i <= nr + 1)begin
        outReg <= afterEncrypt;
        i <= i + 1;
    end
    else if (i <= (2 * nr + 2))begin
        outReg <= outwire;
        i <= i + 1;
    end
end

endmodule


module testbench1();

// Signals
wire [6:0] HEx2;
wire [6:0] HEx1;
wire [6:0] HEx0;
reg clk;

///



// Instantiate the module under test
AES #(8, 14) encrypt_inst (
    .clk(clk),
    .HEX2(HEx2),
    .HEX1(HEx1),
    .HEX0(HEx0)
);

// Test stimulus
initial begin
    clk = 0;

    // Display inputs
    forever #5 clk = ~clk;

    // Display output

    $monitor("Key Schedule %h", encrypt_inst.KeySchedule);
end

endmodule