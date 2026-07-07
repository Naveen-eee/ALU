# ALU

# 8-bit ALU in Verilog

An 8-bit Arithmetic Logic Unit (ALU) implemented in Verilog with 16 different operations, including arithmetic, logical, and shift operations.

## Features
- Supports **16 operations** (arithmetic, logical, shift, and special functions)
- 8-bit inputs with 16-bit output (handles multiplication results)
- Tri-state output controlled by enable (`enb`) signal
- Division-by-zero protection
- Clean, synthesizable RTL code

## Supported Operations

| Command (inp_command) | Operation | Description                  |
|-----------------------|-----------|------------------------------|
| 4'b0000               | ADD       | a + b                        |
| 4'b0001               | INC       | a + 1                        |
| 4'b0010               | SUB       | a - b                        |
| 4'b0011               | DEC       | a - 1                        |
| 4'b0100               | MUL       | a * b                        |
| 4'b0101               | DIV       | a / b (safe division)        |
| 4'b0110               | SHL       | a << 1                       |
| 4'b0111               | SHR       | a >> 1                       |
| 4'b1000               | AND       | a & b                        |
| 4'b1001               | OR        | a \| b                       |
| 4'b1010               | INV       | ~a                           |
| 4'b1011               | NAND      | ~(a & b)                     |
| 4'b1100               | NOR       | ~(a \| b)                    |
| 4'b1101               | XOR       | a ^ b                        |
| 4'b1110               | XNOR      | a ~^ b                       |
| 4'b1111               | BUF       | a (Buffer / Pass-through)    |

## Module Interface

```verilog
module alu (
    input  [7:0]  a,
    input  [7:0]  b,
    input  [3:0]  inp_command,
    input         enb,
    output [15:0] data_out
);
