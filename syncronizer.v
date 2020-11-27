`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:50:14 11/09/2020 
// Design Name: 
// Module Name:    syncronizer 
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
module syncronizer(
    input clk,
    input in,
    output reg out
    );

reg SYNC_DEBNC_RST_temp;


always@(posedge clk)
begin
	SYNC_DEBNC_RST_temp <= in;
	out <= SYNC_DEBNC_RST_temp ;
	//SYNC_DEBNC_BTN <= DEBNC_BTN;//only for part C
end
endmodule
