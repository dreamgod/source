`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:13 07/09/2014 
// Design Name: 
// Module Name:    Data_in_Pro 
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
module Data_in_Pro(
	input  		         CLK_250M,
	input    	         CLK_245M76_CH1,
	input    	         CLK_245M76_CH2,
	input 	[15:0]	     Data_CH1_in,
	input                Char_CH1_in,
	input   [15:0]       Data_CH2_in,
	input                Char_CH2_in,
	input                VFIFO_Full,
	output   reg [63:0]  Data_Out,
	output   reg         Vlaid_Data_Out
    );



reg [15:0]DataRev_CH1_R1=0;
reg [15:0]DataRev_CH1_R2=0;
reg [15:0]DataRev_CH1_R3=0;
reg CharisK_CH1_R1=0;
reg CharisK_CH1_R2=0;
reg CharisK_CH1_R3=0;



reg [3:0]Catch_State_CH1=0;
reg wr_en_CH1=0;
reg [15:0]DataCount_CH1=0;
reg [1:0]TempData_CH1=0;
reg rd_en_CH1;
wire valid_CH1;
wire [63:0]dout_CH1;

wire empty_CH1,almost_empty_CH1;
wire full_CH1,almost_full_CH1;

// delay data and char
always @ (posedge CLK_245M76_CH1)
begin 
	DataRev_CH1_R1 <= Data_CH1_in;
	DataRev_CH1_R2 <= DataRev_CH1_R1;
	DataRev_CH1_R3 <= DataRev_CH1_R2;
	
	CharisK_CH1_R1 <= Char_CH1_in;
	CharisK_CH1_R2 <= CharisK_CH1_R1;
	CharisK_CH1_R3 <= CharisK_CH1_R2;
end 


//--------------Rec From Fiber
//Frame Structure
//A0AA:Frame Start
//A0AA:Frame Start
//Frame kind 
//Frame length
//Valid Data
//AAAA:Frame End
//AAAA:Frame End
//Frame Length not contain it self 
//----------------------CH1  Write Vlaid Data To FiFO--------------------------//

reg [5:0]Write_Point_CH1     = 0 ;
always @(posedge CLK_245M76_CH1)
case (Catch_State_CH1)
0:if(DataRev_CH1_R2 == 16'hA0AA)begin
		if(DataRev_CH1_R1 == 16'hA0AA)begin
		    wr_en_CH1 <= 1;                           //R3= A0AA
			Catch_State_CH1 <= Catch_State_CH1 + 1'b1;
		end
	end
	else begin
	  TempData_CH1 <= 2'b00;
	  wr_en_CH1 <= 1'b0;
	  DataCount_CH1 <= 'd0;
	  Catch_State_CH1 <= Catch_State_CH1;
	end
1:begin 
	wr_en_CH1 <= 1;                                  // R3= A0AA 
	DataCount_CH1 <= Data_CH1_in;                    // Valid Data Length + a0aa*2 + aaaa*2 + length = total_length
	TempData_CH1 <= 2'b00-(Data_CH1_in[1:0]+2'b10);  // because we need keep a frame completed, so we should add more data.
	Catch_State_CH1 <= Catch_State_CH1 + 1'b1;
end 	
2:begin 
		DataCount_CH1 <= DataCount_CH1 + TempData_CH1;                // 
        wr_en_CH1 <= 1'b1;                            //R3=Frame kind 
		Catch_State_CH1 <= Catch_State_CH1 + 1'b1;
	end
3:begin
		wr_en_CH1 <= 1'b1;
		Catch_State_CH1 <= Catch_State_CH1 + 1'b1;          //R3=Length 
	end 
4:begin
		if(CharisK_CH1_R2 == 1) begin
			wr_en_CH1 <= 1'b0;
			DataCount_CH1 <= DataCount_CH1;
		end
		else if(DataCount_CH1== 0)begin
				Catch_State_CH1 <= Catch_State_CH1 + 1'b1;
				wr_en_CH1 <= 1'b1;
				end 
			else begin 
				wr_en_CH1 <= 1'b1;
				DataCount_CH1 <= DataCount_CH1 - 1'b1;
			end 
	end
 
5:begin
	Write_Point_CH1 <= Write_Point_CH1 + 1'b1;
	wr_en_CH1 <= 1'b1;
	Catch_State_CH1 <= 0;
	DataCount_CH1 <= 0;
end

default:begin
	wr_en_CH1 <= 0;
	Catch_State_CH1 <= 0;
	DataCount_CH1 <= 0;
	end 
endcase 
	

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
//----------- FiFo  depth 16384 
FiFo_16_64 CH1_IN_FIFO (
  .rst(1'b0), // input rst
  .wr_clk(CLK_245M76_CH1), // input wr_clk
  .rd_clk(CLK_250M), // input rd_clk
  .din(DataRev_CH1_R3), // input [15 : 0] din
  .wr_en(wr_en_CH1), // input wr_en_CH1
  .rd_en(rd_en_CH1), // input rd_en
  .dout(dout_CH1), // output [63 : 0] dout
  .full(full_CH1), // output full
  .almost_full(almost_full_CH1), // output almost_full
  .empty(empty_CH1), // output empty
  .almost_empty(almost_empty_CH1), // output almost_empty
  .valid(valid_CH1) // output valid
);
// INST_TAG_END ------ End INSTANTIATION Template --------


always @ (posedge CLK_250M)
begin 
	Vlaid_Data_Out <= valid_CH1;
	Data_Out       <= dout_CH1;
end 

//produce dataValid //
always @ (posedge CLK_250M )
begin if (almost_empty_CH1)begin
		rd_en_CH1 <= 1'b0;
		end
	else if(VFIFO_Full == 1'b1)begin	
				rd_en_CH1 <= 1'b0;
				end
				else begin
				rd_en_CH1 <= 1'b1;
				end
			end	
endmodule 

