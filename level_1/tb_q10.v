module tb_q10;

reg p1, p2, p3, p4, p5, p6, p7, p8, p9, p10;
wire p1y, p2y;


q10 uut (
    .p1(p1), .p2(p2), .p3(p3),
    .p4(p4), .p5(p5), .p6(p6),
    .p7(p7), .p8(p8),
    .p9(p9), .p10(p10),
    .p1y(p1y), .p2y(p2y)
);

initial begin
    $monitor("T=%0t | p1y=%b p2y=%b | Inputs=%b%b%b %b%b%b %b%b %b%b",
             $time,
             p1y, p2y,
             p1,p2,p3,p4,p5,p6,p7,p8,p9,p10);


    {p1,p2,p3,p4,p5,p6,p7,p8,p9,p10} = 10'b0000000000;
    #10;

    {p1,p2,p3,p4,p5,p6,p7,p8,p9,p10} = 10'b1110000000;
    #10;

    {p1,p2,p3,p4,p5,p6,p7,p8,p9,p10} = 10'b0001110000;
    #10;

    {p1,p2,p3,p4,p5,p6,p7,p8,p9,p10} = 10'b0000001100;
    #10;

    {p1,p2,p3,p4,p5,p6,p7,p8,p9,p10} = 10'b0000000011;
    #10;

    {p1,p2,p3,p4,p5,p6,p7,p8,p9,p10} = 10'b1111111111;
    #10;

    $finish;
end

endmodule