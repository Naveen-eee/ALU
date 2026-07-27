module bin12_to_bcd(
    input  [11:0] binary,
    output reg [3:0] thousands,
    output reg [3:0] hundreds,
    output reg [3:0] tens,
    output reg [3:0] ones
);

integer i;
reg [27:0] shift;

always @(*) begin

    // Initialize shift register
    shift = 28'd0;

    // Load binary input
    shift[11:0] = binary;

    // Double Dabble Algorithm
    for(i = 0; i < 12; i = i + 1) begin

        if(shift[15:12] >= 5)
            shift[15:12] = shift[15:12] + 3;

        if(shift[19:16] >= 5)
            shift[19:16] = shift[19:16] + 3;

        if(shift[23:20] >= 5)
            shift[23:20] = shift[23:20] + 3;

        if(shift[27:24] >= 5)
            shift[27:24] = shift[27:24] + 3;

        shift = shift << 1;

    end

    ones      = shift[15:12];
    tens      = shift[19:16];
    hundreds  = shift[23:20];
    thousands = shift[27:24];

end

endmodule