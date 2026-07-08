module q5 (
    input wire [1:0] in1,input wire [1:0] in2, output reg greater,less,equal
);
    always @(*) begin
        if(in1>in2)
         begin
            greater=1'b1;
            less=1'b0;
            equal=1'b0;
         end
        else if (in1==in2) begin
            greater=1'b0;
            less=1'b0;
            equal=1'b1;
        end
        else
         begin
            greater=1'b0;
            less=1'b1;
            equal=1'b0;
         end
    end
endmodule