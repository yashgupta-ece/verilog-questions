module q1_tb;
reg [3:0] a;
wire [3:0] y;

q1 uut(.a(a),.y(y));

initial begin
    a = 4'b0000;
    #10;
    $display("a = %b, y = %b", a, y);
    $finish;
end

endmodule