module Binary_to_BCD(
    input[7:0] in,
    output reg[3:0] hundreds,
    output reg[3:0] tens,
    output reg[3:0] ones
    );

wire [3:0] w1,w2, w3, w4, w5, w6, w7;

shift_add_3 sh1({1'b0, in[7:5]}, w1);
shift_add_3 sh2({w1[2:0], in[4]}, w2);
shift_add_3 sh3({w2[2:0], in[3]}, w3);
shift_add_3 sh4({w3[2:0], in[2]}, w4);
shift_add_3 sh5({w4[2:0], in[1]}, w5);
shift_add_3 sh6({1'b0, w1[3], w2[3], w3[3]}, w6);
shift_add_3 sh7({w6[2:0], w4[3]}, w7);

always @(in) begin
    ones = {w5[2:0], in[0]};
    tens = {w7[2:0], w5[3]};
    hundreds = {2'b00, w6[3], w7[3]};
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