module tb_q6;
reg [3:0] in1;
reg [3:0] in2;
reg [1:0] operator_code;
wire [3:0] out;

q6 uut(.in1(in1),.in2(in2),.operator_code(operator_code),.out(out));

initial begin
    $dumpfile("q6.vcd");
    $dumpvars(0,tb_q6);
    $monitor("a=%b,b=%b,operator code=%b,output=%b",in1,in2,operator_code,out);
    operator_code=2'b00;in1=4'b1000;in2=4'b0011;#10;
    operator_code=2'b01;in1=4'b1000;in2=4'b0011;#10;
    operator_code=2'b10;in1=4'b1000;in2=4'b0011;#10;
    operator_code=2'b11;in1=4'b1000;in2=4'b0011;#10;
    operator_code=2'b00;in1=4'b1010;in2=4'b0010;#10;
    operator_code=2'b01;in1=4'b1100;in2=4'b0111;#10;
    operator_code=2'b10;in1=4'b1010;in2=4'b0011;#10;
    operator_code=2'b11;in1=4'b1001;in2=4'b0111;#10;
    end
endmodule