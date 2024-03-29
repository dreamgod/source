////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 1.12
//  \   \         Application : Virtex-6 FPGA GTX Transceiver Wizard 
//  /   /         Filename : v6_gtxwizard_v1_12_top.v
// /___/   /\      
// \   \  /  \ 
//  \___\/\___\ 
//
//
// Module v6_gtxwizard_v1_12_top
// Generated by Xilinx Virtex-6 FPGA GTX Transceiver Wizard
// 
// 
// (c) Copyright 2009-2011 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES. 


`timescale 1ns / 1ps
`define DLY #1


//***********************************Entity Declaration************************

module cpri_3_top 
(
    input wire  Q1_CLK0_MGTREFCLK_PAD_N_IN,
    input wire  Q1_CLK0_MGTREFCLK_PAD_P_IN,
	//add by lianggui
    output     [15:0]   DataRev_CH1,
	output     [15:0]   DataRev_CH2,
	output              CharisK_CH1,
	output              CharisK_CH2,
	output              DataCLK_CH1,
	output              DataCLK_CH2,
	
	input      [15:0]   DataSend,
	input               DataSendIsK,
	output              DataSendCLK,
	//add by lianggui 
    input  wire [1:0]   RXN_IN,
    input  wire [1:0]   RXP_IN,
    output wire [1:0]   TXN_OUT,
    output wire [1:0]   TXP_OUT
);


//************************** Register Declarations ****************************

    reg     [84:0]  ila_in_r;

    reg             gtx0_txresetdone_r;
    reg             gtx0_txresetdone_r2;
// * max_fanout = 1 *
    reg             gtx0_rxresetdone_i_r;
    reg             gtx0_rxresetdone_r;
    reg             gtx0_rxresetdone_r2;
    reg             gtx0_rxresetdone_r3;
    reg             gtx1_txresetdone_r;
    reg             gtx1_txresetdone_r2;
