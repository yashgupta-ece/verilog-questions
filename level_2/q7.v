module q7 (
    input wire [3:0] in,output wire [15:0] out 
);
    assign out= {4{in}};
endmodule