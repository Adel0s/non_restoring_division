module nonRD(
    input clk, rst_b, 
    input [8:0] inbus,
    output [8:0] outbus
);
    wire[7:0] reg_a, reg_m, reg_q;
    wire[8:0] adder_output;
    wire[2:0] cnt;
    wire reg_s;
    wire c0, c1, c2, c3, c4, c5, c6, c7, c8;

    control_unit inst7(.clk(clk),
                    .rst_b(rst_b),
                    .is_count_7(cnt == 3'b111),
                    .c0(c0),
                    .c1(c1),
                    .c2(c2),
                    .c3(c3),
                    .c4(c4),
                    .c5(c5),
                    .c6(c6),
                    .c7(c7),
                    .c8(c8));

    reg_m inst0(.clk(clk),
            .rst_b(rst_b),
            .c2(c2),
            .inbus(inbus),
            .out(reg_m));

    reg_q inst1(.clk(clk),
            .rst_b(rst_b),
            .c1(c1),
            .c5(c5),
            .c6(c6),
            .c7(c7),
            .s(~s),
            .inbus(inbus[7:0]),
            .out(reg_q),
            .outbus(outbus));

    reg_a inst2(.clk(clk),
            .rst_b(rst_b),
            .c0(c0),
            .c3(c3),
            .c8(c8),
            .q7(reg_q[7]),
            .adder_input(adder_output),
            .out(reg_a),
            .outbus(outbus));

    reg_s inst3(.clk(clk),
                .rst_b(rst_b),
                .adder_input(adder_output[8])
                .a7(reg_a[7]),
                .c0(c0),
                .c3(c3),
                .c6(c6));

    counter inst4(.clk(clk),
                .rst_b(rst_b),
                .c0(c0),
                .c6(c6),
                .out(cnt));

    parallel_adder inst6(.cin(c4),
                         .a({reg_s, reg_a}),
                         .b({reg_m[7], reg_m} ^ {9{c4}}),
                         .out_add(adder_output));

endmodule

module nonRD_tb;
    reg clk, rst_b;
    reg [8:0] inbus;
    wire [8:0] outbus;

    boothr4 inst(.clk(clk),
                 .rst_b(rst_b),
                 .inbus(inbus),
                 .outbus(outbus));
                     
    localparam CLOCK_CYCLES = 160, CLOCK_PERIOD = 100;
    localparam RST_PULSE = 25, NUMBER_SETS = 10;

    initial begin 
        clk = 0;
        repeat(CLOCK_CYCLES * 2)
            #(CLOCK_PERIOD / 2) clk = ~clk;
    end

    initial begin 
        rst_b = 0; bgn = 1;
        #(RST_PULSE) rst_b = 1;
    end

    initial begin 
        repeat(NUMBER_SETS) begin
            inbus = $urandom(); //8'b00111000;
            #(200)
            inbus = $urandom(); // 8'b10101101;
            #(200)
            inbus = 8'bz;
            #(1200) inbus = 8'bz;
        end
    end
endmodule 