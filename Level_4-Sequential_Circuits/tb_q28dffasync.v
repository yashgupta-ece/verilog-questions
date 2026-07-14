module tb_q28;
reg reset;
reg clk;
reg D;
wire Q;

q28 uut(.D(D),.reset(reset),.clk(clk),.Q(Q));

initial begin
    $dumpfile("q28.vcd");
    $dumpvars(0,tb_q28);
    $monitor("D=%b,Clock=%b,Reset=%b,Q=%b",D,clk,reset,Q);

    clk=0;
    D=0;reset=1;#10;
    D=0;reset=0;#12;
    D=1;reset=1;#15;
    D=1;reset=0;#20;
    D=1;reset=1;#21;
    $finish;
end

always #5 clk= ~clk;

endmodule