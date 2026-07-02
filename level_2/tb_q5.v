module tb_q5;
reg [3:0] in1;
reg [3:0] in2;
wire [3:0] out_and;
wire [3:0] out_or;
wire [3:0] out_xor;

q5 uut(.in1(in1),.in2(in2),.out_and(out_and),.out_or(out_or),.out_xor(out_xor));

initial begin
    $monitor("in1=%b,in2=%b,out_and=%b,out_or=%b,out_xor=%b",in1,in2,out_and,out_or,out_xor);
    in1=4'b1010;in2=4'b1011; #10;
    in1=4'b1000;in2=4'b0001; #10;
end
endmodule