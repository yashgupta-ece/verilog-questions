module Eight_bit_Adder (
    input wire [7:0] A_in,
    input wire [7:0] B_in,
    input wire C_in,
    output wire [7:0] Sum,
    output wire C_out
);
    wire C4;
    Ripple_Carry RC1(.A_in(A_in[3:0]),.B_in(B_in[3:0]),.C_in(C_in),.Sum(Sum[3:0]),.C_out(C4));
    Ripple_Carry RC2(.A_in(A_in[7:4]),.B_in(B_in[7:4]),.C_in(C4),.Sum(Sum[7:4]),.C_out(C_out));
endmodule