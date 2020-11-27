`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:46:14 10/16/2020 
// Design Name: 
// Module Name:    FourDigitLEDdriver 
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

/*************************************************/
//gia thn proswmeiwsh exoun allaxthei oi counters//
/*************************************************/

module FourDigitLEDdriver(
    input reset,
    input clk,
    output an3,
    output an2,
    output an1,
    output an0,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g,
    output dp
    );

wire DEBNC_RST;
//wire DEBNC_BTN; //mono gia to merosc


//kalwdio pou feygei apo to an_driver kai katalhgei sto LEDdecoder gia na symbolisei ton arithmo
//pros apokwdikopoihsh
wire [3:0] char;
//to ouput tou LEDdecoder pou syndeontai me ayto ta shmata a,b,c,d,e,f,f,dp
wire [7:0] ledsigns_temp;

wire SYNC_DEBNC_RST;


//debouncing reset
one_bit_debounce reset_debounceINSTANCE (
    .clk(clk), 
    .BNC_SIGN(reset), 
    .DEBNC_SIGN(DEBNC_RST)
    );
//syncronizing reset	
syncronizer reset_syncronizerINSTANCE (
    .clk(clk), 
    .in(DEBNC_RST), 
    .out(SYNC_DEBNC_RST)
    );


//o driver gia tis anodous. Eswterika ylopoieitai h mnhmh gia to mhnyma alla kai oi metrhtes 
//gia to kathe pshfio opou deixnoun thn energi thesi sthn mnhmh gia to kathena apo ta teleytaia
an_driver an_driverINSTANCE (
    .clk(clk), 
    .SYNC_DEBNC_RST(SYNC_DEBNC_RST),
    .an0(an0), 
    .an1(an1), 
    .an2(an2), 
    .an3(an3), 
    .char(char)
    );


LEDdecoder LEDdecoderINSTANCE(
		.char(char),
		.LED(ledsigns_temp)
		);

assign a = ledsigns_temp[7];		
assign b = ledsigns_temp[6];
assign c = ledsigns_temp[5];
assign d = ledsigns_temp[4];
assign e = ledsigns_temp[3];
assign f = ledsigns_temp[2];
assign g = ledsigns_temp[1];
assign dp = ledsigns_temp[0];

endmodule
