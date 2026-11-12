library IEEE;
use IEEE.std_logic_1164.all;

entity altera_tristate_conduit_bridge_translator is 
  port (
    in_tri_state_bridge_0_data : inout std_logic_vector (8-1 downto 0) := "ZZZZZZZZ";

    tri_state_bridge_0_data : inout std_logic_vector (8-1 downto 0) := "ZZZZZZZZ";

    in_tri_state_bridge_0_readn : in std_logic_vector (1-1 downto 0);

    tri_state_bridge_0_readn : out std_logic_vector (1-1 downto 0);

    in_write_n_to_the_cfi_flash_0 : in std_logic_vector (1-1 downto 0);

    write_n_to_the_cfi_flash_0 : out std_logic_vector (1-1 downto 0);

    in_tri_state_bridge_0_address : in std_logic_vector (22-1 downto 0);

    tri_state_bridge_0_address : out std_logic_vector (22-1 downto 0);

    in_select_n_to_the_cfi_flash_0 : in std_logic_vector (1-1 downto 0);

    select_n_to_the_cfi_flash_0 : out std_logic_vector (1-1 downto 0)

  );
end altera_tristate_conduit_bridge_translator;

  architecture rtl of altera_tristate_conduit_bridge_translator is

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

    begin -- rtl
       tri_state_bridge_0_data_inout_module : altera_inout
         generic map (
           WIDTH_A => 8,
           WIDTH_B => 8
         )
         port map (
           a => tri_state_bridge_0_data,
           b => in_tri_state_bridge_0_data
         );
    tri_state_bridge_0_readn <= in_tri_state_bridge_0_readn;
    write_n_to_the_cfi_flash_0 <= in_write_n_to_the_cfi_flash_0;
    tri_state_bridge_0_address <= in_tri_state_bridge_0_address;
    select_n_to_the_cfi_flash_0 <= in_select_n_to_the_cfi_flash_0;
  end rtl;

