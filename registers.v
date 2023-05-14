module reg_a(
  input clk, rst_b, c0, c3, c6, s,
  input [7:0] inbus,
  input [8:0] adder_input,
  output reg [8:0] out,
  output reg [16:0]outbus,
);

  always @(posedge clk, negedge rst_b)
    if(!rst_b)  out <= 0;
    else if(c0) out <= inbus;
    else if(c3) out <= adder_input;
    else if(c6) out <= {out[8], out[8], out[8:2]};
      
  always @(*)
    outbus = (c8) ? out : 9'bz;
endmodule

module reg_q(
  input clk, rst_b, c0, c1, c5, c6, s
  input [7:0] inbus, 
  output reg [7:0]out, outbus
);

  always @(posedge clk, negedge rst_b)
    if(!rst_b)  out <= 0;
    else if(c1) out <= {inbus[7:1], 1'b0};
    else if(c5) out <= {out[7:1], ~s};
    else if(c6) out <= {out[7:1], 1'b0};
      
  always @(*)
    outbus = (c7) ? out : 9'bz;
endmodule


module m (
    input clk, rst_b, c2,
    input [7:0] in,
    output reg [7:0] out
);
    always @(posedge clk, negedge rst_b)
        if(!rst_b)  out <= 0;
        else if(c2) out <= in;
endmodule