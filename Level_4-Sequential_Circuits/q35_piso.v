module q35 (
    input wire Clock,Load,input wire [3:0] D, output wire Serialout
);
    reg [3:0] Register;
    always @(posedge Clock) begin
        if (Load) begin
            Register<=D;
        end 
        else begin
            Register<= {1'b0, Register [3:1]};    
        end
    end
    assign Serialout= Register [0];
endmodule