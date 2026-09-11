library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debouncer is
    port(
        clk : in std_logic;
        btn_in : in std_logic;
        btn_out : out std_logic
    );
end entity;

architecture debouncer_arch of debouncer is
    constant MAX_COUNT : integer := 1500000;
    signal counter : integer range 0 to MAX_COUNT := 0;
    signal state : std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if btn_in = state then
                counter <= 0;
            else
                if counter = MAX_COUNT then
                    state <= btn_in;
                    counter <= 0;
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;

    btn_out <= state;
end architecture;