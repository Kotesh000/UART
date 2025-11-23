`timescale 1ns / 1ps
module DeFrame(
input wire rst, //Active low reset
input received_flag, // enable indicates when data is in progress
input [10:0]data_parall, // data frame passed from the sipo unit.
output reg parity_bit, // The parity bit seperated from the data frame
start_bit, // The start bit seperated from the data frame
stop_bit, // The stop bit seperated from the data frame
done_flag, // Indicates that tyhe data is received and ready for another data packets
output reg [7:0] raw_data // The 8-bits data sepereated from the data frame.
); 
always@(*)begin
start_bit = data_parall[0];
raw_data[7:0] = data_parall[8:11];
parity_bit = data_parall[9];
stop_bit = data_parall[10];
done_flag = received_flag;
end
endmodule

