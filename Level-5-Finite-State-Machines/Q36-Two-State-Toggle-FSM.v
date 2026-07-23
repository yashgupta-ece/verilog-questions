module q36 (
    input wire Toggle, Clock,Reset, output wire LED
);
    reg Current_State, Next_State;
    parameter STATE_A = 0;
    parameter STATE_B = 1;
    always @(posedge Clock) begin
        if (Reset) begin
            Current_State<=STATE_A;    
        end 
        else begin
            Current_State<=Next_State;
        end
    end

    always @(*) begin
        case (Current_State)
            STATE_A:begin
                if (Toggle) begin
                    Next_State=STATE_B;               
                end 
                else begin
                   Next_State=STATE_A; 
                end
            end
            STATE_B:begin
                if (Toggle) begin
                    Next_State=STATE_A;
                end 
                else begin
                    Next_State=STATE_B;
                end
            end
            default:Next_State = STATE_A;
        endcase
    end
    assign LED = Current_State;
endmodule