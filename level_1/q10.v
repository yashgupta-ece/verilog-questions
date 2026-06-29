module q10 (
    input wire p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,output wire p1y,p2y
);
wire w1,w2,w3,w4;
    and a1(w1,p1,p2,p3);
    and a2(w2,p4,p5,p6);
    and a3(w3,p7,p8);
    and a4(w4,p9,p10);
    or r1(p1y,w1,w2);
    or r2(p2y,w3,w4);
endmodule