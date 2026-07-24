module tb_q37;
reg Reset;
reg Clock;
reg X;
wire LED;

q37 uut(.Clock(Clock),.Reset(Reset),.X(X),.LED(LED));

always #5 Clock=~Clock;

initial begin
    $dumpfile("q37.vcd");
    $dumpvars(0,tb_q37);
    $monitor("Clock=%b,Reset=%b,X=%b,State=%b,LED=%b", Clock,Reset,X,uut.Current_State,LED);

    Clock=0;
    Reset=1;
    X=1'b0;#10;
    Reset=0;X=1'b0;#10;
    X=1'b1;#10;
    X=1'b0;#10;
    X=1'b1;#10;
    X=1'b0;#10;
    X=1'b1;#10;
    $finish;
end
endmodule