# 8-bit Arithmetic Logic Unit (ALU) using Verilog HDL on Spartan-7 FPGA

An FPGA implementation of an **8-bit Arithmetic Logic Unit (ALU)** designed using **Verilog HDL** and implemented on the **Real Digital Boolean Board (Spartan-7 FPGA)** using **Xilinx Vivado**.

> ⚠️ Note:
> The ALU is designed as an **8-bit architecture**. Due to the limited number of switches available on the FPGA board, **6-bit operands** were used during hardware implementation. The complete **8-bit functionality** was verified through simulation using a Verilog testbench.

---

## 📌 Features

- 8-bit ALU Architecture
- 4-bit Opcode Controlled Operation Selection
- Supports 16 Arithmetic & Logical Operations
- Verilog HDL RTL Design
- Verilog Testbench for Functional Verification
- Binary-to-BCD Conversion
- Dual Seven-Segment Display Interface
- Clock Divider for Display Multiplexing
- Zero Flag and Carry Flag Outputs
- Implemented on Spartan-7 FPGA

---

## 🔧 Supported Operations

| Opcode | Operation |
|---------|-----------|
|0000|ADD|
|0001|INC|
|0010|SUB|
|0011|DEC|
|0100|MUL|
|0101|DIV|
|0110|SHL|
|0111|SHR|
|1000|AND|
|1001|OR|
|1010|INV|
|1011|NAND|
|1100|NOR|
|1101|XOR|
|1110|XNOR|
|1111|BUF|

---

## 🛠 Hardware Used

- Real Digital Boolean Board
- Xilinx Spartan-7 FPGA
- Seven Segment Displays
- Onboard LEDs
- Onboard Switches
- Push Buttons

---

## 💻 Software Used

- Xilinx Vivado
- Verilog HDL

---

## 📂 Project Structure

```
├── rtl/
│   ├── alu.v
│   ├── top.v
│   ├── bin6_to_bcd.v
│   ├── bin12_to_bcd.v
│   ├── bcd_to_7seg.v
│   ├── sevenseg_controller.v
│   └── clock_divider.v
│
├── tb/
│   └── alu_tb.v
│
├── constraints/
│   └── top.xdc
│
├── images/
│   ├── waveform.png
│   ├── add.jpg
│   ├── increment.jpg
│   ├── subtraction.jpg
│   └── buffer.jpg
│
└── README.md
```

---

## 📸 Results

### Simulation
- Functional verification performed using a Verilog Testbench.

### FPGA Hardware Output
- ADD Operation
- Increment Operation
- Subtraction Operation
- Buffer Operation

The binary ALU output is converted into decimal using a Binary-to-BCD converter and displayed on the onboard seven-segment displays.

---

## 📖 Working Principle

1. Two 8-bit operands are applied to the ALU.
2. A 4-bit opcode selects one of the sixteen operations.
3. The ALU computes the result.
4. Zero and Carry flags are generated.
5. Binary output is converted to BCD.
6. Decimal values are displayed on dual seven-segment displays.
7. A clock divider multiplexes the displays for stable visualization.

---

## 📈 Verification

✔ RTL Simulation

✔ Functional Testbench

✔ FPGA Hardware Validation

✔ Seven Segment Display Verification

✔ Flag Verification

---

## 🎯 Learning Outcomes

- Verilog HDL
- RTL Design
- FPGA Implementation
- Digital Logic Design
- Combinational Circuit Design
- Hardware Verification
- Binary-to-BCD Conversion
- Seven Segment Display Interfacing
- Vivado Design Flow

---


## 📜 License

This project is intended for educational and learning purposes.

---

## 👨‍💻 Author

**Naveen A**

B.E. Electrical and Electronics Engineering

Interested in FPGA | RTL Design | VLSI | Embedded Systems

- **Language:** Verilog HDL
- **Simulator:** Vivado
- **FPGA Design Tool:** Vivado
