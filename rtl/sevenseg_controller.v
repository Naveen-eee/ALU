module sevenseg_controller(

    input scan_clk,
    input rst,

    input [3:0] digit3,
    input [3:0] digit2,
    input [3:0] digit1,
    input [3:0] digit0,

    output reg [3:0] an,
    output reg [7:0] seg

);

reg [1:0] scan_sel;
reg [3:0] current_digit;
wire [6:0] seg7;

//-----------------------------------------
// Scan Counter
//-----------------------------------------

always @(posedge scan_clk or posedge rst)
begin
    if(rst)
        scan_sel <= 2'b00;
    else
        scan_sel <= scan_sel + 1'b1;
end

//-----------------------------------------
// Select Active Digit
//-----------------------------------------

always @(*)
begin

    case(scan_sel)

        2'b00:
        begin
            an = 4'b1110;          // Digit 0 ON
            current_digit = digit0;
        end

        2'b01:
        begin
            an = 4'b1101;          // Digit 1 ON
            current_digit = digit1;
        end

        2'b10:
        begin
            an = 4'b1011;          // Digit 2 ON
            current_digit = digit2;
        end

        2'b11:
        begin
            an = 4'b0111;          // Digit 3 ON
            current_digit = digit3;
        end

        default:
        begin
            an = 4'b1111;
            current_digit = 4'd0;
        end

    endcase

end

//-----------------------------------------
// BCD to 7-Segment Decoder
//-----------------------------------------

bcd_to_7seg decoder(
    .bcd(current_digit),
    .seg(seg7)
);

//-----------------------------------------
// Segment Output
//-----------------------------------------

always @(*)
begin
    seg[6:0] = seg7;
    seg[7]   = 1'b1;      // Decimal Point OFF (active low)
end

endmodule