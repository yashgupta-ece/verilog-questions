module q32 (
    input wire Clock,Reset,UpDown, output reg [3:0] Counter
);
    always @(posedge Clock) begin
        if (Reset) begin
            Counter<= 4'b0000;
        end
        else if (UpDown) begin
            Counter<= Counter+4'b0001;
        end 
        else begin
            Counter<= Counter-4'b0001;
        end
    end
endmodule