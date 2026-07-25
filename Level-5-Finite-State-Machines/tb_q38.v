    module tb_q38;
    reg Reset;
    reg Clock;
    reg X;
    wire Detector;

    q38 uut(.Reset(Reset),.Clock(Clock),.X(X),.Detector(Detector));

    always #5 Clock=~Clock;

    initial begin
        $dumpfile("q38.vcd");
        $dumpvars(0,tb_q38);
        $monitor("Clock=%b,Reset=%b,X=%b,State=%b,Detector=%b", Clock,Reset,X,uut.Current_State,Detector);
    Clock = 0;
    Reset = 1;
    X = 0;#10;
    Reset = 0;X = 0;#10;
    X = 1;#10;
    X = 0;#10;
    X = 1;#10;
    X = 0;#10;
    X = 1;#10;
    X = 1;#10;
    X = 0;#10;
    X = 1;#10;
    $finish;
    end
    endmodule