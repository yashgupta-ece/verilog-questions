module ALU (
    input wire [3:0] A_in,
    input wire [3:0] B_in,
    input wire [1:0] Sel,
    output reg [3:0] ALU_Out
);
    wire [3:0] Add_Result;
    wire [3:0] Sub_Result;
    wire [3:0] AND_Result;
    wire [3:0] XOR_Result;

    Ripple_Carry ADD(
        .A_in(A_in),
        .B_in(B_in),
        .C_in(1'b0),
        .Sum(Add_Result),
        .C_out()
    );

    SUBTRACTION SUB(
        .A(A_in),
        .B(B_in),
        .Y(Sub_Result)
    );

    AND And(
        .A(A_in),
        .B(B_in),
        .Y(AND_Result)
    );

    XOR Xor(
        .A(A_in),
        .B(B_in),
        .Y(XOR_Result)
    );

    always @(*) begin
        case (Sel)
            2'b00:ALU_Out=Add_Result;
            2'b01:ALU_Out=Sub_Result;
            2'b10:ALU_Out= AND_Result;
            2'b11:ALU_Out=XOR_Result;
            default:ALU_Out=4'b0000;
        endcase
    end
endmodule