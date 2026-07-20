module tb_q34;
reg Reset;
reg Clock;
wire Slowclk;
wire [1:0] Counter;

q34 uut(.Clock(Clock),.Reset(Reset),.Slowclk(Slowclk));

initial begin
    $dumpfile("q34.vcd");
    $dumpvars(0,tb_q34);
    $monitor("Clock=%b,Reset=%b,Slow_clock=%b",Clock,Reset,Slowclk);

    Clock=0;
    Reset=1;#10;
    Reset=0;#10;
    #100;
    $finish;
end
always #5 Clock=~Clock;
endmodule