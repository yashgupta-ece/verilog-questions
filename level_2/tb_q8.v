module tb_q8;
reg [7:0] in;
wire [3:0] lower;
wire [3:0] upper;
wire [7:0] out;

q8 uut(.in(in),.out(out));

initial begin
    $monitor("in=%b,swap=%b",in,out);
    in=8'b10101111; #10;
    in=8'b00001111; #10;
    $finish;
end
endmodule