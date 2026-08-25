module Q45 (
    input wire Clock,
    input wire Reset,
    input wire Start,
    input wire [7:0] Data, 
    output reg Tx,Busy
);
    reg [1:0] current_state;
    reg [1:0] next_state;
    parameter IDLE=2'b00;
    parameter START=2'b01;
    parameter DATA=2'b10;
    parameter STOP=2'b11;
    reg [7:0] data_reg;
    reg [2:0] bit_count;

    always @(posedge Clock or posedge Reset) begin
    if (Reset) begin
        current_state <= IDLE;
        bit_count <= 3'b000;
    end
    else begin
        current_state <= next_state;

        if (current_state == IDLE && Start) begin
            data_reg <= Data;
            bit_count <= 3'b000;
        end

        else if (current_state == DATA && bit_count < 3'd7) begin
            bit_count <= bit_count + 1'b1;
        end
    end
end

    always @(*) begin
        next_state=current_state;
        case (current_state)
            IDLE:if (Start) begin
                next_state=START;
            end 
            START:begin 
                next_state=DATA;
            end
            DATA:if (bit_count==3'd7) begin
                next_state=STOP;
            end
            else begin
                next_state=DATA;
            end
            STOP:begin
                next_state=IDLE;
            end
            default:next_state=IDLE;
        endcase
    end

always @(*) begin
    Tx=1'b0;
    Busy=1'b0;
    case (current_state)
        IDLE:begin 
        Tx=1;
        Busy=1'b0;
        end
        START:begin 
        Tx=0;
        Busy=1;
        end
        DATA:begin 
            Tx=data_reg[bit_count];
            Busy=1;
        end
        STOP:begin 
            Tx=1;
            Busy=1;
        end 
        default:begin
            Tx=1'b0;
            Busy=1'b0;
        end
    endcase
end
endmodule