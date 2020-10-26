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
reg power_down = 1'b0;
wire CLKDV_OUT;
reg CLKIN1 = 1'b0;
wire DEBNC_RST;
//wire DEBNC_BTN; //mono gia to merosc
reg [5:0] time_counter; // gia to meros d (kanonika prpeei na einai 22 bit
reg [3:0] an_counter;//gia ta an0 an1 an2 an3

//gia tous xaraktires, arxikopoihsh sto mhden kai +1 kathe fora 
//poy o counter odhgei ena apo ola ta an0 an1 an2 an3
reg [3:0] char;
wire [7:0] ledsigns_temp;

reg SYNC_DEBNC_BTN;
reg SYNC_DEBNC_RST;
reg SYNC_DEBNC_RST_temp;

//mnhmh gia to minima
reg [3:0] message [0:15];
//button counters
reg [3:0] message_counter_an0;
reg [3:0] message_counter_an1;
reg [3:0] message_counter_an2;
reg [3:0] message_counter_an3;

reg [3:0]clock_counter = 4'b0000;

always@(posedge clk)
begin
	clock_counter = clock_counter + 4'b0001;
	if(clock_counter == 4'b1111)
	begin
		CLKIN1 = 1'b1;
	end
	else
	begin
		CLKIN1 = 1'b0;
	end
end

//assign CLKIN1 = clk;

//debouncing button

//only for part c
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

//sychronize button and reset
always@(posedge CLKIN1)
begin
	SYNC_DEBNC_RST_temp <= DEBNC_RST;
	SYNC_DEBNC_RST <= SYNC_DEBNC_RST_temp ;
	//SYNC_DEBNC_BTN <= DEBNC_BTN;//only for part C
end

//gia to mynhma
always@(posedge CLKIN1 or posedge SYNC_DEBNC_RST) //to roloi tha ayksanei enan metrith
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
always@(posedge CLKIN1 or posedge SYNC_DEBNC_RST)
begin
	if(SYNC_DEBNC_RST == 1)
	begin
		an_counter = 4'b1111;
		char = 4'b1111;
	end
	else
	begin
		an_counter = an_counter + 4'b0001;
		case(an_counter)
		
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
/*
MMCME2_BASE #(
      .BANDWIDTH("OPTIMIZED"),   // Jitter programming (OPTIMIZED, HIGH, LOW)
      .CLKFBOUT_MULT_F(5.0),     // Multiply value for all CLKOUT (2.000-64.000).
      .CLKFBOUT_PHASE(0.0),      // Phase offset in degrees of CLKFB (-360.000-360.000).
      .CLKIN1_PERIOD(10.0),       // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      // CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      .CLKOUT1_DIVIDE(32),
      .CLKOUT2_DIVIDE(1),
      .CLKOUT3_DIVIDE(1),
      .CLKOUT4_DIVIDE(1),
      .CLKOUT5_DIVIDE(1),
      .CLKOUT6_DIVIDE(1),
      .CLKOUT0_DIVIDE_F(1.0),    // Divide amount for CLKOUT0 (1.000-128.000).
      // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
      .CLKOUT0_DUTY_CYCLE(0.5),
      .CLKOUT1_DUTY_CYCLE(0.5),
      .CLKOUT2_DUTY_CYCLE(0.5),
      .CLKOUT3_DUTY_CYCLE(0.5),
      .CLKOUT4_DUTY_CYCLE(0.5),
      .CLKOUT5_DUTY_CYCLE(0.5),
      .CLKOUT6_DUTY_CYCLE(0.5),
      // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      .CLKOUT0_PHASE(0.0),
      .CLKOUT1_PHASE(0.0),
      .CLKOUT2_PHASE(0.0),
      .CLKOUT3_PHASE(0.0),
      .CLKOUT4_PHASE(0.0),
      .CLKOUT5_PHASE(0.0),
      .CLKOUT6_PHASE(0.0),
      .CLKOUT4_CASCADE("FALSE"), // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
      .DIVCLK_DIVIDE(1),         // Master division value (1-106)
      .REF_JITTER1(0.0),         // Reference input jitter in UI (0.000-0.999).
      .STARTUP_WAIT("FALSE")     // Delays DONE until MMCM is locked (FALSE, TRUE)
   )
   MMCME2_BASE_inst (
      // Clock Outputs: 1-bit (each) output: User configurable clock outputs
      .CLKOUT0(CLKOUT0),     // 1-bit output: CLKOUT0
      .CLKOUT0B(CLKOUT0B),   // 1-bit output: Inverted CLKOUT0
      .CLKOUT1(CLKOUT1),     // 1-bit output: CLKOUT1
      .CLKOUT1B(CLKOUT1B),   // 1-bit output: Inverted CLKOUT1
      .CLKOUT2(CLKOUT2),     // 1-bit output: CLKOUT2
      .CLKOUT2B(CLKOUT2B),   // 1-bit output: Inverted CLKOUT2
      .CLKOUT3(CLKOUT3),     // 1-bit output: CLKOUT3
      .CLKOUT3B(CLKOUT3B),   // 1-bit output: Inverted CLKOUT3
      .CLKOUT4(CLKOUT4),     // 1-bit output: CLKOUT4
      .CLKOUT5(CLKOUT5),     // 1-bit output: CLKOUT5
      .CLKOUT6(CLKOUT6),     // 1-bit output: CLKOUT6
      // Feedback Clocks: 1-bit (each) output: Clock feedback ports
      .CLKFBOUT(CLKFBOUT),   // 1-bit output: Feedback clock
      .CLKFBOUTB(CLKFBOUTB), // 1-bit output: Inverted CLKFBOUT
      // Status Ports: 1-bit (each) output: MMCM status ports
      .LOCKED(LOCKED),       // 1-bit output: LOCK
      // Clock Inputs: 1-bit (each) input: Clock input
      .CLKIN1(clk),       // 1-bit input: Clock
      // Control Ports: 1-bit (each) input: MMCM control ports
      .PWRDWN(power_down),       // 1-bit input: Power-down
      .RST(reset),             // 1-bit input: Reset
      // Feedback Clocks: 1-bit (each) input: Clock feedback ports
      .CLKFBIN(clk)      // 1-bit input: Feedback clock
   );
*/
endmodule
