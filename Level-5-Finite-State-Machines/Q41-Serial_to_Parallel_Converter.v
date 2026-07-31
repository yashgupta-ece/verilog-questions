module q41 (
   input wire Clock, Reset, Serial_In, output reg [7:0] Parallel_Out,output reg Data_Ready
);
    reg [7:0] Shift_Register;
    reg [3:0] Counter;

    always @(posedge Clock or posedge Reset) begin
        if (Reset) begin
            Counter<= 0;
            Shift_Register <= 0;
            Parallel_Out   <= 0;
            Data_Ready     <= 0;
        end 
        else begin
            Shift_Register <= {Shift_Register[6:0], Serial_In};
            Counter <= Counter + 1;
            Data_Ready=1'b0;
            if (Counter==7) begin
                Parallel_Out <= {Shift_Register[6:0], Serial_In};
                Data_Ready <= 1'b1;
                Counter<=0;
            end
        end
    end
endmodule