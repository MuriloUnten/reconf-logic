Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity counter_4 is
   PORT(RST  : in std_logic;
        CLK  : in std_logic;
        Q    : out unsigned(3 downto 0);
        EN   : in std_logic;
        CLR  : in std_logic;
        LD   : in std_logic;
        LOAD : in unsigned (3 downto 0));
end entity;

Architecture X of counter_4 is
Signal CONT: unsigned (3 downto 0);
Begin
Process (CLK, RST)
   Begin
	If RST = '1' then
	   CONT <= "0000";
	Elsif CLK' event and CLK = '1' then
	   If CLR = '1'then
		CONT <= "0000";
	   Else
		If EN = '1' then
		   If LD = '1' then
			CONT <= LOAD;
		   Else
			CONT <= CONT + 1;
		   End IF;
		End If;
	   End If;
      End If;
End process;
Q <= CONT;
End architecture;