`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:08:50 10/15/2020 
// Design Name: 
// Module Name:    LEDdecoder 
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
module LEDdecoder(
    input [3:0] char,
    output reg [7:0] LED
    );
	 

always@(char)
begin
	case(char)
		4'b0000: LED = 8'b00000011; //0
		4'b0001: LED = 8'b10011111; //1
		4'b0010: LED = 8'b00100101; //2
		4'b0011: LED = 8'b00001101; //3
		4'b0100: LED = 8'b10011001; //4
		4'b0101: LED = 8'b01001001; //5
		4'b0110: LED = 8'b01100001; //6
		4'b0111: LED = 8'b00011111; //7
		4'b1000: LED = 8'b00000001; //8
		4'b1001: LED = 8'b00001001; //9
		4'b1010: LED = 8'b00000101; //A
		4'b1011: LED = 8'b11000001; //b
		4'b1100: LED = 8'b11100101; //c
		4'b1101: LED = 8'b10000101; //d
		4'b1110: LED = 8'b01100001; //E
		4'b1111: LED = 8'b01110001; //F
	endcase
end
endmodule
