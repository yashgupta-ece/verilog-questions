module q43 (
    input wire Clock,Reset,Emergency, output reg Light0, Light1, Light2, Light3, Emergency_Out 
);
    reg [2:0] current_state;
    reg [2:0] next_state;
    reg [2:0] previous_state;
    parameter S0= 3'b000;
    parameter S1= 3'b001;
    parameter S2= 3'b010;
    parameter S3= 3'b011;
    parameter EMERGENCY= 3'b100;
    wire [3:0] Lights;
    assign Lights = {Light3, Light2, Light1, Light0};

    always @(posedge Clock or posedge Reset) begin
    if (Reset) begin
        current_state  <= S0;
        previous_state <= S0;
    end
    else begin
    if (Emergency && current_state != EMERGENCY)
        previous_state <= current_state;
        current_state <= next_state;
    end
end


always @(*) begin
    next_state=current_state;
    if (Emergency) begin
        next_state=EMERGENCY;
    end 
    else begin
        case(current_state)
        S0:next_state=S1;
        S1:next_state=S2;
        S2:next_state=S3;
        S3:next_state=S0;
        EMERGENCY:begin
            next_state=previous_state;
        end

        default:next_state=current_state;
        endcase

    end
end

always @(*) begin
    Light0=1'b0;
    Light1=1'b0;
    Light2=1'b0;
    Light3=1'b0;
    Emergency_Out=1'b0;
    case (current_state)
        S0:begin
            Light0=1'b1;
        end 
        S1:begin
            Light1=1'b1;
        end
        S2:begin
            Light2=1'b1;
        end
        S3:begin
            Light3=1'b1;
        end
            EMERGENCY:begin
            Emergency_Out=1'b1;
        end
        default:begin
            
        end
    endcase
end
endmodule