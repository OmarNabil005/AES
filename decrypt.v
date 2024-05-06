module decrypt#(parameter nk=4, parameter nr=10)(input clk, input [0:127] Message, input [0: 128 * (nr + 1) -1] keySchedule, output [0:127] decipher);

reg [0:4] i = 5'b00000;
reg [0:127] stateReg;
wire [0:127] firstDecrypt, afterDecrypt, lastDecrypt;

initial
    stateReg = 0;
assign decipher=stateReg;

addRoundKey inv_initial (Message,keySchedule[(128 * nr) +:128], firstDecrypt);
decryptRound decR(stateReg, keySchedule[(128 * (2 * nr - i + 2)) +:128], afterDecrypt);
decryptLastRound decLR(stateReg, keySchedule[0:127], lastDecrypt);

always @(negedge clk) 
begin
    if(i <= nr + 1)begin
    i <= i + 1;
    stateReg<=Message;
    end
    else if(i==(nr + 2))begin
    i <= i + 1;
    stateReg<=firstDecrypt;
    end
    else if(i<=(2 * nr + 1))begin
    i <= i + 1;
    stateReg<=afterDecrypt;
    end
    else if (i == (2 * nr + 2))begin
    i <= i + 1;
    stateReg<=lastDecrypt;
    end
end

endmodule


module testbenchh();

// Parameters
wire [127:0] message =128'h69c4e0d86a7b0430d8cdb78070b4c55a; // Fixed message
wire [127:0] key = 128'h000102030405060708090a0b0c0d0e0f; // Fixed key

// Signals
wire [127:0] decipher;
reg clk;

// Instantiate the module under test
Decrypt128 encrypt_inst (
    .Message(message),
    .Key(key),
    .clk(clk),
    .decipher(decipher)
);

// Test stimulus
initial begin
    clk = 0;

    // Display inputs
    $monitor("Input Message: %h", message);
    $monitor("Input Key: %h", key);

    forever #5 clk = ~clk;

    // Display output
    $monitor("Encrypted Cipher: %h", decipher);

    $monitor("Key Schedule %h", encrypt_inst.keySchedule);
end
endmodule
