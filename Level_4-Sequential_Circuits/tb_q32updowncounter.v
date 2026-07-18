module tb_q32;
reg Clock;
reg Reset;
reg UpDown;
wire [3:0] Counter;

q32 uut(.Clock(Clock),.Reset(Reset),.UpDown(UpDown),.Counter(Counter));

initial begin
    $dumpfile("q32.vcd");
    $dumpvars(0,tb_q32);
    $monitor("Clock=%b,reset=%b,Up/Down=%b,Counter=%b",Clock,Reset,UpDown,Counter);
    Clock=0;
    Reset=0;UpDown=1;#10;
    Reset=0;UpDown=1;#10;
    Reset=1;UpDown=0;#10;
    Reset=0;UpDown=1;#10;
    Reset=0;UpDown=1;#10;
    Reset=0;UpDown=1;#10;
    Reset=1;UpDown=1;#10;
    $finish;
end

always #5 Clock=~Clock;
endmodule