module q39 (
    input wire Clock, Reset, Coin, output wire Dispense
);
reg [1:0] Current_State,Next_State;
parameter S0=2'b00;
parameter S1=2'b01;
parameter S2=2'b10;
always @(posedge Clock or posedge Reset) begin
    if (Reset) begin
        Current_State<=S0;
    end 
    else begin
        Current_State<=Next_State;
    end
end

always @(*) begin
    Next_State=Current_State;
    case (Current_State)
        S0:begin
            if (Coin) begin
                Next_State=S1;
            end 
            else begin
                Next_State=S0;
            end
        end
        S1:begin
            if (Coin) begin
                Next_State=S2;
            end 
            else begin
                Next_State=S1;
            end
        end
        S2:begin
            if (Coin) begin
                Next_State=S1;
            end 
            else begin
                Next_State=S0;
            end
        end
        default:Next_State=S0;
    endcase
end

assign Dispense=(Current_State==S2);

endmodule