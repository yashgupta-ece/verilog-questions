module q29 (
    input wire [3:0] D,
    input wire clock, 
    output reg [3:0] Q
);
    always @(posedge clock) begin
        Q<=D;
    end
endmodule