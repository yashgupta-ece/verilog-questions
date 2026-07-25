module q38 (
    input wire Reset,Clock,X, output wire Detector
);
    reg [1:0] Current_State,Next_State;
    parameter S0=2'b00;
    parameter S1=2'b01;
    parameter S2=2'b10;
    parameter S3=2'b11;
    always @(posedge Clock) begin
        if (Reset) begin
            Current_State<=S0;
        end 
        else begin
            Current_State<=Next_State;
        end
    end

    always @(*) begin
        case (Current_State)
            S0:begin
                if (X) begin
                    Next_State=S1;
                end 
                else begin
                    Next_State=S0;
                end
            end
            S1:begin
                if (X) begin
                    Next_State=S1;
                end 
                else begin
                    Next_State=S2;
                end
            end
            S2:begin
                if (X) begin
                    Next_State=S3;
                end else begin
                    Next_State=S0;
                end
            end
            S3:begin
                if (X) begin
                    Next_State=S1;
                end 
                else begin
                    Next_State=S2;
                end
            end
            default:Next_State=S0;
        endcase
    end

    assign Detector= (Current_State== S3);    
endmodule