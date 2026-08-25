module tb_Q45;

reg Clock;
reg Reset;
reg Start;
reg [7:0] Data;

wire Tx;
wire Busy;

Q45 dut (
    .Clock(Clock),
    .Reset(Reset),
    .Start(Start),
    .Data(Data),
    .Tx(Tx),
    .Busy(Busy)
);

always #5 Clock = ~Clock;

initial begin

    $dumpfile("q45.vcd");
    $dumpvars(0, tb_Q45);

    $monitor("Clock=%b Reset=%b Start=%b Data=%b Tx=%b Busy=%b",Clock, Reset, Start, Data, Tx, Busy);
    Clock = 0;Reset = 1;Start = 0;
    Data = 8'b00000000;#10;
    Reset = 0;Data = 8'b10110010;Start = 1;#10;
    
    Start = 0;
    #100;

    Data = 8'b11001100;Start = 1;#10;

    Start = 0;#100;
    $finish;

end

endmodule