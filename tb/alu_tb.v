`timescale 1ns/1ps

module alu_tb;

    // Inputs
    reg [7:0] a, b;
    reg [3:0] inp_command;
    reg enb;

    // Outputs
    wire [15:0] data_out;
    wire zero_flag;
    wire carry_flag;

    // Instantiate DUT
    alu DUT (
        .a(a),
        .b(b),
        .inp_command(inp_command),
        .enb(enb),
        .data_out(data_out),
        .zero_flag(zero_flag),
        .carry_flag(carry_flag)
    );

    // Operation Codes
    parameter ADD  = 4'b0000,
              INC  = 4'b0001,
              SUB  = 4'b0010,
              DEC  = 4'b0011,
              MUL  = 4'b0100,
              DIV  = 4'b0101,
              SHL  = 4'b0110,
              SHR  = 4'b0111,
              AND  = 4'b1000,
              OR   = 4'b1001,
              INV  = 4'b1010,
              NAND = 4'b1011,
              NOR  = 4'b1100,
              XOR  = 4'b1101,
              XNOR = 4'b1110,
              BUF  = 4'b1111;

    initial
    begin
        $display("---------------------------------------------------------------");
        $display("Time\tCMD\tA\tB\tResult\tCarry\tZero");
        $display("---------------------------------------------------------------");

        enb = 1;

        // ADD
        a = 8'd25; b = 8'd15; inp_command = ADD; #10;
        $display("%0t\tADD\t%d\t%d\t%d\t%b\t%b",$time,a,b,data_out,carry_flag,zero_flag);

        // ADD Overflow
        a = 8'd250; b = 8'd20; inp_command = ADD; #10;
        $display("%0t\tADD\t%d\t%d\t%d\t%b\t%b",$time,a,b,data_out,carry_flag,zero_flag);

        // INC
        a = 8'd255; b = 0; inp_command = INC; #10;
        $display("%0t\tINC\t%d\t-\t%d\t%b\t%b",$time,a,data_out,carry_flag,zero_flag);

        // SUB
        a = 8'd50; b = 8'd20; inp_command = SUB; #10;
        $display("%0t\tSUB\t%d\t%d\t%d\t%b\t%b",$time,a,b,data_out,carry_flag,zero_flag);

        // SUB Borrow
        a = 8'd20; b = 8'd50; inp_command = SUB; #10;
        $display("%0t\tSUB\t%d\t%d\t%d\t%b\t%b",$time,a,b,data_out,carry_flag,zero_flag);

        // DEC
        a = 8'd0; inp_command = DEC; #10;
        $display("%0t\tDEC\t%d\t-\t%d\t%b\t%b",$time,a,data_out,carry_flag,zero_flag);

        // MUL
        a = 8'd20; b = 8'd15; inp_command = MUL; #10;
        $display("%0t\tMUL\t%d\t%d\t%d\t%b\t%b",$time,a,b,data_out,carry_flag,zero_flag);

        // DIV
        a = 8'd100; b = 8'd4; inp_command = DIV; #10;
        $display("%0t\tDIV\t%d\t%d\t%d\t%b\t%b",$time,a,b,data_out,carry_flag,zero_flag);

        // DIV by Zero
        a = 8'd100; b = 8'd0; inp_command = DIV; #10;
        $display("%0t\tDIV\t%d\t%d\t%d\t%b\t%b",$time,a,b,data_out,carry_flag,zero_flag);

        // SHL
        a = 8'b10010011; inp_command = SHL; #10;
        $display("%0t\tSHL\t%b\t-\t%b\t%b\t%b",$time,a,data_out,carry_flag,zero_flag);

        // SHR
        a = 8'b10010011; inp_command = SHR; #10;
        $display("%0t\tSHR\t%b\t-\t%b\t%b\t%b",$time,a,data_out,carry_flag,zero_flag);

        // AND
        a = 8'hAA; b = 8'h55; inp_command = AND; #10;
        $display("%0t\tAND\t%h\t%h\t%h\t%b\t%b",$time,a,b,data_out,carry_flag,zero_flag);

        // OR
        a = 8'hAA; b = 8'h55; inp_command = OR; #10;
        $display("%0t\tOR\t%h\t%h\t%h\t%b\t%b",$time,a,b,data_out,carry_flag,zero_flag);

        // INV
        a = 8'h0F; inp_command = INV; #10;
        $display("%0t\tINV\t%h\t-\t%h\t%b\t%b",$time,a,data_out,carry_flag,zero_flag);

        // NAND
        a = 8'hF0; b = 8'h0F; inp_command = NAND; #10;
        $display("%0t\tNAND\t%h\t%h\t%h\t%b\t%b",$time,a,b,data_out,carry_flag,zero_flag);

        // NOR
        a = 8'hF0; b = 8'h0F; inp_command = NOR; #10;
        $display("%0t\tNOR\t%h\t%h\t%h\t%b\t%b",$time,a,b,data_out,carry_flag,zero_flag);

        // XOR
        a = 8'hAA; b = 8'h55; inp_command = XOR; #10;
        $display("%0t\tXOR\t%h\t%h\t%h\t%b\t%b",$time,a,b,data_out,carry_flag,zero_flag);

        // XNOR
        a = 8'hAA; b = 8'h55; inp_command = XNOR; #10;
        $display("%0t\tXNOR\t%h\t%h\t%h\t%b\t%b",$time,a,b,data_out,carry_flag,zero_flag);

        // BUF
        a = 8'h3C; inp_command = BUF; #10;
        $display("%0t\tBUF\t%h\t-\t%h\t%b\t%b",$time,a,data_out,carry_flag,zero_flag);

        // Output Disable
        enb = 0;
        a = 8'd10; b = 8'd5; inp_command = ADD; #10;
        $display("%0t\tEN=0\t%d\t%d\t%h",$time,a,b,data_out);

        $display("---------------------------------------------------------------");
        $finish;
    end

endmodule