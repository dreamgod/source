`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:19:00 07/09/2014 
// Design Name: 
// Module Name:    Top 
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
module Tx_Top(
    input wire  Q1_CLK0_MGTREFCLK_PAD_N_IN,
    input wire  Q1_CLK0_MGTREFCLK_PAD_P_IN,

// signals from PCIE
	input           CLK_250M ,
	input   [63:0]  Data_PCIE_i,
	input           Valid_PCIE_i,
	input           VFIFO_Full,
// signals to PCIE 
	output  [63:0]  Data_PCIE_o,
	output          Valid_PCIE_o,
	output          FIFO_C1_Full,
// gtx pins
    input  wire [1:0]   RXN_IN,
    input  wire [1:0]   RXP_IN,
    output wire [1:0]   TXN_OUT,
    output wire [1:0]   TXP_OUT
    );
	
	
	
	
//  signals from SFP
	wire 		CLK_245M_76_CH1;    // input channel 1 data clk
	wire 		CLK_245M_76_CH2;  //  input channel 2 data clk
	wire        DataSendCLK;     //  output data clk
	
	wire 	[15:0]	Data_CH1_in;
	wire            Char_CH1_in;
	wire    [15:0]  Data_CH2_in;
	wire            Char_CH2_in;
    wire    [15:0]  DataSend;
	wire            DataSendisK;
	
// Process Data from PCIE 
	Data_Out_Pro Pro_outputdata (
		.CLK_250M(CLK_250M), 
		.Data_PCIE_i(Data_PCIE_i), 
		.Valid_PCIE_i(Valid_PCIE_i), 
		.DataSendCLK(DataSendCLK), 
		.FIFO_C1_Full(FIFO_C1_Full), 
		.DataSend(DataSend), 
		.DataSendisK(DataSendisK)
	);


	
//  Catch
Data_in_Pro Pro_inputdata (
.CLK_250M(CLK_250M),
.CLK_245M76_CH1(CLK_245M_76_CH1),
.CLK_245M76_CH2(CLK_245M_76_CH2),
.Data_CH1_in(Data_CH1_in),
.Char_CH1_in(Char_CH1_in),
.Data_CH2_in(Data_CH2_in),
.Char_CH2_in(Char_CH2_in),
.VFIFO_Full(VFIFO_Full),
.Data_Out(Data_PCIE_o),
.Vlaid_Data_Out(Valid_PCIE_o)
);	
	

cpri_3_top  SFP_Transmit
( 
.Q1_CLK0_MGTREFCLK_PAD_N_IN (Q1_CLK0_MGTREFCLK_PAD_N_IN)              ,
.Q1_CLK0_MGTREFCLK_PAD_P_IN (Q1_CLK0_MGTREFCLK_PAD_P_IN)              ,
.DataRev_CH1			(Data_CH1_in)                                 ,
.DataRev_CH2			(Data_CH2_in)                                 ,
.CharisK_CH1			(Char_CH1_in)                                 ,
.CharisK_CH2			(Char_CH2_in)                                 ,
.DataCLK_CH1			(CLK_245M_76_CH1)                             ,
.DataCLK_CH2			(CLK_245M_76_CH2)                             ,

.DataSend               (DataSend)                                    ,
.DataSendIsK            (DataSendisK)                                 ,
.DataSendCLK            (DataSendCLK)                               ,
                                                                   
.RXN_IN 	            (RXN_IN )				    				  ,
.RXP_IN 				(RXP_IN )				    				  ,
.TXN_OUT				(TXN_OUT)				    				  ,
.TXP_OUT                (TXP_OUT)
);
	


endmodule
