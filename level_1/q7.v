module q7 (
    input wire a,b,output wire c,d
);
    assign c=~(a&b);
    assign d=~(a|b);
endmodule