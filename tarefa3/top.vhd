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

component debouncer is
    port (
        clk : in std_logic;
        btn_in : in std_logic;
        btn_out : out std_logic
    );
end component;

signal debounced_reset:        std_logic;
signal debounced_pause_toggle: std_logic;

signal pause_prev : std_logic := '0';
signal pause_pulse : std_logic;

signal reset:  std_logic := '0';
signal is_running : std_logic := '0';

signal cnt_100hz : integer range 0 to 499999 := 0;
signal tick_100hz : std_logic := '0';

signal stopwatch_enable: std_logic;

begin
    sw: stopwatch port map(
        rst     => reset,
        clk     => clk,
        en      => stopwatch_enable,
        seconds => seconds,
        cents   => cents,
        c0_7seg => c0_7seg,
        c1_7seg => c1_7seg,
        s0_7seg => s0_7seg,
        s1_7seg => s1_7seg
    );

    deb_reset : debouncer port map(
        clk => clk,
        btn_in => not reset_button,
        btn_out => debounced_reset
    );

    deb_pause : debouncer port map(
        clk => clk,
        btn_in => not pause_toggle_button,
        btn_out => debounced_pause_toggle
    );

    clock_cycle: process(clk)
    begin
        if rising_edge(clk) then
           if cnt_100hz = 499999 then
                cnt_100hz <= 0;
                tick_100hz <= '1';
           else
                cnt_100hz <= cnt_100hz + 1;
                tick_100hz <= '0';
           end if;

           pause_prev <= debounced_pause_toggle;

           if(debounced_pause_toggle = '1' and pause_prev = '0') then
                is_running <= not (is_running);
           end if;

           if (reset = '1') then
                is_running <= '0';
           end if;
        end if;
    end process;

    reset <= debounced_reset when is_running = '0' else '0';
    stopwatch_enable <= '1' when (is_running = '1' and tick_100hz = '1') else '0';

end architecture;
