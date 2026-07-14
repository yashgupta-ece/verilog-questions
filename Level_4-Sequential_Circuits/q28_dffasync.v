module q28 (
    input wire clk,D,reset, output reg Q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
           Q <= 0;
        else
           Q <= D;
    end
endmodule