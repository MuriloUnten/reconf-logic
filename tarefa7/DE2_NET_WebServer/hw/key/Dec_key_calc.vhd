-- ==============================================
-- PROJETO FINAL
-- Lógica Reconfigurável - CSW42 - S71 - 2023/1
-- Jhonny Kristyan Vaz-Tostes de Assis - 2126672
-- João Vitor Dotto Rissardi - 2126699
-- ==============================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--------------------------------------------------------------------------------------

entity Dec_key_calc is
   port(
		clock          : in  std_logic;
		reset          : in  std_logic;
		finished       : out  std_logic;
		input_key      : in  std_logic_vector (127 downto 0);
		output_key     : out std_logic_vector (127 downto 0)
	); 
end entity;

--------------------------------------------------------------------------------------

architecture a_Dec_key_calc of Dec_key_calc is

--------------------------------------------------------------------------------------

component Reg is
    generic (
        size: positive
    );
    port (
        clock: in std_logic;
		  enable: in std_logic;
        input: in std_logic_vector(size - 1 downto 0);
        output: out std_logic_vector(size - 1 downto 0)
    );
end component;

component Round_key_calculator is
   port(
		input_key      : in  std_logic_vector (127 downto 0);
		round_constant : in std_logic_vector(7 downto 0);
		output_key     : out std_logic_vector (127 downto 0)
	); 
end component;

--------------------------------------------------------------------------------------

signal reg_input : std_logic_vector (127 downto 0);
signal reg_output: std_logic_vector (127 downto 0);
signal round_key : std_logic_vector (127 downto 0);
signal permanent_enable : std_logic;

signal current_round_constant: std_logic_vector(7 downto 0);

constant rcon_table : std_logic_vector(87 downto 0) := x"01020408102040801B3600";

--------------------------------------------------------------------------------------

begin

process(clock)
variable i : integer range 0 to 10 := 0;
begin
	if rising_edge(clock) then
		if(reset = '1') then
			i := 0;
		else
			i := (i + 1) mod 11;
		end if;
	end if;
	current_round_constant <= rcon_table((87-(8*i)) downto (88-(8*(i+1))));
end process;

permanent_enable <= '1';

reg_input <= input_key when reset = '1' else round_key;
		
reg_inst : reg
generic map(
	size => 128
)
port map(
	clock  => clock,
	enable => permanent_enable,
	input  => reg_input,
	output => reg_output
);	


round_key_calculator_inst : round_key_calculator
port map(
	input_key  => reg_output,
	round_constant  => current_round_constant,
	output_key => round_key
);	

output_key <= reg_output;
finished <= '1' when (current_round_constant = x"00") else '0';

end architecture a_Dec_key_calc;