// * max_fanout = 1 *
    reg             gtx1_rxresetdone_i_r;
    reg             gtx1_rxresetdone_r;
    reg             gtx1_rxresetdone_r2;
    reg             gtx1_rxresetdone_r3;
    //------------------------ MGT Wrapper Wires ------------------------------
    //________________________________________________________________________
    //________________________________________________________________________
    //GTX0   (X0Y4)

    //---------------------- Loopback and Powerdown Ports ----------------------
    wire    [2:0]   gtx0_loopback_i;
    //--------------------- Receive Ports - 8b10b Decoder ----------------------
   (*KEEP="True"*)     wire    [1:0]   gtx0_rxchariscomma_i;
   (*KEEP="True"*)     wire    [1:0]   gtx0_rxcharisk_i;
   (*KEEP="True"*)     wire    [1:0]   gtx0_rxdisperr_i;
   (*KEEP="True"*)     wire    [1:0]   gtx0_rxnotintable_i;
    //----------------- Receive Ports - Clock Correction Ports -----------------
   (*KEEP="True"*)     wire    [2:0]   gtx0_rxclkcorcnt_i;
    //------------- Receive Ports - Comma Detection and Alignment --------------
    wire            gtx0_rxcommadet_i;
    wire            gtx0_rxenmcommaalign_i;
    wire            gtx0_rxenpcommaalign_i;
    //----------------- Receive Ports - RX Data Path interface -----------------
    wire    [15:0]  gtx0_rxdata_i;
    wire            gtx0_rxrecclk_i;
    //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    wire    [2:0]   gtx0_rxeqmix_i;
    //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
   (*KEEP="True"*)     wire    [2:0]   gtx0_rxbufstatus_i;
    //---------------------- Receive Ports - RX PLL Ports ----------------------
    wire            gtx0_gtxrxreset_i;
    wire            gtx0_pllrxreset_i;
    wire            gtx0_rxplllkdet_i;
    wire            gtx0_rxresetdone_i;
    //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
   (*KEEP="True"*)     reg    [1:0]   gtx0_txcharisk_i;
    //---------------- Transmit Ports - TX Data Path interface -----------------
   (*KEEP="True"*)     reg    [15:0]  gtx0_txdata_i;
    wire            gtx0_txoutclk_i;
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    wire    [3:0]   gtx0_txdiffctrl_i;
    wire    [4:0]   gtx0_txpostemphasis_i;
    //------------- Transmit Ports - TX Driver and OOB signalling --------------
    wire    [3:0]   gtx0_txpreemphasis_i;
    //------ Transmit Ports - TX Elastic Buffer and Phase Alignment Ports ------
    wire            gtx0_txdlyaligndisable_i;
    wire            gtx0_txdlyalignmonenb_i;
    wire    [7:0]   gtx0_txdlyalignmonitor_i;
    wire            gtx0_txdlyalignreset_i;
    wire            gtx0_txenpmaphasealign_i;
    wire            gtx0_txpmasetphase_i;
    //--------------------- Transmit Ports - TX PLL Ports ----------------------
    wire            gtx0_gtxtxreset_i;
    wire            gtx0_txresetdone_i;


    //________________________________________________________________________
    //________________________________________________________________________
    //GTX1   (X0Y5)

    //---------------------- Loopback and Powerdown Ports ----------------------
    wire    [2:0]   gtx1_loopback_i;
    //--------------------- Receive Ports - 8b10b Decoder ----------------------
   (*KEEP="True"*)     wire    [1:0]   gtx1_rxchariscomma_i;
   (*KEEP="True"*)     wire    [1:0]   gtx1_rxcharisk_i;
   (*KEEP="True"*)     wire    [1:0]   gtx1_rxdisperr_i;
   (*KEEP="True"*)     wire    [1:0]   gtx1_rxnotintable_i;
    //----------------- Receive Ports - Clock Correction Ports -----------------
   (*KEEP="True"*)     wire    [2:0]   gtx1_rxclkcorcnt_i;
    //------------- Receive Ports - Comma Detection and Alignment --------------
    wire            gtx1_rxcommadet_i;
    wire            gtx1_rxenmcommaalign_i;
    wire            gtx1_rxenpcommaalign_i;
    //----------------- Receive Ports - RX Data Path interface -----------------
    wire    [15:0]  gtx1_rxdata_i;
    wire            gtx1_rxrecclk_i;
    //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    wire    [2:0]   gtx1_rxeqmix_i;
    //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
   (*KEEP="True"*)     wire    [2:0]   gtx1_rxbufstatus_i;
    //---------------------- Receive Ports - RX PLL Ports ----------------------
    wire            gtx1_gtxrxreset_i;
    wire            gtx1_pllrxreset_i;
    wire            gtx1_rxplllkdet_i;
    wire            gtx1_rxresetdone_i;
    //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
   (*KEEP="True"*)     reg    [1:0]   gtx1_txcharisk_i;
    //---------------- Transmit Ports - TX Data Path interface -----------------
   (*KEEP="True"*)     reg    [15:0]  gtx1_txdata_i;
    wire            gtx1_txoutclk_i;
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    wire    [3:0]   gtx1_txdiffctrl_i;
    wire    [4:0]   gtx1_txpostemphasis_i;
    //------------- Transmit Ports - TX Driver and OOB signalling --------------
    wire    [3:0]   gtx1_txpreemphasis_i;
    //------ Transmit Ports - TX Elastic Buffer and Phase Alignment Ports ------
    wire            gtx1_txdlyaligndisable_i;
    wire            gtx1_txdlyalignmonenb_i;
    wire    [7:0]   gtx1_txdlyalignmonitor_i;
    wire            gtx1_txdlyalignreset_i;
    wire            gtx1_txenpmaphasealign_i;
    wire            gtx1_txpmasetphase_i;
    //--------------------- Transmit Ports - TX PLL Ports ----------------------
    wire            gtx1_gtxtxreset_i;
    wire            gtx1_txresetdone_i;




    //----------------------------- Global Signals -----------------------------
    wire            gtx0_tx_system_reset_c;
    wire            gtx0_rx_system_reset_c;
    wire            gtx1_tx_system_reset_c;
    wire            gtx1_rx_system_reset_c;
    wire            tied_to_ground_i;
    wire    [63:0]  tied_to_ground_vec_i;
    wire            tied_to_vcc_i;
    wire    [7:0]   tied_to_vcc_vec_i;
    wire            drp_clk_in_i;

    //--------------------------- User Clocks ---------------------------------
