module tb_q41;

    reg Clock;
    reg Reset;
    reg Serial_In;

    wire [7:0] Parallel_Out;
    wire Data_Ready;

    q41 uut(
        .Clock(Clock),
        .Reset(Reset),
        .Serial_In(Serial_In),
        .Parallel_Out(Parallel_Out),
        .Data_Ready(Data_Ready)
    );

    // Clock Generation
    always #5 Clock = ~Clock;

    initial begin

        $dumpfile("q41.vcd");
        $dumpvars(0, tb_q41);

        $monitor("Time=%0t Clock=%b Reset=%b Serial_In=%b Counter=%d Shift_Register=%b Parallel_Out=%b Data_Ready=%b",
        $time, Clock, Reset, Serial_In,
        uut.Counter, uut.Shift_Register,
        Parallel_Out, Data_Ready);

        // ------------------------
        // Test Case 1 : Reset
        // ------------------------
        Clock = 0;
        Reset = 1;
        Serial_In = 0;
        #10;

        Reset = 0;

        // ------------------------
        // Test Case 2 : Receive Byte
        // Byte = 10110010
        // ------------------------
        Serial_In = 1; #10;
        Serial_In = 0; #10;
        Serial_In = 1; #10;
        Serial_In = 1; #10;
        Serial_In = 0; #10;
        Serial_In = 0; #10;
        Serial_In = 1; #10;
        Serial_In = 0; #10;

        // ------------------------
        // Test Case 3 : Idle
        // ------------------------
        Serial_In = 0;
        #20;

        // ------------------------
        // Test Case 4 : Second Byte
        // Byte = 11001100
        // ------------------------
        Serial_In = 1; #10;
        Serial_In = 1; #10;
        Serial_In = 0; #10;
        Serial_In = 0; #10;
        Serial_In = 1; #10;
        Serial_In = 1; #10;
        Serial_In = 0; #10;
        Serial_In = 0; #10;

        // ------------------------
        // Test Case 5 : Reset Again
        // ------------------------
        Reset = 1;
        #10;

        Reset = 0;
        #20;

        $finish;

    end

endmodule