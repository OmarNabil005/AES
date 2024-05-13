module AES (input clk, input reset, input [1:0] SW, output [6:0] HEX5, output [6:0] HEX4, output [6:0] HEX3, output [6:0] HEX2, output [6:0] HEX1, output [6:0] HEX0, output reg led);

wire [127:0] Message =128'h00112233445566778899aabbccddeeff;                                    // Fixed message
wire [0:127] Key128 = 128'h000102030405060708090a0b0c0d0e0f;                                    // Fixed keys  
wire [0:191] Key192 = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
wire [0:255] Key256 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f; 

wire [0:1407] KeySchedule128;
wire [0:1663] KeySchedule192;
wire [0:1919] KeySchedule256;
wire [0:127] afterEncrypt128, afterDecrypt128,
             afterEncrypt192, afterDecrypt192,
             afterEncrypt256, afterDecrypt256;

reg [0:127] outReg = 128'h0;
reg [0:4] i = 5'b00000;

keyExpansion #(4, 10) keyExp128(Key128, KeySchedule128);
keyExpansion #(6, 12) keyExp192(Key192, KeySchedule192);
keyExpansion #(8, 14) keyExp256(Key256, KeySchedule256);

encrypt #(4, 10) enc128(clk, reset, Message, KeySchedule128, afterEncrypt128);
decrypt #(4, 10) dec128(clk, reset, afterEncrypt128, KeySchedule128, afterDecrypt128);
encrypt #(6, 12) enc192(clk, reset, Message, KeySchedule192, afterEncrypt192);
decrypt #(6, 12) dec192(clk, reset, afterEncrypt192, KeySchedule192, afterDecrypt192);
encrypt #(8, 14) enc256(clk, reset, Message, KeySchedule256, afterEncrypt256);
decrypt #(8, 14) dec256(clk, reset, afterEncrypt256, KeySchedule256, afterDecrypt256);

binaryToSevenSegment BCDconvert(outReg[120 +: 8], HEX2, HEX1, HEX0);

assign HEX5 = 7'b0001000;               // show "AES" on display
assign HEX4 = 7'b0000110;
assign HEX3 = 7'b0010010;

always @(posedge clk)
begin
    if (reset)begin
        i <= 0;
        outReg = 0;
    end
    else if (SW == 2'b00)begin          // 00 -> out = 0 (unused case)
        if (i <= 30)begin
        outReg = 0;
        i <= i + 1;
        end
        else 
            outReg = 0;
    end
    else if (i < 1)begin
        outReg = Message;
        i <= i + 1;
    end
    else if (SW == 2'b01)begin          // 01 -> 128 bits mode
        if (i <= 11)begin
            outReg = afterEncrypt128;
            i <= i + 1;
        end
        else if (i <= 22)begin
            outReg = afterDecrypt128;
            i <= i + 1;
        end
        else
            outReg = afterDecrypt128;
    end
    else if (SW == 2'b10)begin          // 02 -> 192 bits mode
        if (i <= 13)begin
            outReg = afterEncrypt192;
            i <= i + 1;
        end
        else if (i <= 26)begin
            outReg = afterDecrypt192;
            i <= i + 1;
        end
        else
            outReg = afterDecrypt192;
    end
    else if (SW == 2'b11)begin          // 03 -> 256 bits mode
        if(i <= 15)begin
            outReg = afterEncrypt256;
            i <= i + 1;
        end
        else if (i <= 30)begin
            outReg = afterDecrypt256;
            i <= i + 1;
        end
        else 
            outReg = afterDecrypt256;
    end
    if (i >= 20 && outReg == Message)   // turn led on when finished
        led = 1'b1;
    else
        led = 1'b0;
end

endmodule


module testbench1();        // set switches and reset manually when testbenching

// Signals
wire [6:0] HEx2;
wire [6:0] HEx1;
wire [6:0] HEx0;
reg clk;
reg SWa = 0;
reg SWb = 0;

///



//Instantiate the module under test
AES encrypt_inst (
    .clk(clk),
    // .SW[1](SWa),
    // .SW[0](SWb),
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
end

endmodule