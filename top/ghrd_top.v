// ============================================================================
// Copyright (c) 2016 by Arrow Electronics, Inc.
// ============================================================================
//
// Permission:
//
//   Arrow grants permission to use and modify this code for use
//   in synthesis for all Arrow Development Boards. Other use of this code, 
//	  including the selling, duplication, or modification of any portion is 
//   strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.  It is
//   the user's responsibility to verify their design for consistency and
//   functionality through the use of formal verification methods.  Arrow 
//   provides no warranty regarding the use or functionality of this code.
//
// ============================================================================
//           
//  Arrow Technologies Inc
//  Englewood, CO. USA
//  
//  
//                     web: http://www.Arrow.com/  
//                     
//
// ============================================================================
// Date:  July 19, 2016
// ============================================================================
//
// ============================================================================
// Revision Change list:
// ============================================================================
//
// soc_system_20160719
//
//	Initial release
//	
//
// ============================================================================
// Qsys System :
// ============================================================================
//
// Description: 
//
//		To view the Qsys system open Qsys and select soc_system.qsys.
//		This system mimics the Altera Development kit GHRD design. The system
//		console script, "ghrd_sc_script.tcl", which can be found in this projects  
//		root directory, is identical to the Altera script and will implement all 
//		the functionality described in the GHRD Users Guide. 
//
// ============================================================================

`include "top/config_soc.v"

// With the exception of HPS SDRAM pins, all HPS and FPGA top level pin names 
// match those of the official 96 Boards schematic net names for easy cross
// reference to the schematic.

module ghrd_top (

// ****************************************************************************
// *************************      HPS Interface       *************************
// ****************************************************************************

// HPS SDRAM
	output [14:0]  memory_mem_a,
	output [2:0]   memory_mem_ba,
	output         memory_mem_ck,
	output         memory_mem_ck_n,
	output         memory_mem_cke,
	output         memory_mem_cs_n,
	output         memory_mem_ras_n,
	output         memory_mem_cas_n,
	output         memory_mem_we_n,
	output         memory_mem_reset_n,
	inout  [15:0]  memory_mem_dq,
	inout  [1:0]   memory_mem_dqs,
	inout  [1:0]   memory_mem_dqs_n,
	output         memory_mem_odt,
	output [1:0]   memory_mem_dm,
	input          memory_oct_rzqin,

// HPS SD Card
   output         CV_HPS_3V3_SDMMC_CLK,
   inout          CV_HPS_3V3_SDMMC_CMD,
   inout          CV_HPS_3V3_SDMMC_D0,
   inout          CV_HPS_3V3_SDMMC_D1,
   inout          CV_HPS_3V3_SDMMC_D2,
   inout          CV_HPS_3V3_SDMMC_D3,
	
// HPS USB1
   input          CV_HPS_3V3_USB1_CLK_via_RGMII0_RX_CLK,
	inout          CV_HPS_3V3_USB1_D0_via_RGMII0_TXD0,
	inout          CV_HPS_3V3_USB1_D1_via_RGMII0_TXD1,
	inout          CV_HPS_3V3_USB1_D2_via_RGMII0_TXD2,
	inout          CV_HPS_3V3_USB1_D3_via_RGMII0_TXD3,
	inout          CV_HPS_3V3_USB1_D4_via_RGMII0_RXD0,
	inout          CV_HPS_3V3_USB1_D5_via_RGMII0_MDIO,
	inout          CV_HPS_3V3_USB1_D6_via_RGMII0_MDC,
	inout          CV_HPS_3V3_USB1_D7_via_RGMII0_RX_CTL,
   input          CV_HPS_3V3_USB1_DIR_via_RGMII0_RXD2,
   input          CV_HPS_3V3_USB1_NXT_via_RGMII0_RXD3,
   output         CV_HPS_3V3_USB1_STP_via_RGMII0_RXD1,


// HPS SPI M0,M1
// HPS SPI MO connects to 30x2 high speed expansion connector
	output         CV_HPS_1V8_SPIM0_CLK,
	output         CV_HPS_1V8_SPIM0_MOSI,
	input          CV_HPS_1V8_SPIM0_MISO,
	output         CV_HPS_1V8_SPIM0_SS0,
// HPS SPI M1 connects to 20x2 low speed expansion connector
	output         CV_HPS_1V8_SPIM1_CLK_via_I2C0_SDA,
	output         CV_HPS_1V8_SPIM1_MOSI_via_I2C0_SCL,
	input          CV_HPS_1V8_SPIM1_MISO_via_CAN0_RX,
	output         CV_HPS_1V8_SPIM1_SS0_via_CAN0_TX,

// HPS UART0
// UART0 can connect to either the 3 pin terminal used during Linux boot,
// or to the 20x2 low speed expansion connector, but not both simultaneously.
// This requires reconfiguration of the peripheral set through Qsys.  The
// default GHRD configuration connects to the 3 pin terminal header and those
// schematic net names are used here.
	input          CV_HPS_1V8_UART0_RX,
	output         CV_HPS_1V8_UART0_TX,

// HPS I2C 1,2,3
// HPS I2C0 and I2C1 connects to 20x2 low speed expansion connector
	inout          CV_HPS_1V8_I2C0_SCL_via_TRACE_D7,
	inout          CV_HPS_1V8_I2C0_SDA_via_TRACE_D6,
	inout          CV_HPS_1V8_I2C1_SCL_via_TRACE_D3,
	inout          CV_HPS_1V8_I2C1_SDA_via_TRACE_D2,
// HPS I2C3 connects to 30x2 high speed expansion connector
	inout          CV_HPS_1V8_I2C3_SCL_via_NAND_DQ2,
	inout          CV_HPS_1V8_I2C3_SDA_via_NAND_DQ1,
	
// HPS GPIO
	inout          CV_HPS_3V3_GPIO0_via_RGMII0_TX_CLK,
	inout          CV_HPS_3V3_GPIO9_via_RGMII0_TX_CTL,
	inout          CV_HPS_1V8_GPIO14_via_NAND_ALE,      // Green User LED D5
	inout          CV_HPS_1V8_GPIO15_via_NAND_CE,
	inout          CV_HPS_1V8_GPIO16_via_NAND_CLE,
	inout          CV_HPS_1V8_GPIO17_via_NAND_RE,
	inout          CV_HPS_1V8_GPIO18_via_NAND_RB,
	inout          CV_HPS_1V8_GPIO19_via_NAND_DQ0,
	inout          CV_HPS_1V8_GPIO22_via_NAND_DQ3,      // Green User LED D6
	inout          CV_HPS_1V8_GPIO23_via_NAND_DQ4,
	inout          CV_HPS_1V8_GPIO24_via_NAND_DQ5,
	inout          CV_HPS_1V8_GPIO25_via_NAND_DQ6,      // Green User LED D7
	inout          CV_HPS_1V8_GPIO26_via_NAND_DQ7,
	inout          CV_HPS_1V8_GPIO27_via_NAND_WP,
	inout          CV_HPS_1V8_GPIO28_via_NAND_WE,
	inout          CV_HPS_1V8_GPIO29_via_QSPI_IO0,
	inout          CV_HPS_1V8_GPIO30_via_QSPI_IO1,
	inout          CV_HPS_1V8_GPIO31_via_QSPI_IO2,
	inout          CV_HPS_1V8_GPIO32_via_QSPI_IO3,      // Green User LED D8
	inout          CV_HPS_1V8_GPIO33_via_QSPI_SS0,
	inout          CV_HPS_1V8_GPIO34_via_QSPI_CLK,
 	inout          CV_HPS_3V3_GPIO37_via_SDMMC_PWREN,
	inout          CV_HPS_3V3_GPIO44_via_SDMMC_FB_CLK_IN,
	inout          CV_HPS_1V8_GPIO48_via_TRACE_CLK,
//	inout          hps_gpio_GPIO50,
	inout          CV_HPS_1V8_GPIO53_via_TRACE_D4,
	inout          CV_HPS_1V8_GPIO54_via_TRACE_D5,


// ********************************************************************
// **********************     FPGA Interface     **********************
// ********************************************************************

//   output        [23:19] hdmi_r,		// Red   (VPC on TDA19988)
//   output        [15:10] hdmi_g,		// Green (VPB on TDA19988)
//   output        [7:3]   hdmi_b,		// Blue  (VPA on TDA19988)
//   output        hdmi_clk,				// Video Clock
//   output        hdmi_hs,				// Horizontal Synch
//   output        hdmi_vs,				// Vertical Synch   	   	
//   output        hdmi_en,			   // 
//
//   output        hdmi_i2s_txfs,	   // Composite Synch Control  	
//   output        hdmi_i2s_txd,      //
//   output        hdmi_i2s_mclk,     //
//   output        hdmi_i2s_txc,      //
//
////	output        hps_i2c2_hdmi_clk,       //
//	inout         hps_i2c2_hdmi_scl,       //
////	output        hps_i2c2_hdmi_out_data,  //
//	inout         hps_i2c2_hdmi_sda        //
	


`ifdef hdmi
// TDA19988 HDMI transmitter signals
// Due to limited I/O pins on the FPGA, a 5-6-5 RGB format is used to
// interface to the TDA19988 data inputs.  Only 16 of the 24 bits are
// used.
   output         CV_FPGA_1V8_LCD_CLK,
   output         CV_FPGA_1V8_LCD_ENABLE,
   output         CV_FPGA_1V8_LCD_HSYNC,
   output         CV_FPGA_1V8_LCD_VSYNC,

