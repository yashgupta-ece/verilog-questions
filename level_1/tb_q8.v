module tb_q8;
reg a,b;
wire sum, carry;

q8 uut(.a(a),.b(b),.sum(sum),.carry(carry));

initial begin
    a=1'b0;b=1'b0;
    #10 a=1'b0;b=1'b1;
    #10 a=1'b1;b=1'b0;
    #10 a=1'b1;b=1'b1;
    #10 $finish;
end

initial begin
    $monitor("a=%b,b=%b,sum=%b,carry=%b",a,b,sum,carry);
end
endmodule