module q9 (
    input wire a,b,cin, output sum,carry
);
wire w1,w2,w3;
  //carry
  and a1(w1,a,b);
  and a2(w2,b,c);
  and a3(w3,a,c);
  or r1(carry,w1,w2,w3);

  //sum  
  xor x1(sum,a,b,cin);
endmodule