module tb_q4;
reg [3:0] bcd;
wire [6:0] seg;

q4 uut(.bcd(bcd),.seg(seg));

initial begin
    $dumpfile("q4.vcd");
    $dumpvars(0,tb_q4);
    $monitor("bcd=%b,seg=%b",bcd,seg);

    bcd=4'b0000;#10;
    bcd=4'b0001;#10;
    bcd=4'b0010;#10;
    bcd=4'b0011;#10;
    bcd=4'b0100;#10;
    bcd=4'b0101;#10;
    bcd=4'b0110;#10;
    bcd=4'b0111;#10;
    bcd=4'b1000;#10;
    bcd=4'b1001;#10;
    bcd=4'b1010;#10;
    $finish;
end

endmodule