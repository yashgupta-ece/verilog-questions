module tb_q2;
reg [3:0] a;
wire [1:0] lower;
wire [1:0] upper;

q2 uut(.a(a),.lower(lower),.upper(upper));

initial begin
     a = 4'b0000; #10;
    $display("a=%b upper=%b lower=%b", a, upper, lower);

    a = 4'b1010; #10;
    $display("a=%b upper=%b lower=%b", a, upper, lower);

    a = 4'b1101; #10;
    $display("a=%b upper=%b lower=%b", a, upper, lower);

    a = 4'b0111; #10;
    $display("a=%b upper=%b lower=%b", a, upper, lower);

    $finish;
end

endmodule
