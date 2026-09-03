module tb_q50;

reg Clock;
reg Reset;
reg Emergency;

wire Light0;
wire Light1;
wire Light2;
wire Light3;
wire Emergency_Out;

q43 dut (
    .Clock(Clock),
    .Reset(Reset),
    .Emergency(Emergency),
    .Light0(Light0),
    .Light1(Light1),
    .Light2(Light2),
    .Light3(Light3),
    .Emergency_Out(Emergency_Out)
);

always #5 Clock = ~Clock;

initial begin

    $dumpfile("q50.vcd");
    $dumpvars(0, tb_q50);

    $monitor("Time=%0t | Clock=%b Reset=%b Emergency=%b | L0=%b L1=%b L2=%b L3=%b Emergency_Out=%b",
             $time, Clock, Reset, Emergency,
             Light0, Light1, Light2, Light3, Emergency_Out);

    Clock = 0;Reset = 1;Emergency = 0;#10;
    Reset = 0;#10;
    Emergency = 1;#10;
    Emergency = 0;#10;
    #10;
    Emergency = 1;#10;
    Emergency = 0;#10;
    #20;

    $finish;
end
endmodule