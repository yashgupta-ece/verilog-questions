module q8 (
    input wire [7:0] in, output wire [7:0] out
);
    wire [3:0] lower;
    wire [3:0] upper;
    assign lower= in[3:0];
    assign upper= in[7:4];
    assign out= {lower,upper};
endmodule