// output [23:0]  CV_FPGA_1V8_LCD_DAT,
// output [23:19] CV_FPGA_1V8_LCD_DAT,   // Red   (VPC on TDA19988)
// output [15:10] CV_FPGA_1V8_LCD_DAT,   // Green (VPB on TDA19988)
// output [7:3 ]  CV_FPGA_1V8_LCD_DAT,   // Blue  (VPA on TDA19988)

   output         CV_FPGA_1V8_LCD_DAT23, // Red [23:19]
   output         CV_FPGA_1V8_LCD_DAT22,
   output         CV_FPGA_1V8_LCD_DAT21,
   output         CV_FPGA_1V8_LCD_DAT20,
   output         CV_FPGA_1V8_LCD_DAT19,
   output         CV_FPGA_1V8_LCD_DAT15, // Blue [15:10]
   output         CV_FPGA_1V8_LCD_DAT14,
   output         CV_FPGA_1V8_LCD_DAT13,
   output         CV_FPGA_1V8_LCD_DAT12,
   output         CV_FPGA_1V8_LCD_DAT11,
   output         CV_FPGA_1V8_LCD_DAT10,
   output         CV_FPGA_1V8_LCD_DAT7,  // Green [7:3]
   output         CV_FPGA_1V8_LCD_DAT6,
   output         CV_FPGA_1V8_LCD_DAT5,
   output         CV_FPGA_1V8_LCD_DAT4,
   output         CV_FPGA_1V8_LCD_DAT3,

   inout          CV_HPS_1V8_I2C2_SCL_via_FPGA, // HDMI I2C clock
   inout          CV_HPS_1V8_I2C2_SDA_via_FPGA, // HDMI I2C data

   output         CV_FPGA_1V8_I2S1_TXC,  // Audio clock
   output         CV_FPGA_1V8_I2S1_TXFS, // Audio port 0
   output         CV_FPGA_1V8_I2S1_TXD,  // Audio port 1
   output         CV_FPGA_1V8_I2S1_MCLK, // Audio port 3 / clock

