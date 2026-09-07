library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        clk:                 in std_logic;
        pause_toggle_button: in std_logic;
        reset_button:        in std_logic;

        seconds : out unsigned (7 downto 0);
        cents   : out unsigned (7 downto 0);
        c0_7seg : out unsigned (6 downto 0);
        c1_7seg : out unsigned (6 downto 0);
        s0_7seg : out unsigned (6 downto 0);
        s1_7seg : out unsigned (6 downto 0)
    );
end entity;

architecture x of top is

component stopwatch is
    port(
        rst:     in std_logic;
        clk:     in std_logic;
        en:      in std_logic;

        seconds: out unsigned (7 downto 0);
        cents:   out unsigned (7 downto 0);
        c0_7seg: out unsigned (6 downto 0);
        c1_7seg: out unsigned (6 downto 0);
        s0_7seg: out unsigned (6 downto 0);
        s1_7seg: out unsigned (6 downto 0)
    );
end component;

signal debounced_reset:        std_logic;
signal debounced_pause_toggle: std_logic;

signal reset:  std_logic := '0';
signal enable: std_logic := '0';

begin
    sw: stopwatch port map(
        rst     => reset,
        clk     => clk,
        en      => enable,

        seconds => seconds,
        cents   => cents,
        c0_7seg => c0_7seg,
        c1_7seg => c1_7seg,
        s0_7seg => s0_7seg,
        s1_7seg => s1_7seg
    );

    clock_cycle: process(clk)
    begin
        if rising_edge(clk) then
            if debounced_pause_toggle = '1' then
                enable <= not enable;
            end if;
        end if;
    end process;

    -- TODO implement 30ms debounce
    debounced_reset <= reset_button;
    debounced_pause_toggle <= pause_toggle_button;

    reset <= debounced_reset when enable = '0' else '0';

end architecture;
