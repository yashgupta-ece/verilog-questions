module q27 (
    input wire clk,d,reset,output reg q
);
    always @(posedge clk) begin
        if(reset==1)
          q<=0;
        else
         q<=d;
    end
endmodule