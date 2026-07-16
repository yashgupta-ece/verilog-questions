module q30 (
    input wire D,Clock, output reg [3:0] Q
);
    always @(posedge Clock) begin
        Q<= {Q[2:0], D};
    end
endmodule