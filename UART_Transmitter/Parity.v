`timescale 1ns / 1ps
module Parity(
  input rst,                //  Active low reset.
  input [7:0]data_in,       //  The data input from the InReg unit.
  input [1:0]parity_type,   //  Parity type agreed upon by the Tx and Rx units.
  output reg parity_bit     //  The parity bit output for the frame.
);
parameter odd = 2'b01, even = 2'b10;

always@(*)begin
if(!rst) parity_bit = 1'b1;
else begin
case(parity_type)
odd: parity_bit = (^data_in)?1'b0 : 1'b1;
even: parity_bit = (^data_in)?1'b1 : 1'b0;
default: parity_bit = 1'b1;
endcase
end
end
endmodule
