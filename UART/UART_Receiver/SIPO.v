`timescale 1ns / 1ps
module SIPO(
    input  rst,             //  Active low reset.
    data_tx,                //  Serial Data recieved from the transmitter.
    baud_clk,               //  The clocking input comes from the sampling unit.
    output active_flag,     //  outputs logic 1 when data is in progress.
    recieved_flag,          //  outputs a signal enables the deframe unit. 
    output [10:0]data_parll //  outputs the 11-bit parallel frame.
);
reg [10:0] temp, data_parll_temp;
reg [3:0]  frame_counter, stop_count;
reg [1:0]  next_state;
parameter idle = 2'b00, center = 2'b01, frame  = 2'b11, get = 2'b10;

always@(posedge baud_clk, negedge rst) begin
if(!rst)begin
next_state <= idle;
stop_count <= 4'd0;
frame_counter <= 4'd0;
temp <= {11{1'b1}};
end
else begin
case(next_state)
idle: 
begin 
temp <= {11{1'b1}};
stop_count <= 4'd0;
frame_counter <= 4'd0;
if(~data_tx) begin
next_state <= center;
end
else begin
next_state <= idle;
end
end

center: 
begin
if(stop_count == 4'd6) begin
stop_count <= 4'd0;
next_state <= get;
end
else begin
stop_count <= stop_count + 4'b1;
next_state <= center;
end
end

frame: 
begin 
temp <= data_parll_temp;
if(frame_counter == 4'd10) begin
frame_counter <= 4'd0;
next_state <= idle;
end
else begin
if(stop_count == 4'd14) begin
frame_counter  <= frame_counter + 4'b1;
stop_count <= 4'd0; 
next_state <= get;
end
else begin
frame_counter  <= frame_counter;
stop_count <= stop_count + 4'b1;
next_state <= frame;
end
end
end

get: begin 
next_state <= frame;
temp <= data_parll_temp;
end
endcase
end
end

always @(*) begin
  case (next_state)
idle, center, frame: data_parll_temp  = temp;

get : begin
data_parll_temp    = temp >> 1;
data_parll_temp[10] = data_tx;
end
endcase
end
assign data_parll    = recieved_flag? data_parll_temp : {11{1'b1}};
assign recieved_flag = (frame_counter == 4'd10);
assign active_flag   = !recieved_flag;
endmodule
