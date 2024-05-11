module encrypt#(parameter nk=4, parameter nr=10)(input clk, input reset, input [0:127] Message, input [0: 128 * (nr + 1) -1] keySchedule, output [0:127] cipher);

reg [0:3] i = 4'b0000;
reg [0:127] stateReg;
wire [0:127] firstEncrypt, afterEncrypt, lastEncrypt;

initial
    stateReg = 0;
assign cipher = stateReg;

reg prev = 0;
reg res = 0;

addRoundKey encInitial(Message, keySchedule[0:127], firstEncrypt);
encryptRound encR(stateReg, keySchedule[128*i +: 128], afterEncrypt);
encryptLastRound encLR(stateReg, keySchedule[(128 * nr) +: 128], lastEncrypt);

always @(posedge reset)
    res = ~res;

always @(posedge clk or posedge reset) 
begin
    if (prev != res)
    begin
    i <= 0;
	prev <= res;
    end
    else if(i<1)begin
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
end

endmodule


module testbench();

// Parameters
wire [127:0] message =128'h54776F204F6E65204E696E652054776F; // Fixed message
wire [127:0] key = 128'h5468617473206D79204B756E67204675; // Fixed key

// Signals
wire [127:0] cipher;
reg clk;

// Instantiate the module under test
Encrypt encrypt_inst (
    .Message(message),
    .Key(key),
    .clk(clk),
    .cipher(cipher)
);

// Test stimulus
initial begin
    clk = 0;

    // Display inputs
    $monitor("Input Message: %h", message);
    $monitor("Input Key: %h", key);

    forever #5 clk = ~clk;

    // Display output
    $monitor("Encrypted Cipher: %h", cipher);

    $monitor("Key Schedule %h", encrypt_inst.keySchedule);
end

endmodule

