module tb_q47;
reg [7:0] A_in;
reg [7:0] B_in;
reg C_in;
wire [7:0] Sum;
wire C_out;

Eight_bit_Adder dut(.A_in(A_in),.B_in(B_in),.C_in(C_in),.Sum(Sum),.C_out(C_out));

initial begin
    $dumpfile("q47.vcd");
    $dumpvars(0,tb_q47);

    $monitor("A=%b,B=%b,C_in=%b,Sum=%b,C_out=%b",A_in,B_in,C_in,Sum,C_out);

    A_in=8'b00000000;B_in=8'b00000000;C_in=1'b0;#10;
    A_in=8'b00000001;B_in=8'b00000001;C_in=1'b0;#10;
    A_in=8'b00001111;B_in=8'b00000001;C_in=1'b0;#10;
    A_in=8'b01010101;B_in=8'b00110011;C_in=1'b0;#10;
    A_in=8'b11111111;B_in=8'b00000001;C_in=1'b0;#10;
    A_in=8'b10101010;B_in=8'b01010101;C_in=1'b1;#10;
    A_in=8'b11111111;B_in=8'b11111111;C_in=1'b1;#10;
    $finish;
end
endmodule