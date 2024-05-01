module Decrypt128(input [0:127] Message,input [0:127] Key, input clk, output [0:127] decipher);

wire [0:1407] KeySchedule;
KeyExpansion128 keyExp( Key , KeySchedule );

reg [0:3] i = 4'b0000;

reg [0:127] stateReg;
wire [0:127] out0;
AddRoundKey initialRound(Message,KeySchedule[1408-128 +:128],out0);

wire [0:127] out1;
wire [0:127] out2;
wire [0:127] out3;
wire [0:127] out4;
wire [0:127] out1Final;
wire [0:127] out2Final;
wire [0:127] out3Final;

inv_SubBytes subbytes(stateReg,out1);
invShiftRows shiftrows(out1,out2);
AddRoundKey addround(out2,KeySchedule[1280-128*i +:128],out3);
inverseMixColumns mixcol(out3,out4);

always @(posedge clk) 
begin
    if(i<1)begin
    i<=i+4'b0001;
    stateReg<=out0;
    end
    else if(i<10)begin
    i<=i+4'b0001;
    stateReg<=out4;
    end
    else if (i == 10)begin
    i<=i+4'b0001;
    stateReg<=out3Final;
    end
end

inv_SubBytes subbytess(stateReg,out1Final);
invShiftRows shift(out1Final,out2Final);
AddRoundKey lastround(out2Final,KeySchedule[0:127],out3Final);


assign decipher=stateReg;





endmodule





//  AddRoundKey initialRounddddddd ( State , KeySchedule [0:127] , State );
// genvar i;
// generate
// for( i=1 ; i<10 ; i=i+1) begin : Nine_Rounds  //last round separately because no mix columns 
//     SubBytes subbytes(State,State);
//     ShiftRows shiftrows(State,State);
//     mixcolumns mixcol(State,State);
//     AddRoundKey addround( State , KeySchedule [i*128 +: 128 ] );
// end
// endgenerate
// //last Round
// SubBytes subbytesssss(State);
// ShiftRows shiftttt(State);
// AddRoundKey lastroundddd(State,KeySchedule[1280 : 1407]);

// assign cipher=State; 
// endmodule


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

    $monitor("Key Schedule %h", encrypt_inst.KeySchedule);
end
endmodule
