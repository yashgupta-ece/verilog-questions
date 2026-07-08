module tb_q5;
reg [1:0] in1;
reg [1:0] in2;
wire greater,less,equal;

q5 uut(.in1(in1),.in2(in2),.greater(greater),.less(less),.equal(equal));

initial begin
    $dumpfile("q5.vcd");
    $dumpvars(0,tb_q5);
    $monitor("a=%b,b=%b,greater=%b,equal=%b,less=%b",in1,in2,greater,equal,less);

    in1=2'b00; in2=2'b00; #10;
    in1=2'b01; in2=2'b01; #10;
    in1=2'b10; in2=2'b10; #10;
    in1=2'b11; in2=2'b11; #10;
    in1=2'b01; in2=2'b00; #10;
    in1=2'b10; in2=2'b01; #10;
    in1=2'b11; in2=2'b10; #10;
    in1=2'b00; in2=2'b01; #10;
    in1=2'b01; in2=2'b10; #10;
    in1=2'b10; in2=2'b11; #10;

    $finish;
end
endmodule