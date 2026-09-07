library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stopwatch is
    port(
        rst: in std_logic;
        clk: in std_logic;
        en:  in std_logic;

        seconds: out unsigned (7 downto 0);
        cents:   out unsigned (7 downto 0);
        c0_7seg: out unsigned (6 downto 0);
        c1_7seg: out unsigned (6 downto 0);
        s0_7seg: out unsigned (6 downto 0);
        s1_7seg: out unsigned (6 downto 0)
    );
end entity;

architecture x of stopwatch is

component counter_4 is 
    port(
        rst:  in  std_logic;
        clk:  in  std_logic;
        en:   in  std_logic;
        clr:  in  std_logic;
        ld:   in  std_logic;
        load: in  unsigned (3 downto 0);
        q:    out unsigned(3 downto 0)
    );
end component;

component bcd_7seg is 
    port(
        input:    in  unsigned(3 downto 0);
        segments: out unsigned(6 downto 0)
    );
end component;

signal enable_global: std_logic := '0';
signal reset_global:  std_logic := '0';

signal c0_out: unsigned (3 downto 0);
signal c1_out: unsigned (3 downto 0);
signal s0_out: unsigned (3 downto 0);
signal s1_out: unsigned (3 downto 0);

signal clear_c0: std_logic;
signal clear_c1: std_logic;
signal clear_s0: std_logic;
signal clear_s1: std_logic;

signal enable_c0: std_logic;
signal enable_c1: std_logic;
signal enable_s0: std_logic;
signal enable_s1: std_logic;

begin
    c0: counter_4 port map(
        rst  => rst,
        clk  => clk,
        en   => enable_global,
        clr  => clear_c0,
        ld   => '0',
        load => "0000",
        q    => c0_out
    );
    c1: counter_4 port map(
        rst  => rst,
        clk  => clk,
        en   => enable_c1,
        clr  => clear_c1,
        ld   => '0',
        load => "0000",
        q    => c1_out
    );
    s0: counter_4 port map(
        rst  => rst,
        clk  => clk,
        en   => enable_s0,
        clr  => clear_s0,
        ld   => '0',
        load => "0000",
        q    => s0_out
    );
    s1: counter_4 port map(
        rst  => rst,
        clk  => clk,
        en   => enable_s1,
        clr  => clear_s1,
        ld   => '0',
        load => "0000",
        q    => s1_out
    );

    c0_display: bcd_7seg port map(
        input    => c0_out,
        segments => c0_7seg
    );
    c1_display: bcd_7seg port map(
        input    => c1_out,
        segments => c1_7seg
    );
    s0_display: bcd_7seg port map(
        input    => s0_out,
        segments => s0_7seg
    );
    s1_display: bcd_7seg port map(
        input    => s1_out,
        segments => s1_7seg
    );

    enable_global <= '1' when en = '1' else '0';
    enable_c0 <= enable_global;
    enable_c1 <= enable_global when c0_out = "1001" else '0';
    enable_s0 <= enable_global when c1_out = "1001" and c0_out = "1001" else '0';
    enable_s1 <= enable_global when s0_out = "1001" and c1_out = "1001" and c0_out = "1001" else '0';

    clear_c0 <= '1' when enable_c0 = '1' and c0_out = "1001" else '0';
    clear_c1 <= '1' when enable_c1 = '1' and c1_out = "1001" else '0';
    clear_s0 <= '1' when enable_s0 = '1' and s0_out = "1001" else '0';
    clear_s1 <= '1' when enable_s1 = '1' and s1_out = "0101" else '0';

    cents(3 downto 0)   <= c0_out;
    cents(7 downto 4)   <= c1_out;
    seconds(3 downto 0) <= s0_out;
    seconds(7 downto 4) <= s1_out;
end architecture;
