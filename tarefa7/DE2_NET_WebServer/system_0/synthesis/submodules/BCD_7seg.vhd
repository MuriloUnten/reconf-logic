Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Conversor Binary to 7-segment display
-- input: 4 digits binary number
-- output: 7-segment display code

ENTITY BCD_7seg IS
	PORT(
		input: in unsigned(3 downto 0);
	   output: out unsigned(6 downto 0)
	);
END ENTITY;

ARCHITECTURE BCD of BCD_7seg IS
BEGIN
	output <= "0000001" WHEN input = "0000" ELSE
				 "1001111" WHEN input = "0001" ELSE
				 "0010010" WHEN input = "0010" ELSE
				 "0000110" WHEN input = "0011" ELSE
				 "1001100" WHEN input = "0100" ELSE
				 "0100100" WHEN input = "0101" ELSE
				 "0100000" WHEN input = "0110" ELSE
				 "0001111" WHEN input = "0111" ELSE
				 "0000000" WHEN input = "1000" ELSE
				 "0000100" WHEN input = "1001" ELSE
				 "1111111";
END ARCHITECTURE;
