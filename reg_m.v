module m (
    input clk, rst_b, c2,
    input [7:0] inbus,
    output reg [7:0] out
);
    always @(posedge clk, negedge rst_b)
        if(!rst_b)  out <= 0;
        else if(c2) out <= inbus;
endmodule
