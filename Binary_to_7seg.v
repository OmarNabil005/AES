module Binary_to_7seg(
    input[7:0] in,
    output reg[6:0] hundreds,
    output reg[6:0] tens,
    output reg[6:0] ones
    );

wire [3:0] w1,w2, w3, w4, w5, w6, w7;
wire [6:0] o1, o2, o3;

shift_add_3 sh1({1'b0, in[7:5]}, w1);
shift_add_3 sh2({w1[2:0], in[4]}, w2);
shift_add_3 sh3({w2[2:0], in[3]}, w3);
shift_add_3 sh4({w3[2:0], in[2]}, w4);
shift_add_3 sh5({w4[2:0], in[1]}, w5);
shift_add_3 sh6({1'b0, w1[3], w2[3], w3[3]}, w6);
shift_add_3 sh7({w6[2:0], w4[3]}, w7);

BCD_to_7seg one({w5[2:0], in[0]}, o1);
BCD_to_7seg ten({w7[2:0], w5[3]}, o2);
BCD_to_7seg hundred({2'b00, w6[3], w7[3]}, o3);

always @(in) begin
    ones = o1;
    tens = o2;
    hundreds = o3;
end

endmodule

module shift_add_3(input[3:0] in, output reg[3:0] out);

always @(in) begin
    if (in < 5)
        out = in;
    else
        out = in + 3;
end

endmodule

module BCD_to_7seg(input[3:0] in, output reg [6:0] out);
      
    always @(in)
    begin
        case (in)
            0 : out = 7'b1000000;
            1 : out = 7'b1111001;
            2 : out = 7'b0100100;
            3 : out = 7'b0110000;
            4 : out = 7'b0011001;
            5 : out = 7'b0010010;
            6 : out = 7'b0000010;
            7 : out = 7'b1111000;
            8 : out = 7'b0000000;
            9 : out = 7'b0010000;
            default : out = 7'b1111111;
        endcase
    end
    
endmodule