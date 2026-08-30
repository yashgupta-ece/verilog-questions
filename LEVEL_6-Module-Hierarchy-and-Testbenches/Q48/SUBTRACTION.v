module SUBTRACTION (
    input wire [3:0] A,
    input wire [3:0] B,
    output wire [3:0] Y
);
    wire [3:0] B_Complement;
    assign B_Complement=~B;

    Ripple_Carry SUBTRACTION(
        .A_in(A),
        .B_in(B_Complement),
        .C_in(1'b1),
        .Sum(Y),
        .C_out()
    );
endmodule