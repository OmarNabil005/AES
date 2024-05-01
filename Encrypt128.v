module Encrypt(input [0:127] Message,input [0:127] Key, input clk, output [0:127] cipher);

wire [0:1407] KeySchedule;
KeyExpansion128 keyExp( Key , KeySchedule );

reg [0:3] i = 4'b0001;

reg [0:127] stateReg;
wire [0:127] out0;
AddRoundKey initialRound(Message,KeySchedule[0:127],out0);

initial @(out0)
    stateReg=out0;

wire [0:127] out1;
wire [0:127] out2;
wire [0:127] out3;
wire [0:127] out4;
wire [0:127] out1Final;
wire [0:127] out2Final;
wire [0:127] out3Final;

SubBytes subbytes(stateReg,out1);
ShiftRows shiftrows(out1,out2);
mixcolumns mixcol(out2,out3);
AddRoundKey addround(out3,KeySchedule[128*i +: 128],out4);

always @(posedge clk) 
begin
    if(i<10)begin
    i<=i+4'b0001;
    stateReg<=out4;
    end
end

SubBytes subbytess(stateReg,out1Final);
ShiftRows shift(out1Final,out2Final);
AddRoundKey lastround(out2Final,KeySchedule[1280 : 1407],out3Final);


assign cipher=out3Final;











/* AddRoundKey initialRound ( State , KeySchedule [0:127] , State );
genvar i;
generate
for( i=1 ; i<10 ; i=i+1) begin : Nine_Rounds  //last round separately because no mix columns 
    SubBytes subbytes(State,State);
    ShiftRows shiftrows(State,State);
    mixcolumns mixcol(State,State);
    AddRoundKey addround( State , KeySchedule [i*128 +: 128 ] );
end
endgenerate
//last Round
SubBytes subbytess(State);
ShiftRows shift(State);
AddRoundKey lastround(State,KeySchedule[1280 : 1407]);

assign cipher=State; */
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

    $monitor("Key Schedule %h", encrypt_inst.KeySchedule);
end

endmodule

