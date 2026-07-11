module tb_q26;
reg d;
reg clk;
wire q;

q26 uut(.d(d),.clk(clk),.q(q));

initial begin
    $dumpfile("q26.vcd");
    $dumpvars(0,tb_q26);
    $monitor("D=%b,Clock=%b,Q=%b",d,clk,q);

    clk=0;
    d=0;#10;
    d=1;#12;
    d=1;#15;
    d=0;#10;
    d=0;#10;
    $finish;
end

always begin
    #5 clk= ~clk;
end
endmodule