module q1 (
    input wire a,b,sel,output reg out
);
    always @(*) begin
        if (sel==1'b1)
            out=a;
        else 
           out= b;
    end
endmodule