module AES #(parameter nk=4, parameter nr=10)(input [0:127] Message, input [0:127] Key, input clk, output [6:0] HEX2, output [6:0] HEX1, output [6:0] HEX0);

//wire [7:0] o2, o1, o;

reg [0:127] stateReg;
wire [0: 128 * (nr + 1) -1] KeySchedule;

initial begin
    stateReg = 128'h0;
end    
KeyExpansion128 keyExp(Key, KeySchedule);

reg [0:4] i = 5'b00000;

wire [0:127] out0;
AddRoundKey initialRound(Message,KeySchedule[0:127],out0);

Binary_to_7seg hexa(stateReg[120:127], HEX2, HEX1, HEX0);

wire [0:127] out1, out2, out3, out4, out5,
             out6, out7, out8, out1Final,
             out2Final, out3Final, out4Final,
             out5Final, out6Final, try;

SubBytes subbytes(stateReg,out1);
ShiftRows shiftrows(out1,out2);
mixcolumns mixcol(out2,out3);
AddRoundKey addround(out3,KeySchedule[128*i +: 128],out4);

always @(posedge clk) 
begin
    if(i<1)begin
    i<=i+4'b0001;
    stateReg=out0;
    end
    else if(i<nr)begin
    i<=i+4'b0001;
    stateReg=out4;
    end
    else if (i == nr)begin
    i<=i+4'b0001;
    stateReg=out3Final;
    end
    

    // Inv Cipher !!!
    else if(i==(nr + 1))begin
        i<= i+4'b0001;
        stateReg=try;
    end
    else if(i<(nr + 11))begin
    i<=i+4'b0001;
    stateReg=out8;
    end
    else if (i == (nr + 11))begin
    i<=i+4'b0001;
    stateReg=out6Final;
    end
end
assign cipher=stateReg;

SubBytes subbytess(stateReg,out1Final);
ShiftRows shift(out1Final,out2Final);
AddRoundKey lastround(out2Final,KeySchedule[(128 * nr) +: 128], out3Final);

// Inverse cipher !!!

AddRoundKey inv_initialll (stateReg,KeySchedule[(128 * nr) +:128],try);


inv_SubBytes inv_subbytes(stateReg,out5);
invShiftRows inv_shiftrows(out5,out6);
AddRoundKey inv_addround(out6,KeySchedule[(128 * nr)-128*(i - (nr + 1)) +:128],out7);
inverseMixColumns inv_mixcol(out7,out8);

inv_SubBytes inv1_subbytess(stateReg,out4Final);
invShiftRows inv1_shift(out4Final,out5Final);
AddRoundKey inv1_lastround(out5Final,KeySchedule[0:127],out6Final);



endmodule


module testbench1();

// Parameters
wire [127:0] message =128'h00112233445566778899aabbccddeeff; // Fixed message
wire [127:0] key = 128'h000102030405060708090a0b0c0d0e0f ; // Fixed key
// Signals
wire [6:0] HEx2;
wire [6:0] HEx1;
wire [6:0] HEx0;
reg clk;

///



// Instantiate the module under test
AES #(4, 10) encrypt_inst (
    .Message(message),
    .Key(key),
    .clk(clk),
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