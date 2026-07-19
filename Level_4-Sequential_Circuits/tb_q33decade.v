module tb_q33;
reg Reset;
reg Clock;
wire [3:0] Counter;

q33 uut(.Clock(Clock),.Reset(Reset),.Counter(Counter));

initial begin
    $dumpfile("q33.vcd");
    $dumpvars(0,tb_q33);
    $monitor("Clock=%b,Reset=%b,Counter=%b",Clock,Reset,Counter);

    Clock=0;
    Reset=1;#10;
    Reset=0;#10;
    #120;
    $finish;
end
always #5 Clock=~Clock;
endmodule