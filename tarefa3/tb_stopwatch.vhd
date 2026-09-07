library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_stopwatch is
end entity;

architecture sim of tb_stopwatch is
signal clk:                 std_logic;
signal pause_toggle_button: std_logic := '0';
signal reset_button:        std_logic := '0';

signal seconds: unsigned (7 downto 0);
signal cents:   unsigned (7 downto 0);
signal c0_7seg: unsigned (6 downto 0);
signal c1_7seg: unsigned (6 downto 0);
signal s0_7seg: unsigned (6 downto 0);
signal s1_7seg: unsigned (6 downto 0);

component top is
    port(
        clk:                 in std_logic;
        pause_toggle_button: in std_logic;
        reset_button:        in std_logic;

        seconds: out unsigned (7 downto 0);
        cents  : out unsigned (7 downto 0);
        c0_7seg: out unsigned (6 downto 0);
        c1_7seg: out unsigned (6 downto 0);
        s0_7seg: out unsigned (6 downto 0);
        s1_7seg: out unsigned (6 downto 0)
    );
end component;

begin
    dut: entity work.top
        port map (
            clk                 => clk,
            pause_toggle_button => pause_toggle_button,
            reset_button        => reset_button,

            seconds => seconds,
            cents   => cents,
            c0_7seg => c0_7seg,
            c1_7seg => c1_7seg,
            s0_7seg => s0_7seg,
            s1_7seg => s1_7seg 
        );

    -- 100Hz clock
    clock_process: process
    begin
        while true loop
            clk <= '0';
            wait for 5 ms;

            clk <= '1';
            wait for 5 ms;
        end loop;
    end process;

    stimulus_process: process
    begin
        reset_button <= '1';
        wait for 30 ms;
        reset_button <= '0';

        wait for 40 ms;

        pause_toggle_button <= '1';
        wait for 30 ms;
        pause_toggle_button <= '0';

        wait for 200 ms;

        -- should not zero cause not paused
        reset_button <= '1';
        wait for 30 ms;
        reset_button <= '0';

        pause_toggle_button <= '1';
        wait for 30 ms;
        pause_toggle_button <= '0';

        -- should zero
        reset_button <= '1';
        wait for 30 ms;
        reset_button <= '0';

        pause_toggle_button <= '1';
        wait for 30 ms;
        pause_toggle_button <= '0';

        wait for 200 ms;

        -- should pause
        pause_toggle_button <= '1';
        wait for 30 ms;
        pause_toggle_button <= '0';

        wait for 100 ms;

        -- should unpause
        pause_toggle_button <= '1';
        wait for 30 ms;
        pause_toggle_button <= '0';

        wait;
    end process;

end architecture;