`endif

`ifdef wifi_bt
// WiFi/Bluetooth module signals
   output         CV_FPGA_1V8_RF_SD_CLK,
   inout          CV_FPGA_1V8_RF_SD_CMD,
   inout          CV_FPGA_1V8_RF_SD_DATA0,
   inout          CV_FPGA_1V8_RF_SD_DATA1,
   inout          CV_FPGA_1V8_RF_SD_DATA2,
   inout          CV_FPGA_1V8_RF_SD_DATA3,
   input          CV_FPGA_1V8_RF_UART_CTS,
   output         CV_FPGA_1V8_RF_UART_RTS,
   input          CV_FPGA_1V8_RF_UART_RXD,
   output         CV_FPGA_1V8_RF_UART_TXD,
   input          CV_FPGA_1V8_I2S2_RXD,     // BT PCM serial data output from module
   output         CV_FPGA_1V8_I2S2_TXC,     // BT PCM bit clock to module
   output         CV_FPGA_1V8_I2S2_TXD,     // BT PCM serial data input to module
   output         CV_FPGA_1V8_I2S2_TXFS,    // BT PCM word clock/sync input to module
   input          CV_FPGA_1V8_BT_HOST_WAKE, // BT host wake or GPIO from module
   output         CV_HPS_2V5_GPIO_LED_RF1_via_FPGA,
   output         CV_HPS_2V5_GPIO_LED_RF2_via_FPGA,

`endif

`ifdef connector_30x2
// 30x2 high speed expansion connector signals connected via FPGA
// MIPI CSI-2 interfaces
   input          CV_FPGA_MIPI_CSI_CLK_P,
   input          CV_FPGA_MIPI_CSI_CLK_N,
   input          CV_FPGA_MIPI_CSI_D0_P,
   input          CV_FPGA_MIPI_CSI_D0_N,
   input          CV_FPGA_MIPI_CSI_D1_P,
   input          CV_FPGA_MIPI_CSI_D1_N,

   input          CV_FPGA_MIPI_CSI_CLK_P_LP,
   input          CV_FPGA_MIPI_CSI_CLK_N_LP,
   input          CV_FPGA_MIPI_CSI_D0_P_LP,
   input          CV_FPGA_MIPI_CSI_D0_N_LP,
   input          CV_FPGA_MIPI_CSI_D1_P_LP,
   input          CV_FPGA_MIPI_CSI_D1_N_LP,

   output         CV_FPGA_1V8_CSI_MCLK,  // CSI reference clock, per 96Board spec

`endif

`ifdef connector_20x2
// 20x2 low speed expansion connector signals
   input          CV_HPS_1V8_UART1_CTS_via_FPGA,
   output         CV_HPS_1V8_UART1_RTS_via_FPGA,
   input          CV_HPS_1V8_UART1_RX_via_FPGA,
   output         CV_HPS_1V8_UART1_TX_via_FPGA,
   input          CV_FPGA_1V8_I2S3_RXD,          // I2S/PCM serial data input
   output         CV_FPGA_1V8_I2S3_TXC,          // I2S/PCM bit clock
   output         CV_FPGA_1V8_I2S3_TXD,          // I2S/PCM serial data output
   output         CV_FPGA_1V8_I2S3_TXFS          // I2S/PCM word clock

