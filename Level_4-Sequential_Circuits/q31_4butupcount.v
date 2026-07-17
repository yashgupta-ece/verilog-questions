module q31 (
    input wire Clock,output reg [3:0] Counter
);
initial begin
    Counter=0;
end
    always @(posedge Clock) begin
        Counter<= Counter+4'b0001;
    end
endmodule