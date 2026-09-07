Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter_74 is
	port(
		rst : in std_logic;
		clk : in std_logic;
		q 	: out unsigned(7 downto 0);
		en  : in std_logic;
		clr : in std_logic
	);
end entity;

architecture x of counter_74 is
signal conn0: unsigned (3 downto 0);
signal conn1: unsigned (3 downto 0);
signal load_s: std_logic;
signal clr0: std_logic;
signal clr1: std_logic;
signal en1: std_logic;
signal init_s: std_logic;

component counter_4 is 
	port(
		rst  : in std_logic;
		clk  : in std_logic;
		q    : out unsigned(3 downto 0);
		en   : in std_logic;
		clr  : in std_logic;
		ld   : in std_logic;
		load : in unsigned (3 downto 0)
	);
end component;

begin
	cont0: counter_4 port map(
		rst  => rst,
		clk  => clk,
		q    => conn0,
		en   => en,
		clr  => clr0,
		ld   => load_s,
		load => "0011"
	);
		
	cont1 : counter_4 port map(
		rst  => rst,
		clk  => clk,
		q    => conn1,
		en   => en1,
		clr  => clr1,
		ld   => load_s,
		load => "0001"
	);

	process(clk, rst)
	begin
		if rst = '1' then
			init_s <= '1';
		elsif rising_edge(clk) then
			init_s <= '0';
		end if;
	end process;

	en1 <= '1' when en = '1' and (load_s = '1' or conn0 = "1001") else '0';
	load_s <= '1' when init_s = '1' or clr = '1' or (conn0 = "0110" and conn1 = "1000") else '0';
	clr0 <= '1' when conn0 >= "1001" else '0';
	clr1 <= '1' when conn1 >= "1001" else '0';
	q(3 downto 0) <= conn0;
	q(7 downto 4) <= conn1;
end architecture;
