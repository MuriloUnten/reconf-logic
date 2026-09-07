library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_7seg is
    port (
        input    : in  unsigned(3 downto 0);
        segments : out unsigned(6 downto 0)
    );
end entity;

architecture x of bcd_7seg is
begin
    process(input)
    begin
        case input is
        when "0000" =>
        segments <= "0000001"; --0
        when "0001" =>
        segments <= "1001111"; --1
        when "0010" =>
        segments <= "0010010"; --2
        when "0011" =>
        segments <= "0000110"; --3
        when "0100" =>
        segments <= "1001100"; --4
        when "0101" =>
        segments <= "0100100"; --5
        when "0110" =>
        segments <= "0100000"; --6
        when "0111" =>
        segments <= "0001111"; --7
        when "1000" =>
        segments <= "0000000"; --8
        when "1001" =>
        segments <= "0000100"; --9
        when others =>
        segments <= "1111111"; --null
        end case;
    end process;

end architecture;
