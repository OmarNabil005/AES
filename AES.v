module AES #(parameter nk=4, parameter nr=10)(input clk, input [0:127] Message,
                                              input [0:(32 * nk) - 1] Key, output [6:0] HEX2,
                                              output [6:0] HEX1, output [6:0] HEX0);

reg [0:127] stateReg;
wire [0: 128 * (nr + 1) -1] KeySchedule;
reg [0:4] i = 5'b00000;
wire [0:127] firstEncrypt, afterEncrypt, lastEncrypt, firstDecrypt, afterDecrypt, lastDecrypt;

initial
    stateReg = 0;

binaryToSevenSegment hexa(stateReg[120 +: 8], HEX2, HEX1, HEX0);

keyExpansion #(nk, nr) keyExp(Key, KeySchedule);

addRoundKey initialRound(Message, KeySchedule[0:127], firstEncrypt);
encryptRound er(stateReg, KeySchedule[128*i +: 128], afterEncrypt);
encryptLastRound elr(stateReg, KeySchedule[(128 * nr) +: 128], lastEncrypt);

always @(posedge clk) 
begin
    if(i<1)begin
    i <= i + 1;
    stateReg<=firstEncrypt;
    end
    else if(i<nr)begin
    i <= i + 1;
    stateReg<=afterEncrypt;
    end
    else if (i == nr)begin
    i <= i + 1;
    stateReg<=lastEncrypt;
    end
    
    // Inv Cipher !!!
    else if(i==(nr + 1))begin
        i <= i + 1;
        stateReg<=firstDecrypt;
    end
    else if(i<=(2 * nr))begin
    i <= i + 1;
    stateReg<=afterDecrypt;
    end
    else if (i == (2 * nr + 1))begin
    i <= i + 1;
    stateReg<=lastDecrypt;
    end
end

// Inverse cipher !!!
addRoundKey inv_initialll (stateReg,KeySchedule[(128 * nr) +:128], firstDecrypt);
decryptRound decR(stateReg, KeySchedule[(128 * (2 * nr - i + 1)) +:128], afterDecrypt);
decryptLastRound decLR(stateReg, KeySchedule[0:127], lastDecrypt);

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