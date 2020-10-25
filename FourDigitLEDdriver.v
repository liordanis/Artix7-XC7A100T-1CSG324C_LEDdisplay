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
module FourDigitLEDdriver(
    input reset,
    input clk,
	 //input button, //mono gia to meros c
    output reg an3,
    output reg an2,
    output reg an1,
    output reg an0,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g,
    output dp
    );

wire CLKDV_OUT;
wire CLKIN1 ;
wire DEBNC_RST;
//wire DEBNC_BTN; //mono gia to merosc
reg [5:0] time_counter; // gia to meros d (kanonika prpeei na einai 22 bit
reg [3:0] counter;//gia ta an0 an1 an2 an3

//gia tous xaraktires, arxikopoihsh sto mhden kai +1 kathe fora 
//poy o counter odhgei ena apo ola ta an0 an1 an2 an3
reg [3:0] char;

wire [7:0] ledsigns_temp;

//mnhmh gia to minima
reg [3:0] message [0:15];
//button counters
reg [3:0] message_counter_an0;
reg [3:0] message_counter_an1;
reg [3:0] message_counter_an2;
reg [3:0] message_counter_an3;


assign CLKIN1 = clk;

//debouncing button
/*
one_bit_debounce user_button_debounce (
    .clk(CLKIN1), 
    .BNC_SIGN(button), 
    .DEBNC_SIGN(DEBNC_BTN)
    );
	 */

//debouncing reset
one_bit_debounce reset_debounce (
    .clk(CLKIN1), 
    .BNC_SIGN(reset), 
    .DEBNC_SIGN(DEBNC_RST)
    );

//gia to mynhma
always@(posedge CLKIN1 or posedge DEBNC_RST) //to roloi tha ayksanei enan metrith
begin
	if(DEBNC_RST == 1)
	begin
		//mnhmh
		message[0] = 4'b0000;
		message[1] = 4'b0001;
		message[2] = 4'b0010;
		message[3] = 4'b0011;
		message[4] = 4'b0100;
		message[5] = 4'b0101;
		message[6] = 4'b0110;
		message[7] = 4'b0111;
		message[8] = 4'b1000;
		message[9] = 4'b1001;
		message[10] = 4'b1010;
		message[11] = 4'b1011;
		message[12] = 4'b1100;
		message[13] = 4'b1101;
		message[14] = 4'b1110;
		message[15] = 4'b1111;
		//metrhtes
		message_counter_an3 = 4'b0000;
		message_counter_an2 = 4'b0001;
		message_counter_an1 = 4'b0010;
		message_counter_an0 = 4'b0011;
		
		//gia to meros d
		time_counter = 6'b000000;
	end
	else
	begin//ayksanoumai ton metrith kata 1, as poume oti exei 6 bit. Kathe fora pou mhdenizei tha allazoume ta message counter
		time_counter = time_counter + 6'b000001;
		
		if(time_counter == 6'b111111)
		begin
			message_counter_an3 = message_counter_an3 + 4'b1111;
			message_counter_an2 = message_counter_an2 + 4'b1111;
			message_counter_an1 = message_counter_an1 + 4'b1111;
			message_counter_an0 = message_counter_an0 + 4'b1111;
		end
	end	
end


//gia to decode kai thn ektypwsh twn arithmwn
always@(posedge CLKIN1 or posedge DEBNC_RST)
begin
	if(DEBNC_RST == 1)
	begin
		counter = 4'b1111;
		char = 4'b1111;
	end
	else
	begin
		counter = counter + 4'b0001;
		case(counter)
		
			4'b0010: begin an0 = 1; an1 = 1; an2 = 1; an3 = 0; end
			4'b0110: begin an0 = 1; an1 = 1; an2 = 0; an3 = 1; end
			4'b1010: begin an0 = 1; an1 = 0; an2 = 1; an3 = 1; end
			4'b1110: begin an0 = 0; an1 = 1; an2 = 1; an3 = 1; end
			
			//gia na exoun xrono ta dedomena prpeie na ftasoun prin thn anodo twn endeiksewn toulaxiston 1 bhma
			//edw tha allazw ta dedomena endeiksis 2 bhmata metriti prin thn anodo
			
			//proetoimasia endeiksewn prin thn an0
			4'b0000: char = message[message_counter_an0];
			
			//proetoimasia endeiksewn prin thn an1
			4'b0100: char = message[message_counter_an1];
			
			//proetoimasia endeiksewn prin thn an2
			4'b1000: char = message[message_counter_an2];
			
			//proetoimasia endeiksewn prin thn an3
			4'b1100: char = message[message_counter_an3];
			
			default: begin an0 = 1; an1 = 1; an2 = 1; an3 = 1; end
			
		endcase	
	end
end


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
