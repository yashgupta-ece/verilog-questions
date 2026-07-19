module q33 (
    input wire Reset,Clock,output reg [3:0] Counter
);
    always @(posedge Clock) begin
        if (Reset) begin
            Counter<=0;
        end 
        else if(Counter==4'b1001) begin
            Counter<=0;
        end
        else begin
            Counter<= Counter+1;
        end
    end
endmodule