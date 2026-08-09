module q42 (
    input wire Clock, Reset, enable, output reg [3:0] count
);
always @(posedge Clock or posedge Reset) begin
    if (Reset) begin
        count<=4'b0000;
    end 
    else begin
        if (enable) begin
            count<= count+1;
        end 
    end
end

endmodule