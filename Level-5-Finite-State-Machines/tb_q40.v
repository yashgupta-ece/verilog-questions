module tb_q40;
reg Reset;
    reg Clock;
    reg In;
    wire Detector;

    q40 uut(.Reset(Reset),.Clock(Clock),.In(In),.Detector(Detector));

    always #5 Clock=~Clock;

    initial begin
        $dumpfile("q40.vcd");
        $dumpvars(0,tb_q40);
        $monitor("Clock=%b,Reset=%b,IN=%b,State=%b,Detector=%b", Clock,Reset,In,uut.Current_State,Detector);
    Clock = 0;
Reset = 1;
In = 0;
#10;

Reset = 0;
In = 0;
#10;

In = 1;
#10;

In = 1;
#10;

In = 0;
#10;
In = 1;
#10;

Reset = 1;
#10;

Reset = 0;
#10;

$finish;
end
endmodule