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
    output reg DEBNC_SIGN = 1'b0
    );

parameter COUNTER_WIDTH = 21;

wire DEBNC_TEMP;
reg q1 = 1'b1;
reg q2 = 1'b1;
reg [COUNTER_WIDTH - 1:0] counter = 5'b0;


always@(posedge clk)
begin
	q1 <= BNC_SIGN;
	q2 <= q1;
end

//pairname to shma apo dyo flip flops kai epeita to kanoume xor
//an to xor bgei 1 tote mhdenizoume ton metrith (pernaei bounce)
//alliws ayksanoume ton metrhth. An o metrhths mhdenisei tote
//stelnoume enan palmo (perase arketos xronos gia na fygei to bounce)

assign DEBNC_TEMP = q1 ^ q2;

always@(posedge clk)
begin
	//DEBNC_SIGN = 0;
	if(DEBNC_TEMP == 1)
	begin
		counter = 0;
	end
	else
	begin
		
		if(counter == 0)
		begin
			DEBNC_SIGN = q1;
		end
		counter = counter + 1'd1;
	end
end

endmodule
