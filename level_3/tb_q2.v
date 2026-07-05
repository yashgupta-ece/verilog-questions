module tb_q2;
reg a,b,c,d;
reg [1:0] sel;
wire out;
q2 uut(.a(a),.b(b),.c(c),.d(d),.sel(sel),.out(out));

initial begin
    $dumpfile("q2.vcd");
    $dumpvars(0, tb_q2);

    $monitor("a=%b,b=%b,c=%b,d=%b,sel=%b,out=%b",a,b,c,d,sel,out);

    a=1;b=0;c=1;d=0;

    sel=2'b00;#10;
    sel=2'b01;#10;
    sel=2'b10;#10;
    sel=2'b11;#10;
    $finish;
end
endmodule