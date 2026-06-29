module tb_q9;
reg a,b,cin;
wire sum,carry;

q9 uut(.a(a),.b(b),.cin(cin),.sum(sum),.carry(carry));

initial begin
    a=1'b0;b=1'b0;cin=1'b0;
    #10 a=1'b0;b=1'b0;cin=1'b1;
    #10 a=1'b0;b=1'b1;cin=1'b0;
    #10 a=1'b0;b=1'b1;cin=1'b1;
    #10 a=1'b1;b=1'b0;cin=1'b0;
    #10 a=1'b1;b=1'b0;cin=1'b1;
    #10 a=1'b1;b=1'b1;cin=1'b0;
    #10 a=1'b1;b=1'b1;cin=1'b1;
end

initial begin
    $monitor("a=%b,b=%b,cin=%b,sum=%b,carry=%b",a,b,cin,sum,carry);
end

endmodule