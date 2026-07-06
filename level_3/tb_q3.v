module tb_q3;
reg [3:0] in;
wire [1:0] out;
wire [1:0] valid;

q3 uut(.in(in),.out(out),.valid(valid));

initial begin
    $dumpfile("q3.vcd");
    $dumpvars(0,tb_q3);
    $monitor("in=%b,out=%b,valid=%b",in,out,valid );

    in=4'b0000;#10;
    in=4'b0001;#10;
    in=4'b0010;#10;
    in=4'b0100;#10;
    in=4'b1000;#10;
    in=4'b0011;#10;
    $finish;
end
endmodule