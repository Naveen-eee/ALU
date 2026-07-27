module top(

    input mclk,

    input [15:0] sw,
    input [3:0] btn,

    output [15:0] led,

    output [3:0] D0_a,
    output [7:0] D0_seg,

    output [3:0] D1_a,
    output [7:0] D1_seg

);
//-----------------------------------------------------
// Internal Signals
//-----------------------------------------------------

wire [11:0] alu_out;
wire zero_flag;
wire carry_flag;

wire scan_clk;

// A -> BCD
wire [3:0] A_tens;
wire [3:0] A_ones;

// B -> BCD
wire [3:0] B_tens;
wire [3:0] B_ones;

// Result -> BCD
wire [3:0] res_thousands;
wire [3:0] res_hundreds;
wire [3:0] res_tens;
wire [3:0] res_ones;

//-----------------------------------------------------
// ALU
//-----------------------------------------------------

alu U_ALU (

    .a(sw[5:0]),
    .b(sw[11:6]),
    .inp_command(sw[15:12]),
    .enb(1'b1),

    .data_out(alu_out),
    .zero_flag(zero_flag),
    .carry_flag(carry_flag)

);

//-----------------------------------------------------
// Clock Divider
//-----------------------------------------------------

clock_divider U_CLK (

    .clk(mclk),
    .rst(btn[0]),
    .scan_clk(scan_clk)

);

//-----------------------------------------------------
// Convert A to BCD
//-----------------------------------------------------

bin6_to_bcd U_A (

    .binary(sw[5:0]),
    .tens(A_tens),
    .ones(A_ones)

);

//-----------------------------------------------------
// Convert B to BCD
//-----------------------------------------------------

bin6_to_bcd U_B (

    .binary(sw[11:6]),
    .tens(B_tens),
    .ones(B_ones)

);

//-----------------------------------------------------
// Convert Result to BCD
//-----------------------------------------------------

bin12_to_bcd U_RES (

    .binary(alu_out),

    .thousands(res_thousands),
    .hundreds(res_hundreds),
    .tens(res_tens),
    .ones(res_ones)

);

//-----------------------------------------------------
// Display 0
// Digit3 = A Tens
// Digit2 = A Ones
// Digit1 = B Tens
// Digit0 = B Ones
//-----------------------------------------------------

sevenseg_controller DISP0(

    .scan_clk(scan_clk),
    .rst(btn[0]),

    .digit3(A_tens),
    .digit2(A_ones),
    .digit1(B_tens),
    .digit0(B_ones),

    .an(D0_a),
    .seg(D0_seg)

);

//-----------------------------------------------------
// Display 1
// Digit3 = Thousands
// Digit2 = Hundreds
// Digit1 = Tens
// Digit0 = Ones
//-----------------------------------------------------

sevenseg_controller DISP1(

    .scan_clk(scan_clk),
    .rst(btn[0]),

    .digit3(res_thousands),
    .digit2(res_hundreds),
    .digit1(res_tens),
    .digit0(res_ones),

    .an(D1_a),
    .seg(D1_seg)

);
//-----------------------------------------------------
// LEDs
//-----------------------------------------------------
assign led[0] = zero_flag;
assign led[1] = carry_flag;
assign led[15:2] = 14'd0;
endmodule