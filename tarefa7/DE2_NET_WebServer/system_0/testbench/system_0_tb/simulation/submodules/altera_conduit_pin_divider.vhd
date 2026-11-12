library IEEE;
use IEEE.STD_LOGIC_1164.all;
	   
entity altera_conduit_pin_divider is
  port (
    cfi_flash_0_tcm_address_out : out std_logic_vector (21 downto 0);

    cfi_flash_0_tcm_read_n_out : out std_logic_vector (0 downto 0);

    cfi_flash_0_tcm_write_n_out : out std_logic_vector (0 downto 0);

    cfi_flash_0_tcm_data_out : inout std_logic_vector (7 downto 0);

    cfi_flash_0_tcm_chipselect_n_out : out std_logic_vector (0 downto 0);

    in_tri_state_bridge_0_address : in std_logic_vector (21 downto 0);

    in_tri_state_bridge_0_readn : in std_logic_vector (0 downto 0);

    in_write_n_to_the_cfi_flash_0 : in std_logic_vector (0 downto 0);

    in_tri_state_bridge_0_data : inout std_logic_vector (7 downto 0);

    in_select_n_to_the_cfi_flash_0 : in std_logic_vector (0 downto 0)

       );
  end altera_conduit_pin_divider;

architecture rtl of altera_conduit_pin_divider is

    component altera_inout
      generic (
            WIDTH_A : POSITIVE;
            WIDTH_B : POSITIVE;
            CHAIN_LENGTH : POSITIVE := 4
      );
      port (
            a : INOUT STD_LOGIC_VECTOR(WIDTH_A-1 downto 0);
            b : INOUT STD_LOGIC_VECTOR(WIDTH_B-1 downto 0)
      );
    end component;
		
  begin	    
        cfi_flash_0_tcm_address_out(21 downto 0) <= in_tri_state_bridge_0_address;
        cfi_flash_0_tcm_read_n_out(0 downto 0) <= in_tri_state_bridge_0_readn;
        cfi_flash_0_tcm_write_n_out(0 downto 0) <= in_write_n_to_the_cfi_flash_0;
       cfi_flash_0_tcm_data_out_inout_module : altera_inout 
         generic map (  WIDTH_A => 8,
                        WIDTH_B => 8 
       ) port map ( 
            a => cfi_flash_0_tcm_data_out,
            b => in_tri_state_bridge_0_data 
       );
        cfi_flash_0_tcm_chipselect_n_out(0 downto 0) <= in_select_n_to_the_cfi_flash_0;


  end rtl;   

