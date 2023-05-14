module reg_a(
  input clk, rst_b, c0, c3, c8, q7,
  input [7:0] inbus,
  input [7:0] adder_input,
  output reg [7:0]out, outbus
);

  always @(posedge clk, negedge rst_b)
    if(!rst_b)  out <= 0;
    else if(c0) out <= inbus;
    else if(c3) out <= adder_input;
    else if(c6) out <= {out[6:0], q7};
      
  always @(*)
    outbus = (c8) ? out : 8'bz;
    
endmodule
