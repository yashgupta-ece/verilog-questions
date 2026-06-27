module tb_q2;
reg a;
wire b;

q2 uut(.a(a),.b(b));

initial begin
    a=1'b0;
    #10 a=1'b1;
    #10 $finish;
end

initial begin
    $monitor("a=%b,b=%b",a,b);
end

endmodule