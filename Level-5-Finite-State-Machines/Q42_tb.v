module tb_q42;
reg Clock;
reg Reset;
reg Start;
reg Stop;
wire [3:0] count;

Top dut(.Clock(Clock),.Reset(Reset),.Start(Start),.Stop(Stop),.count(count));

initial begin
    Clock=0;
end

always #5 Clock=~Clock;

initial begin
    Reset=1;Start=0;Stop=0;#10;
    Reset=0;#10;
    Start=1;#10;
    Start=0;#30;
    Stop=1;#10;
    Stop=0;#20;
    $finish;
end
initial begin
    $dumpfile("q42.vcd");
    $dumpvars(0,tb_q42);
    $monitor("Time=%0t Reset=%b Start=%b Stop=%b Count=%d",$time, Reset, Start, Stop, count);
end
endmodule