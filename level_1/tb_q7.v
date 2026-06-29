module tb_q7;
reg a,b;
wire c;

q7 uut(.a(a),.b(b),.c(c));

initial begin
    a=1'b0;b=1'b0;
    #10 a=1'b0;b=1'b1;
    #10 a=1'b1;b=1'b0;
    #10 a=1'b1;b=1'b1;
    #10 $finish;
end

initial begin
    $monitor("a=%b,b=%b,NAND=%b,NOR=%b",a,b,c,d);
end

endmodule