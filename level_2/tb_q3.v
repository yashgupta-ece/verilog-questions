module tb_q3;
reg [7:0] in;
wire [7:0] out;

q3 uut(.in(in),.out(out));

initial begin
    $monitor("in=%b,out=%b",in,out);

    in=8'b01010110; #10;
    in=8'b00001111; #10;
    in=8'b10101010; #10;
    in=8'b11110000; #10;
    $finish;
end

endmodule