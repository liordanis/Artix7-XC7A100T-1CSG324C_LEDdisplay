`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:34:27 11/09/2020 
// Design Name: 
// Module Name:    an_driver 
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
module an_driver(
    input clk,
    input SYNC_DEBNC_RST,
	 //input SYNC_DEBNC_BTN,
    output reg an0,
    output reg an1,
    output reg an2,
    output reg an3,
    output reg [3:0] char = 4'b1111
    );

parameter AN_COUNTER_WIDTH = 4;
parameter TIME_COUNTER_WIDTH = 10;

reg [AN_COUNTER_WIDTH - 1:0] an_counter = 4'b1111;
reg [3:0] message [0:15];
//button counters
reg [3:0] message_counter_an0 = 4'b0000;
reg [3:0] message_counter_an1 = 4'b0001;
reg [3:0] message_counter_an2 = 4'b0010;
reg [3:0] message_counter_an3 = 4'b0011;

//gia na metraei 1,34 s
//reg [26:0] time_counter;

//gia xarh proswmoiwshs
reg [TIME_COUNTER_WIDTH - 1:0] time_counter;

//gia thn mnhmh kai tous counters ths mnhmhs. To lath pshfio exei ton diko tou
//counter pou deixnei sthn energh thesi mnhmhs
always@(posedge clk or posedge SYNC_DEBNC_RST) //to roloi tha ayksanei enan metrith
begin
	if(SYNC_DEBNC_RST == 1)
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
		message_counter_an3 = 4'b0011;
		message_counter_an2 = 4'b0010;
		message_counter_an1 = 4'b0001;
		message_counter_an0 = 4'b0000;
		
		//gia to meros d
		time_counter = 0;
	end
	else
	begin//ayksanoumai ton metrith kata 1, as poume oti exei 6 bit. Kathe fora pou mhdenizei tha allazoume ta message counter
		time_counter = time_counter + 1;
		
		if(time_counter == 0)
		begin
			message_counter_an3 = message_counter_an3 + 4'b1111;
			message_counter_an2 = message_counter_an2 + 4'b1111;
			message_counter_an1 = message_counter_an1 + 4'b1111;
			message_counter_an0 = message_counter_an0 + 4'b1111;
		end
	end	
end

always@(posedge clk or posedge SYNC_DEBNC_RST)
begin
	if(SYNC_DEBNC_RST == 1)
	begin
		an_counter = 4'b1111;
		//an_counter = 21'b1_1111_1111_1111_1111_1111;
		char = 4'b0000;
		an0 = 1; 
		an1 = 1; 
		an2 = 1; 
		an3 = 1;
	end
	else
	begin
		an_counter = an_counter + 4'b0001;
		//an_counter = an_counter + 21'b1;
		//if(an_counter == 21'b1_1010_0110_1010_0000_0000)//se aythn thn timh metrhsame 16ms
		//begin
			//an_counter = 21'b0_0010_0000_0000_0000_0000;
		//end
		case(an_counter)
			//h kathe anodos menei sto 0 gia 1 ms kai h apostash metaksi 2 anodwn 
			//pou ginontai mhden einai 3 ms ara synolika petyxainoume refresh rate 16ms
		
			//21'b0_0010_0000_0000_0000_0000: begin an0 = 0; an1 = 1; an2 = 1; an3 = 1; end
			//21'b0_0011_1000_0110_1010_0000: begin an0 = 1; an1 = 1; an2 = 1; an3 = 1; end
			//1_1000_0110_1010_0000 -> 1ms with 10ns period
			
			//21'b0_1000_0001_1010_1000_0000: begin an0 = 1; an1 = 0; an2 = 1; an3 = 1; end
			//21'b0_1001_1010_0001_0010_0000: begin an0 = 1; an1 = 1; an2 = 1; an3 = 1; end
			//000_0100_1001_0011_1110_0000 -> 3ms with 10ns period
			
			//21'b0_1110_0011_0101_0000_0000: begin an0 = 1; an1 = 1; an2 = 0; an3 = 1; end
			//21'b0_1111_1011_1011_1010_0000: begin an0 = 1; an1 = 1; an2 = 1; an3 = 1; end
			
			//21'b1_0100_0100_1111_1000_0000: begin an0 = 1; an1 = 1; an2 = 1; an3 = 0; end
			//21'b1_0101_1101_0110_0010_0000: begin an0 = 1; an1 = 1; an2 = 1; an3 = 1; end
			
			4'b0010: begin an0 = 1; an1 = 1; an2 = 1; an3 = 0; end
			4'b0011: begin an0 = 1; an1 = 1; an2 = 1; an3 = 1; end
			
			4'b0110: begin an0 = 1; an1 = 1; an2 = 0; an3 = 1; end
			4'b0111: begin an0 = 1; an1 = 1; an2 = 1; an3 = 1; end
			
			4'b1010: begin an0 = 1; an1 = 0; an2 = 1; an3 = 1; end
			4'b1011: begin an0 = 1; an1 = 1; an2 = 1; an3 = 1; end
			
			4'b1110: begin an0 = 0; an1 = 1; an2 = 1; an3 = 1; end
			4'b1111: begin an0 = 1; an1 = 1; an2 = 1; an3 = 1; end
			//gia na exoun xrono ta dedomena prpeie na ftasoun prin thn anodo twn endeiksewn toulaxiston 1 bhma
			//edw tha allazw ta dedomena endeiksis 2 bhmata metriti prin thn anodo
			
			//proetoimasia endeiksewn prin thn an0
			//21'b1_0111_0101_1100_1100_0000: begin char = 4'b0000; end
			4'b0000: char = message[message_counter_an0];
			
			//proetoimasia endeiksewn prin thn an1
			//21'b0_0101_0000_1101_0100_0000: begin char = 4'b0001; end
			4'b0100: char = message[message_counter_an1];
			//proetoimasia endeiksewn prin thn an2
			//21'b0_1011_0010_0111_1100_0000: begin char = 4'b0010; end
			4'b1000: char = message[message_counter_an2];
			//proetoimasia endeiksewn prin thn an3
			//21'b1_0001_0100_0010_0100_0000: begin char = 4'b0011; end
			4'b1100: char = message[message_counter_an3];
			
		endcase	
	end
end
endmodule
