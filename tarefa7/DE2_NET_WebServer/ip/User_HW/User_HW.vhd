library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity User_HW is
    port (
        clk : in std_logic;
        reset : in std_logic;
        avs_address : in std_logic_vector(6 downto 0);
        avs_write : in std_logic;
        avs_writedata : in std_logic_vector(7 downto 0);
        avs_read : in std_logic;
        avs_readdata : out std_logic_vector(7 downto 0)
    );
end entity User_HW;

architecture rtl of User_HW is
    type ram_type is array (0 to 127) of std_logic_vector(7 downto 0);
    signal ram : ram_type;
    signal read_addr : std_logic_vector(6 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if avs_write = '1' then
                if avs_writedata = x"F7" then
                    ram(to_integer(unsigned(avs_address))) <= x"00";
                else
                    ram(to_integer(unsigned(avs_address))) <= std_logic_vector(unsigned(avs_writedata) + to_unsigned(1, 8));
                end if;
            end if;
            if avs_read = '1' then
                read_addr <= avs_address;
            end if;
        end if;
    end process;

    avs_readdata <= ram(to_integer(unsigned(read_addr)));
end architecture rtl;