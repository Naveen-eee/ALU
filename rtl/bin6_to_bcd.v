module bin6_to_bcd(
    input  [5:0] binary,
    output reg [3:0] tens,
    output reg [3:0] ones
);

integer i;
reg [13:0] shift;

always @(*) begin

    // Clear shift register
    shift = 14'd0;

    // Load binary number
    shift[5:0] = binary;

    // Double Dabble Algorithm
    for(i = 0; i < 6; i = i + 1) begin

        // Add-3 step
        if(shift[9:6] >= 5)
            shift[9:6] = shift[9:6] + 3;

        if(shift[13:10] >= 5)
            shift[13:10] = shift[13:10] + 3;

        // Shift left
        shift = shift << 1;

    end

    ones = shift[9:6];
    tens = shift[13:10];

end

endmodule