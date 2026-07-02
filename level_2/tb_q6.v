module tb_q6;
reg [7:0] a;
wire out;

q6 uut(.a(a),.out(out));

initial begin
    $monitor("a=%b,out=%b",a,out);
    a=8'b00000001; #10;
    a=8'b00000000; #10;
    a=8'b11111111; #10;
    a=8'b10001010; #10;
    $finish;
end
endmodule