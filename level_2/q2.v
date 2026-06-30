module q2 (
    input wire [3:0] a, output wire [1:0] lower,[1:0] upper
);
    assign lower= a[1:0];
    assign upper= a[3:2];
endmodule