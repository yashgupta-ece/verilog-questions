module FSM (
    input wire Clock,Reset,Start, Stop, output reg enable
);
localparam IDLE = 1'b0;
localparam  RUNNING=1'b1;
reg Current_State;
reg Next_State;

always @(posedge Clock or posedge Reset)
begin
    if (Reset)
        Current_State <= IDLE;
    else
        Current_State <= Next_State;
end

always @(*) begin
    Next_State=Current_State;
    case (Current_State)
        IDLE:begin
            if (Start) begin
                Next_State=RUNNING;
            end 
            else begin
                Next_State=IDLE;
            end
        end
        RUNNING: begin
            if (Stop) begin
                Next_State=IDLE;
            end 
            else begin
                Next_State=RUNNING;    
            end
        end
        default:Next_State=IDLE;
    endcase
end

always @(*) begin
    case (Current_State)

        IDLE: begin
            enable = 1'b0;
        end

        RUNNING: begin
            enable = 1'b1;
        end

        default: begin
            enable = 1'b0;
        end

    endcase
end
endmodule