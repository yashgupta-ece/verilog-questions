module tb_q36;

    reg Toggle;
    reg Clock;
    reg Reset;
    wire LED;
    q36 uut (
        .Toggle(Toggle),
        .Clock(Clock),
        .Reset(Reset),
        .LED(LED)
    );
    always #5 Clock = ~Clock;

    initial begin

        $dumpfile("q36.vcd");
        $dumpvars(0, tb_q36);
        Clock = 0;
        Reset = 1;
        Toggle = 0;#10;
        Reset = 0;#10;
        Toggle = 0;#10;
        Toggle = 1;#10;
        Toggle = 0;#10;
        Toggle = 1;#10;
        Toggle = 0;#10;
        Toggle = 1;#20;
        $finish;

    end

    initial begin
        $monitor(
            "Time=%0t | Reset=%b | Toggle=%b | LED=%b",
            $time, Reset, Toggle, LED
        );
    end

endmodule