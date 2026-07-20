module q34 (
    input wire Clock,Reset,output reg Slowclk
);
reg [1:0] Counter;
    always @(posedge Clock) begin
        if (Reset) begin
            Counter<=0;
            Slowclk<=0;
        end
        else if(Counter==3) begin
            Slowclk<=~Slowclk;
            Counter<=0;
        end
        else begin
            Counter<=Counter+1;
        end
    end
endmodule