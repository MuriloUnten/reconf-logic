LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY top_avalon IS
PORT ( clock, resetn : IN STD_LOGIC;
		 chipselect    : IN  STD_LOGIC;
		 writedata     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
       write_en      : IN  STD_LOGIC;
       readdata      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
   	 add           : IN STD_LOGIC;
       read_en       : IN STD_LOGIC );
END top_avalon;

ARCHITECTURE Y OF top_avalon IS

COMPONENT reg32
	PORT(
		clock  : IN STD_LOGIC;
		resetn : IN STD_LOGIC;
		WE 	 : IN STD_LOGIC;
		D 		 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q 		 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT Counter10ms
	PORT(
		clk_50 : in std_logic;
		enable : in std_logic;
		reset  : in std_logic;
		output : out std_logic := '0'
	);
END COMPONENT;

COMPONENT CounterUpToN
	PORT(
		clk_50		: in std_logic;
		enable		: in std_logic;
		reset			: in std_logic;
		upper_bound : in STD_LOGIC_VECTOR(7 downto 0);
		carry			: out std_logic := '0';
		count			: out STD_LOGIC_VECTOR(7 downto 0)
	);
END COMPONENT;

signal write_enable_r1 : std_logic;
signal read_enable_r2: std_logic;
signal r32_1_out, r32_2_out, r32_2_in : STD_LOGIC_VECTOR(31 DOWNTO 0);

signal rst : std_LOGIC;
SIGNAL output10ms: std_logic;
SIGNAL carry_digit4: std_logic;
SIGNAL carry_digit3: std_logic;
SIGNAL carry_digit2: std_logic;
SIGNAL carry_digit1: std_logic;
SIGNAL count_digit4: STD_LOGIC_VECTOR(7 downto 0) := x"00";
SIGNAL count_digit3: STD_LOGIC_VECTOR(7 downto 0) := x"00";
SIGNAL count_digit2: STD_LOGIC_VECTOR(7 downto 0) := x"00";
SIGNAL count_digit1: STD_LOGIC_VECTOR(7 downto 0) := x"00";
SIGNAL enable_digit4: std_logic;
SIGNAL enable_digit3: std_logic;
SIGNAL enable_digit2: std_logic;
SIGNAL enable_digit1: std_logic;
SIGNAL enable_count: std_logic := '0';
SIGNAL reset_count: std_logic := '0';
SIGNAL reset_reg: std_logic := '1';


BEGIN
RST <= not resetn;
write_enable_r1 <= write_en and chipselect and (not add);

enable_digit4 <= output10ms;
enable_digit3 <= enable_digit4 and carry_digit4;
enable_digit2 <= enable_digit3 and carry_digit3;
enable_digit1 <= enable_digit2 and carry_digit2;


--		reg 1: Entrada
--		33222222222211111111110000000000
--		10987654321098765432109876543210
--					               		||
--                                  | - enable_count
--												 -- reset

r32_1 : reg32
port map (
	clock 	=> clock,
	resetn 	=> resetn,
	WE       => write_enable_r1,
	D 		   => writedata,
	Q 		   => r32_1_out
);

enable_count <= r32_1_out(0);
reset_count <= r32_1_out(1) or RST;
reset_reg <= resetn and not r32_1_out(1);


--   reg 2: Contagem
--   Esse registrador será lido pelo software
--
--   33222222222211111111110000000000   
--   10987654321098765432109876543210
--   |------||      ||      ||      |
--    digit 1|------||      ||      |
--            digit 2|------||      |
--                    digit 3|------|      
--                            digit 4

r32_2 : reg32
port map (
	clock 	=> clock,
	resetn 	=> reset_reg,
	WE       => '1',
	D 		=> r32_2_in,
	Q 		=> r32_2_out
);

r32_2_in <= count_digit1 & count_digit2 & count_digit3 & count_digit4;

cont10ms: Counter10ms PORT MAP(
	clk_50 => clock,
	enable => enable_count,
	reset => reset_count,
	output => output10ms
);

digit4: CounterUpToN PORT MAP(
	clk_50 => clock,
	enable => enable_digit4,
	reset => reset_count,
	upper_bound => x"0A", -- Count from 0 to 9
	carry => carry_digit4,
	count => count_digit4
);

digit3: CounterUpToN PORT MAP(
	clk_50 => clock,
	enable => enable_digit3,
	reset => reset_count,
	upper_bound => x"06", -- Count from 0 to 5
	carry => carry_digit3,
	count => count_digit3
);

digit2: CounterUpToN PORT MAP(
	clk_50 => clock,
	enable => enable_digit2,
	reset => reset_count,
	upper_bound => x"0A", -- Count from 0 to 9
	carry => carry_digit2,
	count => count_digit2
);

digit1: CounterUpToN PORT MAP(
	clk_50 => clock,
	enable => enable_digit1,
	reset => reset_count,
	upper_bound => x"06", -- Count from 0 to 5
	carry => carry_digit1,
	count => count_digit1
);
 
process(clock)

begin
end process;		

-- sinais de habilitação de leitura
read_enable_r2 <= read_en and chipselect and (not add);
readdata <= r32_2_out when read_enable_r2 = '1' else (others => 'Z');

END Y;





















