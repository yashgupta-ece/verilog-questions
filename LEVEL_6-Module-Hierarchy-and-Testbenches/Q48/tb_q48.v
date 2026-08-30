module tb_q48;

reg [3:0] A_in;
reg [3:0] B_in;
reg [1:0] Sel;

wire [3:0] ALU_Out;

ALU dut (
    .A_in(A_in),
    .B_in(B_in),
    .Sel(Sel),
    .ALU_Out(ALU_Out)
);

initial begin

    $dumpfile("q48.vcd");
    $dumpvars(0,tb_q48);

    $monitor("A=%b B=%b Sel=%b | ALU_Out=%b",
             A_in,B_in,Sel,ALU_Out);
    A_in=4'b0101; B_in=4'b0011; Sel=2'b00; #10;
    A_in=4'b0101; B_in=4'b0011; Sel=2'b01; #10;
    A_in=4'b1010; B_in=4'b1100; Sel=2'b10; #10;
    A_in=4'b1010; B_in=4'b1100; Sel=2'b11; #10;
    A_in=4'b1111; B_in=4'b0001; Sel=2'b00; #10;
    A_in=4'b1001; B_in=4'b0011; Sel=2'b01; #10;

    $finish;

end

endmodule