module q5 (
    input wire [3:0] in1,input wire [3:0] in2, output wire [3:0] out_and,output wire [3:0] out_or,output wire [3:0] out_xor
);
    assign out_and= in1&in2;
    assign out_or= in1 | in2;
    assign out_xor= in1 ^ in2;
endmodule