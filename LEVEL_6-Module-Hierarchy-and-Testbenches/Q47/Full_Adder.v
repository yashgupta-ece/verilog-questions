module Full_Adder (
    input wire A,B,C_in, output Sum,Carry
);
    wire w1,w2,w3;

    and a1(w1,A,B);
    and a2(w2,B,C_in);
    and a3(w3,A,C_in);
    or r1(Carry,w1,w2,w3);

    xor x1(Sum,A,B,C_in);
endmodule