library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_counter_74 is
end entity;

architecture SIM of tb_counter_74 is
signal RST  : std_logic := '1';
signal CLK  : std_logic := '0';
signal Q    : unsigned(7 downto 0);
signal EN   : std_logic := '1';
signal CLR  : std_logic := '0';

begin
    dut: entity work.counter_74
        port map (
            RST  => RST,
            CLK  => CLK,
            Q    => Q,
            EN   => EN,
            CLR  => CLR
        );

    clock_process: process
    begin
        while true loop
            CLK <= '0';
            wait for 10 ns;

            CLK <= '1';
            wait for 10 ns;
        end loop;
    end process;

    stimulus_process: process
    begin
        RST <= '1';
		  
        EN <= '1';

        wait for 15 ns;
        RST <= '0';

        wait for 2000 ns;
        EN <= '0';

        wait;
    end process;

    clr_process: process
    begin
        CLR <= '0';

        wait for 75 ns;
        CLR <= '1';

        wait for 20 ns;
        CLR <= '0';

        wait for 30 ns;
        CLR <= '1';

        wait for 20 ns;
        CLR <= '0';

        wait;
    end process;

end architecture;