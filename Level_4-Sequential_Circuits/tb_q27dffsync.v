module tb_q27;
reg clk;
reg d;
reg reset;
wire q;

q27 uut(.clk(clk),.d(d),.reset(reset),.q(q));

initial begin
    $dumpfile("q27.vcd");
    $dumpvars(0,tb_q27);
    $monitor("D=%b,Clk=%b,Reset=%b,Q=%b",d,clk,reset,q);

    clk=0;
    d=0;reset=1;#10;
    d=1;reset=0;#12;
    d=1;reset=1;#15;
    d=0;reset=1;#17;
    d=0;reset=0;#14;
    $finish;
end

always #5 clk= ~clk;

endmodule