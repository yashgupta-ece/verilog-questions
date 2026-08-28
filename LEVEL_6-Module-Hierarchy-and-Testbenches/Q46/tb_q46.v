module tb_q46;
reg [3:0] A_in;
reg [3:0] B_in;
reg C_in;
wire [3:0] Sum;
wire C_out;

Ripple_Carry dut(.A_in(A_in),.B_in(B_in),.C_in,.Sum(Sum),.C_out(C_out));

initial begin
    $dumpfile("q46.vcd");
    $dumpvars(0,tb_q46);

    $monitor("A=%b,B=%b,C_in=%b,Sum=%b,C_out=%b",A_in,B_in,C_in,Sum,C_out);

    A_in=4'b0000;
    B_in=4'b0000;
    C_in=1'b0;#10;

    A_in=4'b0001;
    B_in=4'b0001;
    C_in=1'b0;#10;

    A_in=4'b0101;
    B_in=4'b0011;
    C_in=1'b0;#10;

    A_in=4'b0111;
    B_in=4'b0001;
    C_in=1'b0;#10;

    A_in=4'b1111;
    B_in=4'b0001;
    C_in=1'b0;#10;

    A_in=4'b1010;
    B_in=4'b0101;
    C_in=1'b1;#10;

    A_in=4'b1111;
    B_in=4'b1111;
    C_in=1'b0;#10;
$finish;
end
endmodule