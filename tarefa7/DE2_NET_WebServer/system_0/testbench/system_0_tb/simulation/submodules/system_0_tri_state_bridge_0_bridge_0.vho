--IP Functional Simulation Model
--VERSION_BEGIN 13.0 cbx_mgl 2013:06:12:18:04:42:SJ cbx_simgen 2013:06:12:18:03:40:SJ  VERSION_END


-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- You may only use these simulation model output files for simulation
-- purposes and expressly not for synthesis or any other purposes (in which
-- event Altera disclaims all warranties of any kind).


--synopsys translate_off

 LIBRARY sgate;
 USE sgate.sgate_pack.all;

--synthesis_resources = io_buf_tri 33 lut 47 mux21 1 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  system_0_tri_state_bridge_0_bridge_0 IS 
	 PORT 
	 ( 
		 clk	:	IN  STD_LOGIC;
		 grant	:	OUT  STD_LOGIC;
		 request	:	IN  STD_LOGIC;
		 reset	:	IN  STD_LOGIC;
		 select_n_to_the_cfi_flash_0	:	OUT  STD_LOGIC_VECTOR (0 DOWNTO 0);
		 tcs_select_n_to_the_cfi_flash_0	:	IN  STD_LOGIC_VECTOR (0 DOWNTO 0);
		 tcs_tri_state_bridge_0_address	:	IN  STD_LOGIC_VECTOR (21 DOWNTO 0);
		 tcs_tri_state_bridge_0_data	:	IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
		 tcs_tri_state_bridge_0_data_in	:	OUT  STD_LOGIC_VECTOR (7 DOWNTO 0);
		 tcs_tri_state_bridge_0_data_outen	:	IN  STD_LOGIC;
		 tcs_tri_state_bridge_0_readn	:	IN  STD_LOGIC_VECTOR (0 DOWNTO 0);
		 tcs_write_n_to_the_cfi_flash_0	:	IN  STD_LOGIC_VECTOR (0 DOWNTO 0);
		 tri_state_bridge_0_address	:	OUT  STD_LOGIC_VECTOR (21 DOWNTO 0);
		 tri_state_bridge_0_data	:	INOUT  STD_LOGIC_VECTOR (7 DOWNTO 0);
		 tri_state_bridge_0_readn	:	OUT  STD_LOGIC_VECTOR (0 DOWNTO 0);
		 write_n_to_the_cfi_flash_0	:	OUT  STD_LOGIC_VECTOR (0 DOWNTO 0)
	 ); 
 END system_0_tri_state_bridge_0_bridge_0;

 ARCHITECTURE RTL OF system_0_tri_state_bridge_0_bridge_0 IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_grant_reg_2q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_select_n_to_the_cfi_flash_0_reg_0_12q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_select_n_to_the_cfi_flash_0en_reg_10q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_0_35q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_10_45q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_11_46q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_12_47q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_13_48q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_14_49q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_15_50q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_16_51q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_17_52q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_18_53q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_19_54q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_1_36q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_20_55q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_21_56q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_2_37q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_3_38q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_4_39q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_5_40q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_6_41q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_7_42q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_8_43q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_9_44q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_0_6q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_1_61q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_2_62q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_3_63q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_4_64q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_5_65q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_6_66q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_7_67q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_outen_reg_3q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_0_4q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_1_76q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_2_77q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_3_78q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_4_79q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_5_80q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_6_81q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_7_82q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_readn_reg_0_60q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_readnen_reg_7q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_write_n_to_the_cfi_flash_0_reg_0_58q	:	STD_LOGIC := '0';
	 SIGNAL	system_0_tri_state_bridge_0_bridge_0_write_n_to_the_cfi_flash_0en_reg_8q	:	STD_LOGIC := '0';
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_select_n_to_the_cfi_flash_0_0_11t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_0_13t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_10_23t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_11_24t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_12_25t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_13_26t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_14_27t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_15_28t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_16_29t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_17_30t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_18_31t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_19_32t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_1_14t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_20_33t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_21_34t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_2_15t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_3_16t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_4_17t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_5_18t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_6_19t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_7_20t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_8_21t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_9_22t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_0_68t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_1_69t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_2_70t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_3_71t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_4_72t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_5_73t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_6_74t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_7_75t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_readn_0_59t_dataout	:	STD_LOGIC;
	 SIGNAL  wire_system_0_tri_state_bridge_0_bridge_0_write_n_to_the_cfi_flash_0_0_57t_dataout	:	STD_LOGIC;
	 SIGNAL	wire_system_0_tri_state_bridge_0_bridge_0_grant_reg_1m_dataout	:	STD_LOGIC;
	 SIGNAL  wire_w_lg_reset3w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  s_wire_vcc :	STD_LOGIC;
 BEGIN

	wire_w_lg_reset3w(0) <= NOT reset;
	grant <= system_0_tri_state_bridge_0_bridge_0_grant_reg_2q;
	s_wire_vcc <= '1';
	select_n_to_the_cfi_flash_0(0) <= ( wire_system_0_tri_state_bridge_0_bridge_0_select_n_to_the_cfi_flash_0_0_11t_dataout);
	tcs_tri_state_bridge_0_data_in <= ( system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_7_67q & system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_6_66q & system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_5_65q & system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_4_64q & system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_3_63q & system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_2_62q & system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_1_61q & system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_0_6q);
	tri_state_bridge_0_address <= ( wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_21_34t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_20_33t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_19_32t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_18_31t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_17_30t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_16_29t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_15_28t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_14_27t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_13_26t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_12_25t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_11_24t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_10_23t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_9_22t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_8_21t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_7_20t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_6_19t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_5_18t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_4_17t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_3_16t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_2_15t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_1_14t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_0_13t_dataout);
	tri_state_bridge_0_data <= ( wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_7_75t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_6_74t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_5_73t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_4_72t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_3_71t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_2_70t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_1_69t_dataout & wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_0_68t_dataout);
	tri_state_bridge_0_readn(0) <= ( wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_readn_0_59t_dataout);
	write_n_to_the_cfi_flash_0(0) <= ( wire_system_0_tri_state_bridge_0_bridge_0_write_n_to_the_cfi_flash_0_0_57t_dataout);
	PROCESS (clk)
	BEGIN
		IF (clk = '1' AND clk'event) THEN
				system_0_tri_state_bridge_0_bridge_0_grant_reg_2q <= wire_system_0_tri_state_bridge_0_bridge_0_grant_reg_1m_dataout;
				system_0_tri_state_bridge_0_bridge_0_select_n_to_the_cfi_flash_0_reg_0_12q <= tcs_select_n_to_the_cfi_flash_0(0);
				system_0_tri_state_bridge_0_bridge_0_select_n_to_the_cfi_flash_0en_reg_10q <= wire_w_lg_reset3w(0);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_0_35q <= tcs_tri_state_bridge_0_address(0);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_10_45q <= tcs_tri_state_bridge_0_address(10);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_11_46q <= tcs_tri_state_bridge_0_address(11);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_12_47q <= tcs_tri_state_bridge_0_address(12);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_13_48q <= tcs_tri_state_bridge_0_address(13);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_14_49q <= tcs_tri_state_bridge_0_address(14);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_15_50q <= tcs_tri_state_bridge_0_address(15);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_16_51q <= tcs_tri_state_bridge_0_address(16);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_17_52q <= tcs_tri_state_bridge_0_address(17);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_18_53q <= tcs_tri_state_bridge_0_address(18);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_19_54q <= tcs_tri_state_bridge_0_address(19);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_1_36q <= tcs_tri_state_bridge_0_address(1);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_20_55q <= tcs_tri_state_bridge_0_address(20);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_21_56q <= tcs_tri_state_bridge_0_address(21);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_2_37q <= tcs_tri_state_bridge_0_address(2);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_3_38q <= tcs_tri_state_bridge_0_address(3);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_4_39q <= tcs_tri_state_bridge_0_address(4);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_5_40q <= tcs_tri_state_bridge_0_address(5);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_6_41q <= tcs_tri_state_bridge_0_address(6);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_7_42q <= tcs_tri_state_bridge_0_address(7);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_8_43q <= tcs_tri_state_bridge_0_address(8);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_9_44q <= tcs_tri_state_bridge_0_address(9);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q <= wire_w_lg_reset3w(0);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_0_6q <= tri_state_bridge_0_data(0);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_1_61q <= tri_state_bridge_0_data(1);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_2_62q <= tri_state_bridge_0_data(2);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_3_63q <= tri_state_bridge_0_data(3);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_4_64q <= tri_state_bridge_0_data(4);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_5_65q <= tri_state_bridge_0_data(5);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_6_66q <= tri_state_bridge_0_data(6);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_in_reg_7_67q <= tri_state_bridge_0_data(7);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_outen_reg_3q <= tcs_tri_state_bridge_0_data_outen;
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_0_4q <= tcs_tri_state_bridge_0_data(0);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_1_76q <= tcs_tri_state_bridge_0_data(1);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_2_77q <= tcs_tri_state_bridge_0_data(2);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_3_78q <= tcs_tri_state_bridge_0_data(3);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_4_79q <= tcs_tri_state_bridge_0_data(4);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_5_80q <= tcs_tri_state_bridge_0_data(5);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_6_81q <= tcs_tri_state_bridge_0_data(6);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_7_82q <= tcs_tri_state_bridge_0_data(7);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_readn_reg_0_60q <= tcs_tri_state_bridge_0_readn(0);
				system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_readnen_reg_7q <= wire_w_lg_reset3w(0);
				system_0_tri_state_bridge_0_bridge_0_write_n_to_the_cfi_flash_0_reg_0_58q <= tcs_write_n_to_the_cfi_flash_0(0);
				system_0_tri_state_bridge_0_bridge_0_write_n_to_the_cfi_flash_0en_reg_8q <= wire_w_lg_reset3w(0);
		END IF;
	END PROCESS;
	system_0_tri_state_bridge_0_bridge_0_select_n_to_the_cfi_flash_0_0_11t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_select_n_to_the_cfi_flash_0_reg_0_12q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_select_n_to_the_cfi_flash_0_0_11t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_select_n_to_the_cfi_flash_0en_reg_10q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_0_13t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_0_35q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_0_13t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_10_23t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_10_45q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_10_23t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_11_24t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_11_46q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_11_24t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_12_25t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_12_47q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_12_25t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_13_26t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_13_48q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_13_26t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_14_27t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_14_49q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_14_27t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_15_28t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_15_50q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_15_28t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_16_29t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_16_51q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_16_29t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_17_30t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_17_52q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_17_30t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_18_31t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_18_53q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_18_31t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_19_32t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_19_54q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_19_32t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_1_14t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_1_36q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_1_14t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_20_33t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_20_55q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_20_33t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_21_34t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_21_56q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_21_34t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_2_15t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_2_37q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_2_15t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_3_16t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_3_38q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_3_16t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_4_17t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_4_39q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_4_17t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_5_18t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_5_40q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_5_18t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_6_19t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_6_41q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_6_19t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_7_20t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_7_42q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_7_20t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_8_21t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_8_43q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_8_21t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_9_22t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_reg_9_44q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_address_9_22t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_addressen_reg_9q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_0_68t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_0_4q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_0_68t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_outen_reg_3q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_1_69t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_1_76q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_1_69t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_outen_reg_3q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_2_70t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_2_77q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_2_70t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_outen_reg_3q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_3_71t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_3_78q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_3_71t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_outen_reg_3q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_4_72t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_4_79q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_4_72t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_outen_reg_3q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_5_73t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_5_80q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_5_73t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_outen_reg_3q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_6_74t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_6_81q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_6_74t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_outen_reg_3q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_7_75t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_reg_7_82q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_7_75t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_data_outen_reg_3q
	  );
	system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_readn_0_59t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_readn_reg_0_60q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_readn_0_59t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_tri_state_bridge_0_readnen_reg_7q
	  );
	system_0_tri_state_bridge_0_bridge_0_write_n_to_the_cfi_flash_0_0_57t :  io_buf_tri
	  PORT MAP ( 
		datain => system_0_tri_state_bridge_0_bridge_0_write_n_to_the_cfi_flash_0_reg_0_58q,
		dataout => wire_system_0_tri_state_bridge_0_bridge_0_write_n_to_the_cfi_flash_0_0_57t_dataout,
		oe => system_0_tri_state_bridge_0_bridge_0_write_n_to_the_cfi_flash_0en_reg_8q
	  );
	wire_system_0_tri_state_bridge_0_bridge_0_grant_reg_1m_dataout <= request AND NOT(reset);

 END RTL; --system_0_tri_state_bridge_0_bridge_0
--synopsys translate_on
--VALID FILE
