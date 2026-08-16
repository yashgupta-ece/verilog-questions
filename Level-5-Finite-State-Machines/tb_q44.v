module tb_q44;
reg Clock;
reg Reset;
reg Entry;
reg Exit;
reg Emergency;
wire Empty_Out;
wire Occupied_Out;
wire Full_Out;
wire Emergency_Out;

wire [2:0] Status;
assign Status = {Full_Out, Occupied_Out, Empty_Out};

Q44 dut(.Clock(Clock),.Reset(Reset),.Entry(Entry),.Exit(Exit),.Emergency(Emergency),.Empty_Out(Empty_Out),.Occupied_Out(Occupied_Out),.Full_Out(Full_Out),.Emergency_Out(Emergency_Out));

always #5 Clock=~Clock;

initial begin
    $dumpfile("q44.vcd");
    $dumpvars(0,tb_q44);
    $monitor("Clock=%b,Reset=%b,Entry=%b,Exit=%b,Emergency=%b,Status=%b,Emergency_out=%b",Clock,Reset,Entry,Exit,Emergency,Status,Emergency_Out);
    Clock=0;Reset=1;Entry=0;Exit=0;Emergency=0;#10;
    Reset=0;Entry=1;Exit=0;Emergency=0;#10;
    Reset=0;Entry=1;Exit=0;Emergency=0;#10;
    Reset=0;Entry=0;Exit=1;Emergency=0;#10;
    Reset=0;Entry=0;Exit=1;Emergency=0;#10;
    Reset=0;Entry=0;Exit=0;Emergency=1;#10;
    Reset=0;Entry=0;Exit=0;Emergency=1;#10;
    Reset=0;Entry=1;Exit=0;Emergency=1;#10;
    $finish;
end
endmodule