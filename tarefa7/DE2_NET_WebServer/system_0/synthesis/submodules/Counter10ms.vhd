Library IEEE;
use IEEE.std_logic_1164.all;

-- Counts to 10ms and sends an high output
-- clk_50: board clock
-- enable: enables the circuit
-- reset: resets the count
-- output: 1 every 10ms, 0 otherwise

ENTITY Counter10ms IS
	PORT(
		clk_50: in std_logic;
		enable: in std_logic;
		reset: in std_logic;
	   output: out std_logic := '0'
	);
END ENTITY;

ARCHITECTURE counter of Counter10ms IS
	signal clock_counter: integer range 0 to 50000000;
	signal output_aux: std_logic := '0';
BEGIN
	output <= output_aux;
process (clk_50) IS
	begin
	if reset='1' then
		clock_counter <= 0;
		
	elsif rising_edge(clk_50) and enable='1' then
		clock_counter <= clock_counter + 1;
		if (clock_counter = (50000000-2)) or output_aux = '1' then  -- 500000-2
			output_aux <= not output_aux;	
			clock_counter <= 0;
		end if;
	end if;
end process;
END ARCHITECTURE;
