`timescale 1ns / 1ps
module BaudGenT(
input rst, // Active low reset.
input clk, //  The System's main clock.
input [1:0]baud_rate, //  Baud Rate agreed upon by the Tx and Rx units.
output reg baud_clk  //  Clocking output for the other modules.
);

// Internal Declerations
reg [13:0] clock_ticks;
reg [13:0] final_value;

// Encding for the baud rate states
parameter baud24 = 2'b00,baud48 = 2'b01,baud96 = 2'b10,baud192 = 2'b11;

// baudrate 4-1 Mux
always@(baud_rate) begin
case(baud_rate)
//  All these ratio ticks are calculated for 50MHz Clock,
//  The values shall change with the change of the clock frequency.
baud24: final_value = 14'd10417; // ratio ticks for the 2400 baudrate.
baud48: final_value = 14'd5208; // ratio ticks for the 4800 baudrate.
baud96: final_value = 14'd2604; // ratio ticks for the 9600 baudrate.
baud192: final_value = 14'd1302; // ratio ticks for the 19200 baudrate.
default: final_value = 14'd0; // The system original clock.
endcase
end

// Timer logic
always@(negedge rst, posedge clk) begin
if(!rst) begin
clock_ticks <= 14'd0;
baud_clk <= 14'd0;
end 
else begin
if(clock_ticks == final_value) begin
clock_ticks <= 14'd0;
baud_clk <= ~baud_clk;
end
else begin
clock_ticks <= clock_ticks + 1'd1;
baud_clk <= baud_clk;
end
end
end
endmodule