(*PERIOD = "4.096ns"*)    wire            gtx0_txusrclk2_i;
(*PERIOD = "4.096ns"*)      wire            gtx0_rxusrclk2_i;
(*PERIOD = "4.096ns"*)      wire            gtx1_rxusrclk2_i;
    wire            txoutclk_mmcm0_locked_i;
    wire            txoutclk_mmcm0_reset_i;
    wire            gtx0_txoutclk_to_mmcm_i;


    //--------------------------- Reference Clocks ----------------------------
    
    wire            q1_clk0_refclk_i;
    wire            q1_clk0_refclk_i_bufg;
    //--------------------- Frame check/gen Module Signals --------------------
    wire            gtx0_matchn_i;
    
    wire    [1:0]   gtx0_txcharisk_float_i;
    
    wire    [23:0]  gtx0_txdata_float_i;
    
    
    wire            gtx0_block_sync_i;
    wire            gtx0_track_data_i;
 (*MARK_DEBUG = "True"*)   wire    [15:0]  gtx0_ErrorCount;
    wire            gtx0_frame_check_reset_i;
    wire            gtx0_inc_in_i;
    wire            gtx0_inc_out_i;
    wire    [15:0]  gtx0_unscrambled_data_i;

    wire            gtx1_matchn_i;
    
    wire    [1:0]   gtx1_txcharisk_float_i;
    
    wire    [23:0]  gtx1_txdata_float_i;
    
    
    wire            gtx1_block_sync_i;
    wire            gtx1_track_data_i;
 (*MARK_DEBUG = "True"*)   wire    [15:0]  gtx1_ErrorCount;
    wire            gtx1_frame_check_reset_i;
    wire            gtx1_inc_in_i;
    wire            gtx1_inc_out_i;
    wire    [15:0]  gtx1_unscrambled_data_i;

    wire            reset_on_data_error_i;
    wire            track_data_out_i;



