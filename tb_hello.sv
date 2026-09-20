`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2026 05:53:07 AM
// Design Name: 
// Module Name: tb_hello
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_hello;
logic clk = 0;
logic rst = 1;
logic [1:0] speed_sw = 2'd0;
logic led;

hello dut (
.clk (clk),
.rst (rst),
.speed_sw(speed_sw),
.led(led)
);

always #10 clk = ~clk;

initial begin
#100 rst = 1;
#400 rst = 0;
#500 speed_sw = 2'd1;
#2000000 speed_sw = 2'd2;
#4000000 speed_sw = 2'd3;
#5000000 $finish;
end
endmodule
