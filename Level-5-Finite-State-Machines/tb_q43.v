module tb_q43;
reg Reset;
reg Clock;
reg Emergency;
wire Light0, Light1, Light2, Light3, Emergency_Out;
wire [3:0] Lights;
assign Lights = {Light3, Light2, Light1, Light0};

q43 dut(.Reset(Reset),.Clock(Clock),.Emergency(Emergency),.Light0(Light0),.Light1(Light1),.Light2(Light2),.Light3(Light3),.Emergency_Out(Emergency_Out));

always #5 Clock=~Clock;


initial begin
    $dumpfile("q43.vcd");
    $dumpvars(0,tb_q43);

    $monitor("Clock=%b Reset=%b Emergency=%b Lights=%b Emergency_Out=%b",Clock, Reset, Emergency,Lights,Emergency_Out);
    Clock=0;
    Reset=1;Emergency=0;#10;
    Reset=0;Emergency=0;#10;
    Reset=0;Emergency=1;#10;
    Reset=1;Emergency=1;#10;
    Reset=0;Emergency=0;#10;
    Reset=0;Emergency=0;#10;
    Reset=0;Emergency=0;#10;
    Reset=0;Emergency=1;#10;
    Reset=0;Emergency=0;#10;
    $finish;
end
endmodule