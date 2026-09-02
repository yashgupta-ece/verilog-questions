module tb_q49;
reg Clock;
reg Reset;
reg UpDown;

wire [3:0] Counter;

Q49 dut(
    .Reset(Reset),.Clock(Clock),.UpDown(UpDown),.Counter(Counter)
);

always #5 Clock=~Clock;

initial begin
    $dumpfile("q49.vcd");
    $dumpvars(0,tb_q49);

    $monitor("Clock=%b,Reset=%b,Updown=%b,Counter=%b",Clock,Reset,UpDown,Counter);

    Clock=0;Reset=1;UpDown=1;#10;
    Reset=0;UpDown=1;#70;
    UpDown=0;#30;
    Reset=1;#10;
    Reset=0;UpDown=1;#30;
    UpDown=0;#50;
    Reset=1;#10;
    UpDown=1;#170;
    $finish;
end
endmodule