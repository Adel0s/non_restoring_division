module parallel_adder (
    input cin,
    input [8:0]a, b,
    output [8:0]out_add
);
    wire w0, w1, w2, w3, w4, w5, w6, w7;
    wire [8:0]out;

    fac fac0(.a(a[0]), .b(b[0]), .cin(cin), .out(out[0]), .cout(w0));
    fac fac1(.a(a[1]), .b(b[1]), .cin(w0), .out(out[1]), .cout(w1));
    fac fac2(.a(a[2]), .b(b[2]), .cin(w1), .out(out[2]), .cout(w2));
    fac fac3(.a(a[3]), .b(b[3]), .cin(w2), .out(out[3]), .cout(w3));
    fac fac4(.a(a[4]), .b(b[4]), .cin(w3), .out(out[4]), .cout(w4));
    fac fac5(.a(a[5]), .b(b[5]), .cin(w4), .out(out[5]), .cout(w5));
    fac fac6(.a(a[6]), .b(b[6]), .cin(w5), .out(out[6]), .cout(w6));
    fac fac7(.a(a[7]), .b(b[7]), .cin(w6), .out(out[7]), .cout(w7));
    fac fac8(.a(a[8]), .b(b[8]), .cin(w7), .out(out[8]), .cout());
    
    assign out_add = out;
endmodule


