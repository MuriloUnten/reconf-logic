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

entity Mix_columns_tb is
end entity;

--------------------------------------------------------------------------------------

architecture a_Mix_columns_tb of Mix_columns_tb is

--------------------------------------------------------------------------------------

component Mix_columns is
   port(
		input_block  : in  std_logic_vector (127 downto 0);
		output_block : out std_logic_vector (127 downto 0)
	); 
end component;

--------------------------------------------------------------------------------------

signal input_text, output_text: std_logic_vector (127 downto 0);

--------------------------------------------------------------------------------------

begin

DUT: Mix_columns
	port map(
	   input_block => input_text,
	   output_block => output_text          

	);

--------------------------------------------------------------------------------------

process
	begin
	input_text <= x"63f27dd4c963d4fafe26c96330f2c982";
	wait for 1000 ns;
	input_text <= x"82c9f23063c926fefad463c9d47df263";
	wait;
end process;


end architecture a_Mix_columns_tb;