module tb_q29;
reg [3:0] D;
reg clock;
wire [3:0] Q;

q29 uut(.D(D),.clock(clock),.Q(Q));

initial begin
    $dumpfile("q29.vcd");
    $dumpvars(0,tb_q29);
    $monitor("D=%b,clock=%b,Q=%b",D,clock,Q);

    clock=0;
    D=4'b1010;#10;
    D=4'b1100;#2;
    D=4'b1100;#4;
    D=4'b0011;#5;
    $finish;
end
always #5 clock=~clock;
endmodule