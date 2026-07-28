module q40 (
    input wire Reset,Clock, In, output wire Detector
);
    reg Current_State,Next_State;
    parameter S0=0;
    parameter S1=1;
    always @(posedge Clock or posedge Reset) begin
        if (Reset) begin
            Current_State<=S0;
        end else begin
            Current_State<=Next_State;
        end
    end

    always @(*) begin
        case (Current_State)
            S0:if (In) begin
                Next_State=S1;
            end else begin
                Next_State=S0;
            end 
            S1:if (In) begin
                Next_State=S1;
            end else begin
                Next_State=S0;
            end
            default:Next_State=S0;
        endcase
    end

    assign Detector= (Current_State==S0) && (In==1);
endmodule