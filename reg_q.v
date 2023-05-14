module reg_q(
  input clk, rst_b, c1, c5, c6, c7, s
  input [7:0] inbus, 
  output reg [7:0]out, outbus
);

  always @(posedge clk, negedge rst_b)
    if(!rst_b)  out <= 0;
    else if(c1) out <= {inbus[7:1], 1'b0};
    else if(c5) out <= {out[7:1], ~s};
    else if(c6) out <= {out[6:0], 1'b0};
      
  always @(*)
    outbus = (c7) ? out : 8'bz;
    
endmodule