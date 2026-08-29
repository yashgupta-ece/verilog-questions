module Ripple_Carry (
    input wire [3:0] A_in,
    input wire [3:0] B_in,
    input wire C_in,
    output wire [3:0] Sum,
    output wire C_out
);
wire C1,C2,C3;
Full_Adder FA_0(.A(A_in[0]),.B(B_in[0]),.C_in(C_in),.Sum(Sum[0]),.Carry(C1));
Full_Adder FA_1(.A(A_in[1]),.B(B_in[1]),.C_in(1),.Sum(Sum[1]),.Carry(C2));
Full_Adder FA_2(.A(A_in[2]),.B(B_in[2]),.C_in(C2),.Sum(Sum[2]),.Carry(C3));
Full_Adder FA_3(.A(A_in[3]),.B(B_in[3]),.C_in(C3),.Sum(Sum[3]),.Carry(C_out));

    
endmodule