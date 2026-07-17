module tb_31;
reg Clock;
wire [3:0] Counter;

q31 uut(.Clock(Clock),.Counter(Counter));

initial begin
    $dumpfile("q31.vcd");
    $dumpvars(0,tb_31);
    $monitor("Clock=%b,Count=%b",Clock,Counter);
    Clock=0;
    #100;
    $finish;
end

always #5 Clock=~Clock;
endmodule