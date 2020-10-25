`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:22:07 10/18/2020 
// Design Name: 
// Module Name:    one_bit_debounce 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

//bgazontas ta sxolia xrhshmopoiountai 3 flip flops(alla prepei me thn syxnothta rologiou prin thn diairesh)
//h telikh epilogh tha ginei epeita apo testing
module one_bit_debounce(
    input clk,
    input BNC_SIGN,
    output DEBNC_SIGN
    );

reg q1 = 1'b1;
reg q2 = 1'b1;
//reg q3 = 1'b1;

always@(posedge clk)
begin
	q1 <= BNC_SIGN;
	q2 <= q1;
	//q3 <= q2;
end

//assign DEBNC_SIGN = q1 & q2 & q3;
assign DEBNC_SIGN = q1 & q2 & BNC_SIGN;


endmodule