//**************************** Main Body of Code *******************************

    //  Static signal Assigments    
    assign tied_to_ground_i             = 1'b0;
    assign tied_to_ground_vec_i         = 64'h0000000000000000;
    assign tied_to_vcc_i                = 1'b1;
    assign tied_to_vcc_vec_i            = 8'hff;



    //---------------------Dedicated GTX Reference Clock Inputs ---------------
    // The dedicated reference clock inputs you selected in the GUI are implemented using
    // IBUFDS_GTXE1 instances.
    //
    // In the UCF file for this example design, you will see that each of
    // these IBUFDS_GTXE1 instances has been LOCed to a particular set of pins. By LOCing to these
    // locations, we tell the tools to use the dedicated input buffers to the GTX reference
    // clock network, rather than general purpose IOs. To select other pins, consult the 
    // Implementation chapter of UG___, or rerun the wizard.
    //
    // This network is the highest performace (lowest jitter) option for providing clocks
    // to the GTX transceivers.
    
    IBUFDS_GTXE1 q1_clk0_refclk_ibufds_i
    (
        .O                              (q1_clk0_refclk_i),
        .ODIV2                          (),
        .CEB                            (tied_to_ground_i),
        .I                              (Q1_CLK0_MGTREFCLK_PAD_P_IN),
        .IB                             (Q1_CLK0_MGTREFCLK_PAD_N_IN)
    );

 
    

    BUFG q1_clk0_refclk_bufg_i
    (
        .I                              (q1_clk0_refclk_i),
        .O                              (q1_clk0_refclk_i_bufg)
    );



    //--------------------------------- User Clocks ---------------------------
    
    // The clock resources in this section were added based on userclk source selections on
    // the Latency, Buffering, and Clocking page of the GUI. A few notes about user clocks:
    // * The userclk and userclk2 for each GTX datapath (TX and RX) must be phase aligned to 
    //   avoid data errors in the fabric interface whenever the datapath is wider than 10 bits
    // * To minimize clock resources, you can share clocks between GTXs. GTXs using the same frequency
    //   or multiples of the same frequency can be accomadated using MMCMs. Use caution when
    //   using RXRECCLK as a clock source, however - these clocks can typically only be shared if all
    //   the channels using the clock are receiving data from TX channels that share a reference clock 
    //   source with each other.

    assign  txoutclk_mmcm0_reset_i               =  !gtx0_rxplllkdet_i;
    MGT_USRCLK_SOURCE_MMCM #
    (
        .MULT                           (8.0),
        .DIVIDE                         (2),
        .CLK_PERIOD                     (4.07),
        .OUT0_DIVIDE                    (4.0),
        .OUT1_DIVIDE                    (1),
        .OUT2_DIVIDE                    (1),
        .OUT3_DIVIDE                    (1)
    )
    txoutclk_mmcm0_i
    (
        .CLKFBOUT                       (),
        .CLK0_OUT                       (gtx0_txusrclk2_i),
        .CLK1_OUT                       (),
        .CLK2_OUT                       (),
        .CLK3_OUT                       (),
        .CLK_IN                         (gtx0_txoutclk_i),
        .MMCM_LOCKED_OUT                (txoutclk_mmcm0_locked_i),
        .MMCM_RESET_IN                  (txoutclk_mmcm0_reset_i)
    );


    BUFG rxrecclk_bufg1_i
    (
        .I                              (gtx0_rxrecclk_i),
        .O                              (gtx0_rxusrclk2_i)
    );


    BUFG rxrecclk_bufg2_i
    (
        .I                              (gtx1_rxrecclk_i),
        .O                              (gtx1_rxusrclk2_i)
    );






    //--------------------------- The GTX Wrapper -----------------------------
    
    // Use the instantiation template in the example directory to add the GTX wrapper to your design.
    // In this example, the wrapper is wired up for basic operation with a frame generator and frame 
    // checker. The GTXs will reset, then attempt to align and transmit data. If channel bonding is 
    // enabled, bonding should occur after alignment.
    
    v6_gtxwizard_v1_12 #
    (
        .WRAPPER_SIM_GTXRESET_SPEEDUP   (1)
    )
    v6_gtxwizard_v1_12_i
    (
 
 

        //_____________________________________________________________________
        //_____________________________________________________________________
        //GTX0  (X0Y4)
        //---------------------- Loopback and Powerdown Ports ----------------------
        .GTX0_LOOPBACK_IN               (gtx0_loopback_i),
        //--------------------- Receive Ports - 8b10b Decoder ----------------------
        .GTX0_RXCHARISCOMMA_OUT         (gtx0_rxchariscomma_i),
        .GTX0_RXCHARISK_OUT             (gtx0_rxcharisk_i),
        .GTX0_RXDISPERR_OUT             (gtx0_rxdisperr_i),
        .GTX0_RXNOTINTABLE_OUT          (gtx0_rxnotintable_i),
        //----------------- Receive Ports - Clock Correction Ports -----------------
        .GTX0_RXCLKCORCNT_OUT           (gtx0_rxclkcorcnt_i),
        //------------- Receive Ports - Comma Detection and Alignment --------------
        .GTX0_RXCOMMADET_OUT            (gtx0_rxcommadet_i),
        .GTX0_RXENMCOMMAALIGN_IN        (1'b1),
        .GTX0_RXENPCOMMAALIGN_IN        (1'b1),
        //----------------- Receive Ports - RX Data Path interface -----------------
        .GTX0_RXDATA_OUT                (gtx0_rxdata_i),
        .GTX0_RXRECCLK_OUT              (gtx0_rxrecclk_i),
        .GTX0_RXUSRCLK2_IN              (gtx0_rxusrclk2_i),
        //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
        .GTX0_RXEQMIX_IN                (gtx0_rxeqmix_i),
        .GTX0_RXN_IN                    (RXN_IN[0]),
        .GTX0_RXP_IN                    (RXP_IN[0]),
        //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
        .GTX0_RXBUFSTATUS_OUT           (gtx0_rxbufstatus_i),
        //---------------------- Receive Ports - RX PLL Ports ----------------------
        .GTX0_GTXRXRESET_IN             (gtx0_gtxrxreset_i),
        .GTX0_MGTREFCLKRX_IN            (q1_clk0_refclk_i),
        .GTX0_PLLRXRESET_IN             (gtx0_pllrxreset_i),
        .GTX0_RXPLLLKDET_OUT            (gtx0_rxplllkdet_i),
        .GTX0_RXRESETDONE_OUT           (gtx0_rxresetdone_i),
        //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
        .GTX0_TXCHARISK_IN              (gtx0_txcharisk_i),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .GTX0_TXDATA_IN                 (gtx0_txdata_i),
        .GTX0_TXOUTCLK_OUT              (gtx0_txoutclk_i),
        .GTX0_TXUSRCLK2_IN              (gtx0_txusrclk2_i),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .GTX0_TXDIFFCTRL_IN             (gtx0_txdiffctrl_i),
        .GTX0_TXN_OUT                   (TXN_OUT[0]),
        .GTX0_TXP_OUT                   (TXP_OUT[0]),
        .GTX0_TXPOSTEMPHASIS_IN         (gtx0_txpostemphasis_i),
        //------------- Transmit Ports - TX Driver and OOB signalling --------------
        .GTX0_TXPREEMPHASIS_IN          (gtx0_txpreemphasis_i),
        //------ Transmit Ports - TX Elastic Buffer and Phase Alignment Ports ------
        .GTX0_TXDLYALIGNDISABLE_IN      (gtx0_txdlyaligndisable_i),
        .GTX0_TXDLYALIGNMONENB_IN       (gtx0_txdlyalignmonenb_i),
        .GTX0_TXDLYALIGNMONITOR_OUT     (gtx0_txdlyalignmonitor_i),
        .GTX0_TXDLYALIGNRESET_IN        (gtx0_txdlyalignreset_i),
        .GTX0_TXENPMAPHASEALIGN_IN      (gtx0_txenpmaphasealign_i),
        .GTX0_TXPMASETPHASE_IN          (gtx0_txpmasetphase_i),
        //--------------------- Transmit Ports - TX PLL Ports ----------------------
        .GTX0_GTXTXRESET_IN             (gtx0_gtxtxreset_i),
        .GTX0_TXRESETDONE_OUT           (gtx0_txresetdone_i),


 
 

        //_____________________________________________________________________
        //_____________________________________________________________________
        //GTX1  (X0Y5)
        //---------------------- Loopback and Powerdown Ports ----------------------
        .GTX1_LOOPBACK_IN               (gtx1_loopback_i),
        //--------------------- Receive Ports - 8b10b Decoder ----------------------
        .GTX1_RXCHARISCOMMA_OUT         (gtx1_rxchariscomma_i),
        .GTX1_RXCHARISK_OUT             (gtx1_rxcharisk_i),
        .GTX1_RXDISPERR_OUT             (gtx1_rxdisperr_i),
        .GTX1_RXNOTINTABLE_OUT          (gtx1_rxnotintable_i),
        //----------------- Receive Ports - Clock Correction Ports -----------------
        .GTX1_RXCLKCORCNT_OUT           (gtx1_rxclkcorcnt_i),
        //------------- Receive Ports - Comma Detection and Alignment --------------
        .GTX1_RXCOMMADET_OUT            (gtx1_rxcommadet_i),
        .GTX1_RXENMCOMMAALIGN_IN        (1'b1),
        .GTX1_RXENPCOMMAALIGN_IN        (1'b1),
        //----------------- Receive Ports - RX Data Path interface -----------------
        .GTX1_RXDATA_OUT                (gtx1_rxdata_i),
        .GTX1_RXRECCLK_OUT              (gtx1_rxrecclk_i),
        .GTX1_RXUSRCLK2_IN              (gtx1_rxusrclk2_i),
        //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
        .GTX1_RXEQMIX_IN                (gtx1_rxeqmix_i),
        .GTX1_RXN_IN                    (RXN_IN[1]),
        .GTX1_RXP_IN                    (RXP_IN[1]),
        //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
        .GTX1_RXBUFSTATUS_OUT           (gtx1_rxbufstatus_i),
        //---------------------- Receive Ports - RX PLL Ports ----------------------
        .GTX1_GTXRXRESET_IN             (gtx1_gtxrxreset_i),
        .GTX1_MGTREFCLKRX_IN            (q1_clk0_refclk_i),
        .GTX1_PLLRXRESET_IN             (gtx1_pllrxreset_i),
        .GTX1_RXPLLLKDET_OUT            (gtx1_rxplllkdet_i),
        .GTX1_RXRESETDONE_OUT           (gtx1_rxresetdone_i),
        //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
        .GTX1_TXCHARISK_IN              (gtx1_txcharisk_i),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .GTX1_TXDATA_IN                 (gtx1_txdata_i),
        .GTX1_TXOUTCLK_OUT              (gtx1_txoutclk_i),
        .GTX1_TXUSRCLK2_IN              (gtx0_txusrclk2_i),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .GTX1_TXDIFFCTRL_IN             (gtx1_txdiffctrl_i),
        .GTX1_TXN_OUT                   (TXN_OUT[1]),
        .GTX1_TXP_OUT                   (TXP_OUT[1]),
        .GTX1_TXPOSTEMPHASIS_IN         (gtx1_txpostemphasis_i),
        //------------- Transmit Ports - TX Driver and OOB signalling --------------
        .GTX1_TXPREEMPHASIS_IN          (gtx1_txpreemphasis_i),
        //------ Transmit Ports - TX Elastic Buffer and Phase Alignment Ports ------
        .GTX1_TXDLYALIGNDISABLE_IN      (gtx1_txdlyaligndisable_i),
        .GTX1_TXDLYALIGNMONENB_IN       (gtx1_txdlyalignmonenb_i),
        .GTX1_TXDLYALIGNMONITOR_OUT     (gtx1_txdlyalignmonitor_i),
        .GTX1_TXDLYALIGNRESET_IN        (gtx1_txdlyalignreset_i),
        .GTX1_TXENPMAPHASEALIGN_IN      (gtx1_txenpmaphasealign_i),
        .GTX1_TXPMASETPHASE_IN          (gtx1_txpmasetphase_i),
        //--------------------- Transmit Ports - TX PLL Ports ----------------------
        .GTX1_GTXTXRESET_IN             (gtx1_gtxtxreset_i),
        .GTX1_TXRESETDONE_OUT           (gtx1_txresetdone_i)


    );






    //---------------------------- TXSYNC module ------------------------------
    // The TXSYNC module performs phase synchronization for all the active TX datapaths. It
    // waits for the user clocks to be stable, then drives the phase align signals on each
    // GTX. When phase synchronization is complete, it asserts SYNC_DONE
    
    // Include the TX_SYNC module in your own design to perform phase synchronization if
    // your protocol bypasses the TX Buffers
  

   
    


    //------------------------ User Module Resets -----------------------------
    // All the User Modules i.e. FRAME_GEN, FRAME_CHECK and the sync modules
    // are held in reset till the RESETDONE goes high. 
    // The RESETDONE is registered a couple of times on *USRCLK2 and connected 
    // to the reset of the modules
    

    always @(posedge gtx0_rxusrclk2_i)
            gtx0_rxresetdone_i_r   <=   `DLY gtx0_rxresetdone_i;

    always @(posedge gtx0_rxusrclk2_i or negedge gtx0_rxresetdone_i_r)

    begin
        if (!gtx0_rxresetdone_i_r)
        begin
            gtx0_rxresetdone_r      <=   `DLY 1'b0;
            gtx0_rxresetdone_r2     <=   `DLY 1'b0;
        end
        else
        begin
            gtx0_rxresetdone_r      <=   `DLY gtx0_rxresetdone_i_r;
            gtx0_rxresetdone_r2     <=   `DLY gtx0_rxresetdone_r;
        end
    end

    always @(posedge gtx0_rxusrclk2_i)
            gtx0_rxresetdone_r3   <=   `DLY gtx0_rxresetdone_r2;
    
    
    always @(posedge gtx0_txusrclk2_i or negedge gtx0_txresetdone_i)

    begin
        if (!gtx0_txresetdone_i)
        begin
            gtx0_txresetdone_r    <=   `DLY 1'b0;
            gtx0_txresetdone_r2   <=   `DLY 1'b0;
        end
        else
        begin
            gtx0_txresetdone_r    <=   `DLY gtx0_txresetdone_i;
            gtx0_txresetdone_r2   <=   `DLY gtx0_txresetdone_r;
        end
    end

    always @(posedge gtx1_rxusrclk2_i)
            gtx1_rxresetdone_i_r   <=   `DLY gtx1_rxresetdone_i;

    always @(posedge gtx1_rxusrclk2_i or negedge gtx1_rxresetdone_i_r)

    begin
        if (!gtx1_rxresetdone_i_r)
        begin
            gtx1_rxresetdone_r      <=   `DLY 1'b0;
            gtx1_rxresetdone_r2     <=   `DLY 1'b0;
        end
        else
        begin
            gtx1_rxresetdone_r      <=   `DLY gtx1_rxresetdone_i_r;
            gtx1_rxresetdone_r2     <=   `DLY gtx1_rxresetdone_r;
        end
    end

    always @(posedge gtx1_rxusrclk2_i)
            gtx1_rxresetdone_r3   <=   `DLY gtx1_rxresetdone_r2;
    
    
    always @(posedge gtx0_txusrclk2_i or negedge gtx1_txresetdone_i)

    begin
        if (!gtx1_txresetdone_i)
        begin
            gtx1_txresetdone_r    <=   `DLY 1'b0;
            gtx1_txresetdone_r2   <=   `DLY 1'b0;
        end
        else
        begin
            gtx1_txresetdone_r    <=   `DLY gtx1_txresetdone_i;
            gtx1_txresetdone_r2   <=   `DLY gtx1_txresetdone_r;
        end
    end



    //---------------------------- Frame Generators ---------------------------
    // The example design uses Block RAM based frame generators to provide test
    // data to the GTXs for transmission. By default the frame generators are 
    // loaded with an incrementing data sequence that includes commas/alignment
    // characters for alignment. If your protocol uses channel bonding, the 
    // frame generator will also be preloaded with a channel bonding sequence.
    
    // You can modify the data transmitted by changing the INIT values of the frame
    // generator in this file. Pay careful attention to bit order and the spacing
    // of your control and alignment characters.

    // FRAME_GEN 
    // gtx0_frame_gen
    // (
        // // User Interface
        // .TX_DATA                        (gtx0_txdata_i),
    
    
        // .TX_CHARISK                     (gtx0_txcharisk_i),
    
        // // System Interface
        // .USER_CLK                       (gtx0_txusrclk2_i),
        // .SYSTEM_RESET                   (gtx0_tx_system_reset_c)
    // );

	
	always @ (posedge gtx0_txusrclk2_i )
	begin 
		gtx0_txdata_i <= DataSend;
		gtx0_txcharisk_i <= {1'b0,DataSendIsK};
		gtx1_txdata_i <= DataSend;
		gtx1_txcharisk_i <= {1'b0,DataSendIsK};
	end 

	assign  DataSendCLK = gtx0_txusrclk2_i;
	
    // FRAME_GEN gtx1_frame_gen
    // (
        // // User Interface
        // .TX_DATA                        (gtx1_txdata_i),
    
    
        // .TX_CHARISK                     (gtx1_txcharisk_i),
    
        // // System Interface
        // .USER_CLK                       (gtx0_txusrclk2_i),
        // .SYSTEM_RESET                   (gtx1_tx_system_reset_c)
    // );


    //-------------------------------- Frame Checkers -------------------------
    // The example design uses Block RAM based frame checkers to verify incoming  
    // data. By default the frame generators are loaded with a data sequence that 
    // matches the outgoing sequence of the frame generators for the TX ports.
    
    // You can modify the expected data sequence by changing the INIT values of the frame
    // checkers in this file. Pay careful attention to bit order and the spacing
    // of your control and alignment characters.
    
    // When the frame checker receives data, it attempts to synchronise to the 
    // incoming pattern by looking for the first sequence in the pattern. Once it 
    // finds the first sequence, it increments through the sequence, and indicates an 
    // error whenever the next value received does not match the expected value.




    // gtx0_frame_check0 is always connected to the lane with the start of char
    // and this lane starts off the data checking on all the other lanes. The INC_IN port is tied off
    assign gtx0_inc_in_i = 1'b0;

 
    FRAME_CHECK 
    gtx0_frame_check
    (
        // MGT Interface
        .RX_DATA_IN                     (gtx0_rxdata_i),
        .RXCTRL_IN                      (gtx0_rxcharisk_i),
        .ErrorCount                     (gtx0_ErrorCount),
		
		.tx_data_r3                (DataRev_CH1),
		.tx_charisk                (CharisK_CH1),
		
        // System Interface
        .USER_CLK                       (gtx0_rxusrclk2_i),
        .SYSTEM_RESET                   (gtx0_rx_system_reset_c)



    );

    


    // in the "independent lanes" configuration, each of the lanes looks for the unique start char and
    // in this case, the INC_IN port is tied off.
    // Else, the data checking is triggered by the "master" lane


 
    FRAME_CHECK
    gtx1_frame_check
    (
        // MGT Interface
        .RX_DATA_IN                     (gtx1_rxdata_i),
        .RXCTRL_IN                      (gtx1_rxcharisk_i),
        .ErrorCount                     (gtx1_ErrorCount), 

		.tx_data_r3                (DataRev_CH2),
		.tx_charisk                (CharisK_CH2),
		
        // System Interface
        .USER_CLK                       (gtx1_rxusrclk2_i),
        .SYSTEM_RESET                   (gtx1_rx_system_reset_c)

    );

    
  assign DataCLK_CH1 = gtx0_rxusrclk2_i;
  assign DataCLK_CH2 = gtx1_rxusrclk2_i;







endmodule 