`endif
   
);
    
// internal wires and registers declaration
   wire [3:0]  fpga_led_internal;
	wire        h2f_user0_clock;
   wire        hps_fpga_reset_n;
   wire [2:0]  hps_reset_req;
   wire        hps_cold_reset;
   wire        hps_warm_reset;
   wire        hps_debug_reset;
//   wire [27:0] stm_hw_events;
	
   wire        pixel_clk;
   wire [7:0]  vid_r,vid_g,vid_b;
   wire        vid_v_sync;
   wire        vid_h_sync;
   wire        vid_datavalid;

// Loan I/O for driver User LEDs via FPGA (Qsys PIO)
//	wire [66:0]	loan_io_in;
//	wire [66:0]	loan_io_out;
//	wire [66:0]	loan_io_oe;
	
// i2c2 connections through FPGA for TDA19988
	wire scl_o_e;
   wire scl_o;
   wire sda_o_e;
   wire sda_o;
	
// sdio connections for WiFi/BLE module
	wire sd_cmd_i;
	wire sd_cmd_o;
	wire sd_cmd_oe_o;
	wire sd_data0_i;
	wire sd_data1_i;
	wire sd_data2_i;
	wire sd_data3_i;
	wire sd_data0_o;
	wire sd_data1_o;
	wire sd_data2_o;
	wire sd_data3_o;
	wire sd_data_oe_o;

// connection of internal logic
//  assign user_led_fpga = ~fpga_led_internal;
//  assign user_led_fpga = fpga_led_internal;
//  assign stm_hw_events    = {{18{1'b0}}, user_dipsw_fpga, fpga_led_internal, user_pb_fpga};
//  assign stm_hw_events    = {{24{1'b0}}, fpga_led_internal};
//  assign stm_hw_events    = {{24{1'b0}},{4{1'b1}}};

	

   assign CV_FPGA_1V8_LCD_CLK = pixel_clk;

   assign CV_FPGA_1V8_LCD_ENABLE = vid_datavalid;
   assign CV_FPGA_1V8_LCD_HSYNC = vid_h_sync;
   assign CV_FPGA_1V8_LCD_VSYNC = vid_v_sync;
   assign CV_FPGA_1V8_LCD_DAT23 = vid_r[7]; // Red [23:19]
   assign CV_FPGA_1V8_LCD_DAT22 = vid_r[6];
   assign CV_FPGA_1V8_LCD_DAT21 = vid_r[5];
   assign CV_FPGA_1V8_LCD_DAT20 = vid_r[4];
   assign CV_FPGA_1V8_LCD_DAT19 = vid_r[3];
   assign CV_FPGA_1V8_LCD_DAT15 = vid_b[7]; // Blue [15:10]
   assign CV_FPGA_1V8_LCD_DAT14 = vid_b[6];
   assign CV_FPGA_1V8_LCD_DAT13 = vid_b[5];
   assign CV_FPGA_1V8_LCD_DAT12 = vid_b[4];
   assign CV_FPGA_1V8_LCD_DAT11 = vid_b[3];
   assign CV_FPGA_1V8_LCD_DAT10 = vid_b[2];
   assign CV_FPGA_1V8_LCD_DAT7  = vid_g[7]; // Green [7:3]
   assign CV_FPGA_1V8_LCD_DAT6  = vid_g[6];
   assign CV_FPGA_1V8_LCD_DAT5  = vid_g[5];
   assign CV_FPGA_1V8_LCD_DAT4  = vid_g[4];
   assign CV_FPGA_1V8_LCD_DAT3  = vid_g[3];

// Loan I/O for driver User LEDs via FPGA (Qsys PIO)	
// To enable this, open Qsys, edit HPS component -> Peripheral Pins tab,
// scroll down to Peripheral Mux Table and enable LOANIO14, LOANIO22, LOANIO25, LOANIO32,
// uncomment loanio wires above,next 2 lines below, and lines in Qsys system component declaration below.

//	assign loan_io_out = {{34{1'b0}},~fpga_led_internal[3],{6{1'b0}},~fpga_led_internal[2],{2{1'b0}},~fpga_led_internal[1],{7{1'b0}},~fpga_led_internal[0],{14{1'b0}}};
//	assign loan_io_oe  = {{34{1'b0}},{1'b1}               ,{6{1'b1}},{1'b1}               ,{2{1'b0}},{1'b1}               ,{7{1'b0}},{1'b1}               ,{14{1'b0}}};

  
   ALT_IOBUF scl_iobuf (.i(1'b0), .oe(scl_o_e), .o(scl_o), .io(CV_HPS_1V8_I2C2_SCL_via_FPGA)); //declared bi-directional buffer for scl
   ALT_IOBUF sda_iobuf (.i(1'b0), .oe(sda_o_e), .o(sda_o), .io(CV_HPS_1V8_I2C2_SDA_via_FPGA)); //declared bi-directional buffer for sda

   ALT_IOBUF sd_cmd   (.i(sd_cmd_i), .oe(sd_cmd_oe_o),  .o(sd_cmd_o), .io(CV_FPGA_1V8_RF_SD_CMD)); //declared bi-directional buffer for sd_cmd
   ALT_IOBUF sd_data0 (.i(sd_data0_i), .oe(sd_data_oe_o), .o(sd_data0_o), .io(CV_FPGA_1V8_RF_SD_DATA0)); //declared bi-directional buffer for sd_data0
   ALT_IOBUF sd_data1 (.i(sd_data1_i), .oe(sd_data_oe_o), .o(sd_data1_o), .io(CV_FPGA_1V8_RF_SD_DATA1)); //declared bi-directional buffer for sd_data1
   ALT_IOBUF sd_data2 (.i(sd_data2_i), .oe(sd_data_oe_o), .o(sd_data2_o), .io(CV_FPGA_1V8_RF_SD_DATA2)); //declared bi-directional buffer for sd_data2
   ALT_IOBUF sd_data3 (.i(sd_data3_i), .oe(sd_data_oe_o), .o(sd_data3_o), .io(CV_FPGA_1V8_RF_SD_DATA3)); //declared bi-directional buffer for sd_data3
	
// Test to see that the FPGA got programmed
// assign CV_HPS_2V5_GPIO_LED_RF1_via_FPGA = 1'b1;
//	assign CV_HPS_2V5_GPIO_LED_RF2_via_FPGA = 1'b1;
	 
	soc_system u0 (
		.memory_mem_a                                 (memory_mem_a),                          //                          memory.mem_a
		.memory_mem_ba                                (memory_mem_ba),                         //                                .mem_ba
		.memory_mem_ck                                (memory_mem_ck),                         //                                .mem_ck
		.memory_mem_ck_n                              (memory_mem_ck_n),                       //                                .mem_ck_n
		.memory_mem_cke                               (memory_mem_cke),                        //                                .mem_cke
		.memory_mem_cs_n                              (memory_mem_cs_n),                       //                                .mem_cs_n
		.memory_mem_ras_n                             (memory_mem_ras_n),                      //                                .mem_ras_n
		.memory_mem_cas_n                             (memory_mem_cas_n),                      //                                .mem_cas_n
		.memory_mem_we_n                              (memory_mem_we_n),                       //                                .mem_we_n
		.memory_mem_reset_n                           (memory_mem_reset_n),                    //                                .mem_reset_n
		.memory_mem_dq                                (memory_mem_dq),                         //                                .mem_dq
		.memory_mem_dqs                               (memory_mem_dqs),                        //                                .mem_dqs
		.memory_mem_dqs_n                             (memory_mem_dqs_n),                      //                                .mem_dqs_n
		.memory_mem_odt                               (memory_mem_odt),                        //                                .mem_odt
		.memory_mem_dm                                (memory_mem_dm),                         //                                .mem_dm
		.memory_oct_rzqin                             (memory_oct_rzqin),                      //                                .oct_rzqin
		.hps_0_hps_io_hps_io_sdio_inst_CMD            (CV_HPS_3V3_SDMMC_CMD),                  //                    hps_0_hps_io.hps_io_sdio_inst_CMD
		.hps_0_hps_io_hps_io_sdio_inst_D0             (CV_HPS_3V3_SDMMC_D0),                   //                                .hps_io_sdio_inst_D0
		.hps_0_hps_io_hps_io_sdio_inst_D1             (CV_HPS_3V3_SDMMC_D1),                   //                                .hps_io_sdio_inst_D1
		.hps_0_hps_io_hps_io_sdio_inst_CLK            (CV_HPS_3V3_SDMMC_CLK),                  //                                .hps_io_sdio_inst_CLK
		.hps_0_hps_io_hps_io_sdio_inst_D2             (CV_HPS_3V3_SDMMC_D2),                   //                                .hps_io_sdio_inst_D2
		.hps_0_hps_io_hps_io_sdio_inst_D3             (CV_HPS_3V3_SDMMC_D3),                   //                                .hps_io_sdio_inst_D3
		.hps_0_hps_io_hps_io_usb1_inst_D0             (CV_HPS_3V3_USB1_D0_via_RGMII0_TXD0),    //                                .hps_io_usb1_inst_D0
		.hps_0_hps_io_hps_io_usb1_inst_D1             (CV_HPS_3V3_USB1_D1_via_RGMII0_TXD1),    //                                .hps_io_usb1_inst_D1
		.hps_0_hps_io_hps_io_usb1_inst_D2             (CV_HPS_3V3_USB1_D2_via_RGMII0_TXD2),    //                                .hps_io_usb1_inst_D2
		.hps_0_hps_io_hps_io_usb1_inst_D3             (CV_HPS_3V3_USB1_D3_via_RGMII0_TXD3),    //                                .hps_io_usb1_inst_D3
		.hps_0_hps_io_hps_io_usb1_inst_D4             (CV_HPS_3V3_USB1_D4_via_RGMII0_RXD0),    //                                .hps_io_usb1_inst_D4
		.hps_0_hps_io_hps_io_usb1_inst_D5             (CV_HPS_3V3_USB1_D5_via_RGMII0_MDIO),    //                                .hps_io_usb1_inst_D5
		.hps_0_hps_io_hps_io_usb1_inst_D6             (CV_HPS_3V3_USB1_D6_via_RGMII0_MDC),     //                                .hps_io_usb1_inst_D6
		.hps_0_hps_io_hps_io_usb1_inst_D7             (CV_HPS_3V3_USB1_D7_via_RGMII0_RX_CTL),  //                                .hps_io_usb1_inst_D7
		.hps_0_hps_io_hps_io_usb1_inst_CLK            (CV_HPS_3V3_USB1_CLK_via_RGMII0_RX_CLK), //                                .hps_io_usb1_inst_CLK
		.hps_0_hps_io_hps_io_usb1_inst_STP            (CV_HPS_3V3_USB1_STP_via_RGMII0_RXD1),   //                                .hps_io_usb1_inst_STP
		.hps_0_hps_io_hps_io_usb1_inst_DIR            (CV_HPS_3V3_USB1_DIR_via_RGMII0_RXD2),   //                                .hps_io_usb1_inst_DIR
		.hps_0_hps_io_hps_io_usb1_inst_NXT            (CV_HPS_3V3_USB1_NXT_via_RGMII0_RXD3),   //                                .hps_io_usb1_inst_NXT
		.hps_0_hps_io_hps_io_spim0_inst_CLK           (CV_HPS_1V8_SPIM0_CLK),                  //                                .hps_io_spim0_inst_CLK
		.hps_0_hps_io_hps_io_spim0_inst_MOSI          (CV_HPS_1V8_SPIM0_MOSI),                 //                                .hps_io_spim0_inst_MOSI
		.hps_0_hps_io_hps_io_spim0_inst_MISO          (CV_HPS_1V8_SPIM0_MISO),                 //                                .hps_io_spim0_inst_MISO
		.hps_0_hps_io_hps_io_spim0_inst_SS0           (CV_HPS_1V8_SPIM0_SS0),                  //                                .hps_io_spim0_inst_SS0
		.hps_0_hps_io_hps_io_spim1_inst_CLK           (CV_HPS_1V8_SPIM1_CLK_via_I2C0_SDA),     //                                .hps_io_spim1_inst_CLK
		.hps_0_hps_io_hps_io_spim1_inst_MOSI          (CV_HPS_1V8_SPIM1_MOSI_via_I2C0_SCL),    //                                .hps_io_spim1_inst_MOSI
		.hps_0_hps_io_hps_io_spim1_inst_MISO          (CV_HPS_1V8_SPIM1_MISO_via_CAN0_RX),     //                                .hps_io_spim1_inst_MISO
		.hps_0_hps_io_hps_io_spim1_inst_SS0           (CV_HPS_1V8_SPIM1_SS0_via_CAN0_TX),      //                                .hps_io_spim1_inst_SS0
		.hps_0_hps_io_hps_io_uart0_inst_RX            (CV_HPS_1V8_UART0_RX),                   //                                .hps_io_uart0_inst_RX
		.hps_0_hps_io_hps_io_uart0_inst_TX            (CV_HPS_1V8_UART0_TX),                   //                                .hps_io_uart0_inst_TX
		.hps_0_hps_io_hps_io_i2c0_inst_SDA            (CV_HPS_1V8_I2C0_SDA_via_TRACE_D6),      //                                .hps_io_i2c0_inst_SDA
		.hps_0_hps_io_hps_io_i2c0_inst_SCL            (CV_HPS_1V8_I2C0_SCL_via_TRACE_D7),      //                                .hps_io_i2c0_inst_SCL
		.hps_0_hps_io_hps_io_i2c1_inst_SDA            (CV_HPS_1V8_I2C1_SDA_via_TRACE_D2),      //                                .hps_io_i2c1_inst_SDA
		.hps_0_hps_io_hps_io_i2c1_inst_SCL            (CV_HPS_1V8_I2C1_SCL_via_TRACE_D3),      //                                .hps_io_i2c1_inst_SCL
		.hps_0_hps_io_hps_io_i2c3_inst_SDA            (CV_HPS_1V8_I2C3_SDA_via_NAND_DQ1),      //                                .hps_io_i2c3_inst_SDA
		.hps_0_hps_io_hps_io_i2c3_inst_SCL            (CV_HPS_1V8_I2C3_SCL_via_NAND_DQ2),      //                                .hps_io_i2c3_inst_SCL
		.hps_0_hps_io_hps_io_gpio_inst_GPIO00         (CV_HPS_3V3_GPIO0_via_RGMII0_TX_CLK),    //                                .hps_io_gpio_inst_GPIO00
		.hps_0_hps_io_hps_io_gpio_inst_GPIO09         (CV_HPS_3V3_GPIO9_via_RGMII0_TX_CTL),    //                                .hps_io_gpio_inst_GPIO09
//		.hps_0_hps_io_hps_io_gpio_inst_GPIO14         (CV_HPS_1V8_GPIO14_via_NAND_ALE),        //                                .hps_io_gpio_inst_GPIO14
		.hps_0_hps_io_hps_io_gpio_inst_GPIO15         (CV_HPS_1V8_GPIO15_via_NAND_CE),         //                                .hps_io_gpio_inst_GPIO15
		.hps_0_hps_io_hps_io_gpio_inst_GPIO16         (CV_HPS_1V8_GPIO16_via_NAND_CLE),        //                                .hps_io_gpio_inst_GPIO16
		.hps_0_hps_io_hps_io_gpio_inst_GPIO17         (CV_HPS_1V8_GPIO17_via_NAND_RE),         //                                .hps_io_gpio_inst_GPIO17
		.hps_0_hps_io_hps_io_gpio_inst_GPIO18         (CV_HPS_1V8_GPIO18_via_NAND_RB),         //                                .hps_io_gpio_inst_GPIO18
		.hps_0_hps_io_hps_io_gpio_inst_GPIO19         (CV_HPS_1V8_GPIO19_via_NAND_DQ0),        //                                .hps_io_gpio_inst_GPIO19
//		.hps_0_hps_io_hps_io_gpio_inst_GPIO22         (CV_HPS_1V8_GPIO22_via_NAND_DQ3),        //                                .hps_io_gpio_inst_GPIO22
		.hps_0_hps_io_hps_io_gpio_inst_GPIO23         (CV_HPS_1V8_GPIO23_via_NAND_DQ4),        //                                .hps_io_gpio_inst_GPIO23
		.hps_0_hps_io_hps_io_gpio_inst_GPIO24         (CV_HPS_1V8_GPIO24_via_NAND_DQ5),        //                                .hps_io_gpio_inst_GPIO24
//		.hps_0_hps_io_hps_io_gpio_inst_GPIO25         (CV_HPS_1V8_GPIO25_via_NAND_DQ6),        //                                .hps_io_gpio_inst_GPIO25
		.hps_0_hps_io_hps_io_gpio_inst_GPIO26         (CV_HPS_1V8_GPIO26_via_NAND_DQ7),        //                                .hps_io_gpio_inst_GPIO26
		.hps_0_hps_io_hps_io_gpio_inst_GPIO27         (CV_HPS_1V8_GPIO27_via_NAND_WP),         //                                .hps_io_gpio_inst_GPIO27
		.hps_0_hps_io_hps_io_gpio_inst_GPIO28         (CV_HPS_1V8_GPIO28_via_NAND_WE),         //                                .hps_io_gpio_inst_GPIO28
		.hps_0_hps_io_hps_io_gpio_inst_GPIO29         (CV_HPS_1V8_GPIO29_via_QSPI_IO0),        //                                .hps_io_gpio_inst_GPIO29
		.hps_0_hps_io_hps_io_gpio_inst_GPIO30         (CV_HPS_1V8_GPIO30_via_QSPI_IO1),        //                                .hps_io_gpio_inst_GPIO30
		.hps_0_hps_io_hps_io_gpio_inst_GPIO31         (CV_HPS_1V8_GPIO31_via_QSPI_IO2),        //                                .hps_io_gpio_inst_GPIO31
//		.hps_0_hps_io_hps_io_gpio_inst_GPIO32         (CV_HPS_1V8_GPIO32_via_QSPI_IO3),        //                                .hps_io_gpio_inst_GPIO32
		.hps_0_hps_io_hps_io_gpio_inst_GPIO33         (CV_HPS_1V8_GPIO33_via_QSPI_SS0),        //                                .hps_io_gpio_inst_GPIO33
		.hps_0_hps_io_hps_io_gpio_inst_GPIO34         (CV_HPS_1V8_GPIO34_via_QSPI_CLK),        //                                .hps_io_gpio_inst_GPIO34
		.hps_0_hps_io_hps_io_gpio_inst_GPIO37         (CV_HPS_3V3_GPIO37_via_SDMMC_PWREN),     //                                .hps_io_gpio_inst_GPIO37
		.hps_0_hps_io_hps_io_gpio_inst_GPIO44         (CV_HPS_3V3_GPIO44_via_SDMMC_FB_CLK_IN), //                                .hps_io_gpio_inst_GPIO44
		.hps_0_hps_io_hps_io_gpio_inst_GPIO48         (CV_HPS_1V8_GPIO48_via_TRACE_CLK),       //                                .hps_io_gpio_inst_GPIO48
		.hps_0_hps_io_hps_io_gpio_inst_GPIO53         (CV_HPS_1V8_GPIO53_via_TRACE_D4),        //                                .hps_io_gpio_inst_GPIO53
		.hps_0_hps_io_hps_io_gpio_inst_GPIO54         (CV_HPS_1V8_GPIO54_via_TRACE_D5),        //                                .hps_io_gpio_inst_GPIO54
		.hps_0_hps_io_hps_io_gpio_inst_LOANIO14       (CV_HPS_1V8_GPIO14_via_NAND_ALE),        //                                .hps_io_gpio_inst_LOANIO14
		.hps_0_hps_io_hps_io_gpio_inst_LOANIO22       (CV_HPS_1V8_GPIO22_via_NAND_DQ3),        //                                .hps_io_gpio_inst_LOANIO22
		.hps_0_hps_io_hps_io_gpio_inst_LOANIO25       (CV_HPS_1V8_GPIO25_via_NAND_DQ6),        //                                .hps_io_gpio_inst_LOANIO25
		.hps_0_hps_io_hps_io_gpio_inst_LOANIO32       (CV_HPS_1V8_GPIO32_via_QSPI_IO3),        //                                .hps_io_gpio_inst_LOANIO32		
//		.hps_0_h2f_loan_io_in                         (loan_io_in),                            //               hps_0_h2f_loan_io.in
//		.hps_0_h2f_loan_io_out                        (loan_io_out),                           //                                .out
//		.hps_0_h2f_loan_io_oe                         (loan_io_oe),                            //                                .oe		
		.hps_0_i2c2_clk_via_fpga_hdmi_clk               (scl_o_e),                             //    hps_0_i2c2_clk_via_fpga_hdmi.clk
		.hps_0_i2c2_scl_in_via_fpga_hdmi_clk            (scl_o),                               // hps_0_i2c2_scl_in_via_fpga_hdmi.clk
		.hps_0_i2c2_via_fpga_hdmi_out_data              (sda_o_e),                             //        hps_0_i2c2_via_fpga_hdmi.out_data
		.hps_0_i2c2_via_fpga_hdmi_sda                   (sda_o),                               //                                .sda
		.hps_0_uart1_via_fpga_20x2_cts                  (hps_uart1_20x2_ctss),                 //       hps_0_uart1_via_fpga_20x2.cts
		.hps_0_uart1_via_fpga_20x2_dsr                  (hps_uart1_20x2_dsrr),                 //                                .dsr
		.hps_0_uart1_via_fpga_20x2_dcd                  (hps_uart1_20x2_dcdd),                 //                                .dcd
		.hps_0_uart1_via_fpga_20x2_ri                   (hps_uart1_20x2_ri),                   //                                .ri
		.hps_0_uart1_via_fpga_20x2_dtr                  (hps_uart1_20x2_dtr),                  //                                .dtr
		.hps_0_uart1_via_fpga_20x2_rts                  (hps_uart1_20x2_rts),                  //                                .rts
		.hps_0_uart1_via_fpga_20x2_out1_n               (hps_uart1_20x2_out1_n),               //                                .out1_n
		.hps_0_uart1_via_fpga_20x2_out2_n               (hps_uart1_20x2_out2_n),               //                                .out2_n
		.hps_0_uart1_via_fpga_20x2_rxd                  (hps_uart1_20x2_rxd),                  //                                .rxd
		.hps_0_uart1_via_fpga_20x2_txd                  (hps_uart1_20x2_txd),                  //                                .txd
		.led_pio_external_connection_export             (fpga_led_internal),                   //     led_pio_external_connection.export
		.hps_0_f2h_stm_hw_events_stm_hwevents           (),                                    //         hps_0_f2h_stm_hw_events.stm_hwevents
		.hps_0_h2f_reset_reset                          (hps_fpga_reset_n),                    //                 hps_0_h2f_reset.reset
		.hps_0_f2h_cold_reset_req_reset_n               (~hps_cold_reset),                     //        hps_0_f2h_cold_reset_req.reset_n
		.hps_0_f2h_debug_reset_req_reset_n              (~hps_debug_reset),                    //       hps_0_f2h_debug_reset_req.reset_n
		.hps_0_f2h_warm_reset_req_reset_n               (~hps_warm_reset),                     //        hps_0_f2h_warm_reset_req.reset_n
		.hps_0_h2f_user0_clock_clk                      (h2f_user0_clock),                     //           hps_0_h2f_user0_clock.clk
		.alt_vip_cl_cvo_0_clocked_video_vid_clk         (pixel_clk),                           //  alt_vip_cl_cvo_0_clocked_video.vid_clk
		.alt_vip_cl_cvo_0_clocked_video_vid_data        ({vid_r,vid_g,vid_b}),                 //                            .vid_data
		.alt_vip_cl_cvo_0_clocked_video_underflow       (),                                    //                                .underflow
		.alt_vip_cl_cvo_0_clocked_video_vid_mode_change (),                                    //                                .vid_mode_change
		.alt_vip_cl_cvo_0_clocked_video_vid_std         (),                                    //                                .vid_std
		.alt_vip_cl_cvo_0_clocked_video_vid_datavalid   (vid_datavalid),                       //                                .vid_datavalid
		.alt_vip_cl_cvo_0_clocked_video_vid_v_sync      (vid_v_sync),                          //                                .vid_v_sync
		.alt_vip_cl_cvo_0_clocked_video_vid_h_sync      (vid_h_sync),                          //                                .vid_h_sync
		.alt_vip_cl_cvo_0_clocked_video_vid_f           (),                                    //                                .vid_f
		.alt_vip_cl_cvo_0_clocked_video_vid_h           (),                                    //                                .vid_h
		.alt_vip_cl_cvo_0_clocked_video_vid_v           (),                                    //                                .vid_v

//		.alt_vip_itc_0_clocked_video_vid_clk            (pixel_clk),                           //     alt_vip_itc_0_clocked_video.vid_clk
//		.alt_vip_itc_0_clocked_video_vid_data           ({vid_r,vid_b,vid_g}),                 //                                .vid_data
//		.alt_vip_itc_0_clocked_video_underflow          (),                                    //                                .underflow
//		.alt_vip_itc_0_clocked_video_vid_datavalid      (vid_datavalid),                       //                                .vid_datavalid
//		.alt_vip_itc_0_clocked_video_vid_v_sync         (vid_v_sync),                          //                                .vid_v_sync
//		.alt_vip_itc_0_clocked_video_vid_h_sync         (vid_h_sync),                          //                                .vid_h_sync
//		.alt_vip_itc_0_clocked_video_vid_f              (),                                    //                                .vid_f
//		.alt_vip_itc_0_clocked_video_vid_h              (),                                    //                                .vid_h
//		.alt_vip_itc_0_clocked_video_vid_v              (),                                    //                                .vid_v
// use these 2 lines for separate plls
//		.singal_tap_pll_outclk0_clk                     (),                                    //          singal_tap_pll_outclk0.clk
//		.pixel_clk_pll_outclk0_clk                      (pixel_clk)                            //           pixel_clk_pll_outclk0.clk
// use these 2 lines for shared plls
		.singal_tap_pll_outclk0_1_clk                   (),                                    //        singal_tap_pll_outclk0_1.clk
		.pixel_clk_pll_outclk0_1_clk                    (pixel_clk),                           //         pixel_clk_pll_outclk0_1.clk
		.sd_host_controller_0_conduit_end_CMD_i       (sd_cmd_i),                              // sd_host_controller_0_conduit_end.CMD_i
		.sd_host_controller_0_conduit_end_DAT0_i      (sd_data0_i),                            //                                 .DAT0_i
		.sd_host_controller_0_conduit_end_DAT1_i      (sd_data1_i),                            //                                 .DAT1_i
		.sd_host_controller_0_conduit_end_DAT2_i      (sd_data2_i),                            //                                 .DAT2_i
		.sd_host_controller_0_conduit_end_DAT3_i      (sd_data3_i),                            //                                 .DAT3_i
		.sd_host_controller_0_conduit_end_In          (1'b1),                                  //                                 .In
		.sd_host_controller_0_conduit_end_Wp          (1'b1),                                  //                                 .Wp
		.sd_host_controller_0_conduit_end_Busy        (),                                      //                                 .Busy
		.sd_host_controller_0_conduit_end_CLK_o       (CV_FPGA_1V8_RF_SD_CLK),                 //                                 .CLK_o
		.sd_host_controller_0_conduit_end_CMD_o       (sd_cmd_o),                              //                                 .CMD_o
		.sd_host_controller_0_conduit_end_DAT0_o      (sd_data0_o),                            //                                 .DAT0_o
		.sd_host_controller_0_conduit_end_DAT1_o      (sd_data1_o),                            //                                 .DAT1_o
		.sd_host_controller_0_conduit_end_DAT2_o      (sd_data2_o),                            //                                 .DAT2_o
		.sd_host_controller_0_conduit_end_DAT3_o      (sd_data3_o),                            //                                 .DAT3_o
		.sd_host_controller_0_conduit_end_CMD_oe_o    (sd_cmd_oe),                             //                                 .CMD_oe_o
		.sd_host_controller_0_conduit_end_DATA_oe_o   (sd_data_oe)                             //                                 .DATA_oe_o
);

// Source/Probe megawizard instance
hps_reset hps_reset_inst (
  .source_clk (h2f_user0_clock),
  .source     (hps_reset_req)
);

altera_edge_detector pulse_cold_reset (
  .clk       (h2f_user0_clock),
  .rst_n     (hps_fpga_reset_n),
  .signal_in (hps_reset_req[0]),
  .pulse_out (hps_cold_reset)
);
  defparam pulse_cold_reset.PULSE_EXT = 6;
  defparam pulse_cold_reset.EDGE_TYPE = 1;
  defparam pulse_cold_reset.IGNORE_RST_WHILE_BUSY = 1;

altera_edge_detector pulse_warm_reset (
  .clk       (h2f_user0_clock),
  .rst_n     (hps_fpga_reset_n),
  .signal_in (hps_reset_req[1]),
  .pulse_out (hps_warm_reset)
);
  defparam pulse_warm_reset.PULSE_EXT = 2;
  defparam pulse_warm_reset.EDGE_TYPE = 1;
  defparam pulse_warm_reset.IGNORE_RST_WHILE_BUSY = 1;
  
altera_edge_detector pulse_debug_reset (
  .clk       (h2f_user0_clock),
  .rst_n     (hps_fpga_reset_n),
  .signal_in (hps_reset_req[2]),
  .pulse_out (hps_debug_reset)
);
  defparam pulse_debug_reset.PULSE_EXT = 32;
  defparam pulse_debug_reset.EDGE_TYPE = 1;
  defparam pulse_debug_reset.IGNORE_RST_WHILE_BUSY = 1;
  
// Blink the WiFi/BLE lights so we know the FPGA is configured and clocks are running

reg [24:0] led1_counter;
always @(posedge h2f_user0_clock) begin
  if (hps_fpga_reset_n)
    led1_counter <= 0;
  else
    led1_counter <= led1_counter + 1;
end

reg [25:0] led2_counter;
always @(posedge pixel_clk) begin
  if (hps_fpga_reset_n)
    led2_counter <= 0;
  else
    led2_counter <= led2_counter + 1;
end

assign CV_HPS_2V5_GPIO_LED_RF1_via_FPGA = led1_counter[24];
assign CV_HPS_2V5_GPIO_LED_RF2_via_FPGA = led2_counter[25];


endmodule
