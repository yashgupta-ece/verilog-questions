module tb_q35;

reg Clock;
reg Load;
reg [3:0] D;
wire Serialout;
wire [3:0] Register;

q35 uut(.Clock(Clock),.Load(Load),.D(D),.Serialout(Serialout));

initial begin
    $dumpfile("q35.vcd");
    $dumpvars(0,tb_q35);
    $monitor("Clock=%b,Load=%b,SerialOut=%b",Clock,Load,Serialout);

    Clock=0;
    Load=1;D=4'b1011;#10;
    Load=0;#10;
    Load=0;#10
    Load=1;#5;
    Load=0;#10;
    #100;
    $finish;
end
always #5 Clock=~Clock;
endmodule