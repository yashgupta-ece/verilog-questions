module tb_30;
reg D;
reg Clock;
wire [3:0] Q;

q30 uut(.D(D),.Clock(Clock),.Q(Q));

initial begin
    $dumpfile("q30.vcd");
    $dumpvars(0,tb_30);
    $monitor("D=%b,Clock=%b,Q=%b",D,Clock,Q);

    Clock=0;
    D=1;#10;
    D=0;#10;
    D=1;#10;
    D=1;#10;
    D=0;#10;
    D=1;#10;
    $finish;
end

always #5 Clock=~Clock;
endmodule