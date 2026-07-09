module q6 (
    input wire [3:0] in1,input wire [3:0] in2, input wire [1:0] operator_code,output reg [3:0] out
);
    always @(*) begin
        case(operator_code)
        2'b00: out=in1+in2;
        2'b01: out=in1-in2;
        2'b10: out=in1&in2;
        2'b11: out=in1|in2;
        default: out=4'b0000;
        endcase
    end
endmodule