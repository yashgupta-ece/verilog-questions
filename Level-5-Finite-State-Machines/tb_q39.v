module tb_q39;
    reg Reset;
    reg Clock;
    reg Coin;
    wire Dispense;

    q39 uut(.Reset(Reset),.Clock(Clock),.Coin(Coin),.Dispense(Dispense));

    always #5 Clock=~Clock;

    initial begin
        $dumpfile("q39.vcd");
        $dumpvars(0,tb_q39);
        $monitor("Clock=%b,Reset=%b,COIN=%b,State=%b,Dispense=%b", Clock,Reset,Coin,uut.Current_State,Dispense);
    Clock = 0;
    Reset = 1;
Coin = 1;
#10;

Reset = 1;
#10;

Reset = 0;
Coin = 0;
#10;
Coin = 1;
#10;
Coin = 1;
#10;
Reset = 1;
#10;
Reset = 0;
#10;
$finish;
end
endmodule