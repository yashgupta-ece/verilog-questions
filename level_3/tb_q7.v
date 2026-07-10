module tb_q7;
reg [7:0] in;
reg [2:0] shift;
wire [7:0] out;

q7 uut(.in(in),.shift(shift),.out(out));

initial begin
    $dumpfile("q7.vcd");
    $dumpvars(0,tb_q7);
    $monitor("input=%b,shift by=%b,output=%b",in,shift,out);
    in=8'b10100101;shift=3'b110;#10;
    in=8'b10001100;shift=3'b101;#10;
    in=8'b10111110;shift=3'b111;#10;
    in=8'b10101101;shift=3'b100;#10;
    in=8'b11100101;shift=3'b010;#10;
    in=8'b10101101;shift=3'b011;#10;
    in=8'b10110101;shift=3'b001;#10;
    in=8'b11100101;shift=3'b000;#10;
    $finish;
end
endmodule