module alu (
    input [7:0] a,b, // 8 bit operands
    input [3:0] inp_command, // operation select input
    input enb, // output enable signal
    output [15:0] data_out,  //16 bit alu output
    output zero_flag,  // High when ALU output is zero
    output carry_flag  // carry/borrow flag
);

//Operations

parameter ADD  = 4'b0000, //Addition: a+b
          INC  = 4'b0001, //Increment: a+1
          SUB  = 4'b0010, //Subtraction: a-b(unsigned)
          DEC  = 4'b0011, //Decrement: a-1
          MUL  = 4'b0100, //Multiplication: a*b
          DIV  = 4'b0101, //Division: a/b
          SHL  = 4'b0110, //Shift Left a<<1
          SHR  = 4'b0111, //Shift Right a>>1
          AND  = 4'b1000, //Bitwise AND
          OR   = 4'b1001, //Bitwise OR
          INV  = 4'b1010, //Bitwise NOT
          NAND = 4'b1011, //Bitwise NAND
          NOR  = 4'b1100, //Bitwise NOR
          XOR  = 4'b1101, //Bitwise XOR
          XNOR = 4'b1110, //Bitwise XNOR
          BUF  = 4'b1111; // Buffer(pass-through a)

    reg [15:0] out; //Internal register
    reg carry;  //Internal register

    always @(*) begin
        carry = 1'b0;  // Default: no carry
        out = 16'b0;  //Default : zero output
        
        case(inp_command)
            ADD  : begin
                out = a + b;
                carry = (a + b) > 255 ? 1'b1 : 1'b0;  // Carry if result > 8-bit
            end
            INC  : begin
                out = a + 8'd1;
                carry = (a + 8'd1) > 255 ? 1'b1 : 1'b0; // Carry if result > 8-bit
            end
            SUB  : begin
                out = a - b;
                carry = (a < b) ? 1'b1 : 1'b0;  // Borrow flag (carry for subtraction) , UNSIGNED
            end
            DEC  : begin
                out = a - 8'd1;
                carry = (a < 8'd1) ? 1'b1 : 1'b0;  //Carry/Borrow occurs when decrementing 0
            end
            MUL  : begin
                out = a * b;
                carry = (a * b) > 255 ? 1'b1 : 1'b0;
            end
            DIV  : begin
                out = (b != 0) ? a / b : 16'd0; //Return 0 if divisor is zero
                carry = 1'b0;  
            end
            SHL  : begin
                out = a << 1;
                carry = a[7];  // MSB becomes carry
            end
            SHR  : begin
                out = a >> 1;
                carry = a[0];  // LSB becomes carry
            end
            AND  : out = a & b;
            OR   : out = a | b;
            INV  : out = ~a;
            NAND : out = ~(a & b);
            NOR  : out = ~(a | b);
            XOR  : out = a ^ b;
            XNOR : out = a ~^ b;
            BUF  : out = a;  // Pass input A directly to the output
            default : out = 16'd0;
        endcase
    end

    // Zero flag: Set to 1 if output is 0
    assign zero_flag = (out == 16'd0) ? 1'b1 : 1'b0;
    
    // Carry flag output
    assign carry_flag = carry;
    
   // Drive output when enabled; otherwise place bus in high-impedance state
    assign data_out = enb ? out : 16'hzzzz;

endmodule