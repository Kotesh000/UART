`timescale 1ns / 1ps
module BaudGenR(input rst, //Active low reset
input clk, // Main clock
input [1:0]baud_rate, //Baud Rate for transmitter and receiver
output reg baud_clk //clocking outputs for other modules.
);

// Internal Connections
reg [9:0] final_value; //Holds the number of ticks for each baudrate.
reg [9:0] clock_ticks; // Counts until it equals final_value, timer principle.

// Encoding the different baud rates
parameter baud24 = 2'b00,baud48 = 2'b01,baud96 = 2'b10,baud192 = 2'b11;

// BaudRate 4-1 Mux
always@(*) begin
case(baud_rate)
// All these ratio ticks are calculated for 500MHz Clock.
// The values shall change with the chnage of the clock frequency.
baud24: final_value = 10'd651; // 16 * 2400 BaudRate.
baud48: final_value = 10'd326; // 16 * 4800 BaudRate.
baud96: final_value = 10'd163; // 16 * 9600 BaudRate.
baud192: final_value = 10'd81; // 16 * 19200 BaudRate.
default: final_value = 10'd163; // 16 * 9600 BaudRate.
endcase
end

// Timer logic
always@(negedge rst, posedge clk) begin
if(!rst)
begin
clock_ticks <= 10'd0;
baud_clk <= 1'b0;
end 
else begin
if(clock_ticks == final_value) begin
baud_clk <= ~baud_clk;
clock_ticks <= 10'd0;
end
else begin
clock_ticks <= clock_ticks + 1'd1;
baud_clk <= baud_clk;
end
end
end
endmodule
