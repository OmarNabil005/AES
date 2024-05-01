module FSM (input a , input b , input clk , output reg oa , output reg ob);


localparam [1:0] statea = 2'b00;
localparam [1:0] stateb = 2'b01;
localparam [1:0] idle = 2'b11;

reg[1:0] crnt_state;
reg[1:0] next_state;

initial begin
crnt_state = idle;
oa = 0;
ob = 0;

end


always @(posedge clk)begin

oa = 0;
ob = 0;



if (a) next_state = statea;
if (b) next_state = stateb;


case (crnt_state)

statea : begin

if (b && !a)
ob = 1;

end

stateb : begin

if (a && !b)
oa = 1;

end


idle : begin
if (a && !b)
oa = 1;
if (b && !a)
ob = 1;
end


endcase

crnt_state <= next_state;

end

endmodule



/* module FSM_DUT ();
reg clk;
reg a;
reg b;
wire oa;
wire ob;

localparam PERIOD  = 10;

FSM UUT (.clk(clk) , .a(a) , .b(b) , .oa(oa) , .ob(ob));

always
#(PERIOD / 2) clk = ~clk;


initial begin
$display ("a      b      LED A      LED B  ");
$monitor ("%b      %b     %b          %b" , a , b,  oa ,ob );

clk = 0;
a = 0;
b = 0;
    

#(PERIOD * 2) a = 0; b = 0; 

#(PERIOD * 2) a = 0; b = 1; 

#(PERIOD * 2) a = 1; b = 0;

#(PERIOD * 2) a = 1; b = 0;

#(PERIOD * 2) a = 0; b = 1;

#(PERIOD * 2) a = 0; b = 1;

#(PERIOD * 2) a = 1; b = 1;

#(PERIOD * 2) a = 1; b = 0;

$finish;
end

endmodule */