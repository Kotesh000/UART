# UART (Universal Asynchronous Receiver Transmitter) – Verilog HDL

This repository contains a complete **UART communication system** implemented in **Verilog HDL**. The design includes both transmission and reception capabilities using asynchronous serial communication. The project is suitable for FPGA development boards and digital design learning.

---

## 📌 Overview

UART is a widely used serial communication protocol that enables data transfer between devices **without a shared clock**. This project includes:

✔ UART Transmitter (TX)  
✔ UART Receiver (RX)  
✔ Baud Rate Generator  
✔ Configurable baud rates  
✔ Synthesizable RTL design  
✔ Simulation support with testbenches  

---

## 🧩 Features

- Asynchronous full-duplex communication
- Supports multiple baud rates (configurable through inputs)
- Oversampling technique used in the receiver for accurate data sampling
- Start, stop, and data-bit handling included
- Parameter-driven design for flexibility
- Clean modular structure for scalability

---

## 📂 Project Structure

UART/
│
├── src/ # RTL Verilog source files
│ ├── BaudGenR.v # Baud Rate Generator
│ ├── TxUnit.v # Transmitter Module
│ ├── RxUnit.v # Receiver Module
│ ├── UART_Top.v # Integrated UART System
│ └── ...
│
├── sim/ # Testbench files for simulation
│ └── UART_tb.v
│
├── docs/ # Timing diagrams, project documentation
│
├── README.md # Project Description
└── LICENSE # License (MIT or your preferred one)


---

## 🔧 How It Works

### 🔹 Baud Rate Generator
Divides the high-speed system clock into a lower-frequency baud clock used by TX and RX modules.

### 🔹 Transmitter (TX)
- Loads parallel data
- Adds start bit (0) and stop bit (1)
- Shifts out data serially, LSB first

### 🔹 Receiver (RX)
- Detects start bit
- Uses oversampling to find bit center
- Shifts serial data to parallel format
- Detects stop bit & validates frame

---

## ⚙ Configuration Parameters

| Setting | Description | Default |
|--------|-------------|---------|
| Baud Rate | Data transfer speed | 2400 / 4800 / 9600 / 19200 |
| Clock Frequency | Depends on hardware | 100 MHz / 50 MHz etc. |
| Data Bits | # of parallel bits | 8 bits |
| Stop Bit | End of frame | 1 bit |

> Baud values can be updated by modifying counter values in **BaudGenR.v**

---

## 🧪 Simulation & Testing

1. Open your simulator (ModelSim/Vivado Simulator/etc.)
2. Compile all sources under `src/`
3. Run `UART_tb.v` from the `sim/` folder
4. Observe waveform for:
   - TX waveform showing Start/Data/Stop bits
   - RX correctly reconstructing TX data
   - Proper baud timing

---

## 🔌 Hardware Usage

To test on FPGA/SoC board:
- Connect UART TX pin to USB-to-TTL adapter
- Open a serial terminal (PuTTY/TeraTerm) at the configured baud rate
- Send a character → observe it loop back or show on LEDs/debug signals

---

## 📚 Learning Outcomes

By working with this project you will understand:

✔ Finite State Machines in serial communication  
✔ Clock division and baud rate generation  
✔ Serial data sampling and reconstruction  
✔ Design for debugging with timing analysis  

---

## 🛠 Tools Used

- Verilog HDL
- Any FPGA simulator
- Optional synthesis tools like Vivado/Quartus/Radionics

---

## 🤝 Contributing

Contributions are welcome!  
You can fork, improve, and create a pull request.  

Suggestions:
- Add parity bit support
- FIFO buffer for TX/RX
- AXI-UART wrapper for SoC integration

---

## 📝 License

This project is open-source. You may use or modify it for learning or development.  
Refer to the included **LICENSE** file.

---

## 👤 Author

**Kuncham Koteswar**  
Aspiring Electronics & Communication Engineer  
Passionate about VLSI, FPGA & Embedded Systems  

GitHub: https://github.com/Kotesh000  

---

### ⭐ If you like this project, please give it a **star ⭐** on GitHub!
