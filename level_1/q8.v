module q8 (
    input wire a,b,output wire sum, carry
);
    and a1(carry,a,b);
    xor x1(sum,a,b);
endmodule