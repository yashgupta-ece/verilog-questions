module tb_q1;
wire b;
reg a;

q1 uut(
    .a(a),.b(b)
);
initial begin
    a=0;
    #10 a=1;
    #10 a=0;
    $finish;
end
initial begin
    $monitor("a=%b, b=%b",a,b);
end
endmodule