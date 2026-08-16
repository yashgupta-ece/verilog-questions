module Q44 (
    input wire Clock,Reset, Entry,Exit,Emergency,output reg Empty_Out,Occupied_Out,Full_Out,Emergency_Out
);
    reg [1:0] current_state;
    reg [1:0] next_state;
    parameter Empty = 2'b00;
    parameter Occupied = 2'b01;
    parameter Full = 2'b10;
    parameter EMERGENCY = 2'b11;
    wire [2:0] Status;
    assign Status = {Full_Out, Occupied_Out, Empty_Out};

always @(posedge Clock or posedge Reset) begin
    if (Reset) begin
        current_state<=Empty;
    end 
    else begin
        current_state<=next_state;
    end
end

always @(*) begin
    next_state=current_state;
    if (Emergency) begin
        next_state=EMERGENCY;
    end
    else begin
    case(current_state)
        Empty:if (Entry) begin
            next_state=Occupied;
        end
        Occupied: if (Entry) begin
            next_state= Full;
        end 
        else if(Exit)begin
            next_state=Empty;
        end
        Full: begin
        if (Exit)
        next_state = Occupied;
        end
        EMERGENCY: begin
        next_state = Empty;
        end
        default:next_state=current_state;
    endcase
    end
end

always @(*) begin
    Empty_Out=1'b0;
    Occupied_Out = 1'b0;
    Full_Out = 1'b0;
    Emergency_Out = 1'b0;
    case (current_state)
        Empty:Empty_Out=1'b1;
        Occupied:Occupied_Out=1'b1;
        Full:Full_Out=1'b1;
        EMERGENCY:Emergency_Out=1'b1; 
        default:begin Empty_Out=1'b0;
    Occupied_Out = 1'b0;
    Full_Out = 1'b0;
    Emergency_Out = 1'b0;
    end
    endcase
end
endmodule