module tb_q1;
reg a,b,sel;
wire out;

q1 uut(.a(a),.b(b),.sel(sel),.out(out));

initial begin
    $monitor("a=%b,b=%b,sel=%b,out=%b",a,b,sel,out);
    a=1'b1;b=1'b0;sel=0;#10;
    a=1'b0;b=1'b1;sel=0;#10;
    a=1'b1;b=1'b1;sel=1;#10;
    $finish;
end
endmodule