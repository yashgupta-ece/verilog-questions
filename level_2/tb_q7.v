module tb_q7;
reg [3:0] in ;
wire [15:0] out ;

q7 uut(.in(in),.out(out));

initial begin
    $monitor("in=%b,out=%b",in,out);
    in= 4'b1010; #10;
    in= 4'b0101; #10;
    $finish;
end

endmodule