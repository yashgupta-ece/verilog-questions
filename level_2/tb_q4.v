module tb_q4;

reg [3:0] in1 ;
reg [3:0] in2;
wire [7:0] out;

q4 uut(.in1(in1),.in2(in2),.out(out));

initial begin
    $monitor("in1=%b,in2=%b,out=%b",in1,in2,out);
    in1=4'b1010;in2=4'b1110; #10;
    in1=4'b1111;in2=4'b0000; #10;
end
endmodule