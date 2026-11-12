-- Lógica Reconfigurável
-- Dennis Bragagnolo
-- Projeto 1(2020/09/28) - Gerador de Sinais

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY gen IS
	port
	(
		rst			: 	IN STD_LOGIC ;
		clk			: 	IN STD_LOGIC ;
		wr_en		:	 IN STD_LOGIC ;
		rd_en		:	 IN STD_LOGIC ;
		mode		: 	IN STD_LOGIC_VECTOR (1 downto 0);
		wave_type	:	IN STD_LOGIC_VECTOR (1 downto 0);
		start		:	IN STD_LOGIC;
		cicles		:	IN STD_LOGIC_VECTOR (7 downto 0);
		table_add	: 	IN STD_LOGIC_VECTOR (9 downto 0);
		table_data	: 	IN STD_LOGIC_VECTOR (7 downto 0);
		data_out	: 	OUT STD_LOGIC_VECTOR (31 downto 0)
	);
END gen;

ARCHITECTURE a_gen OF gen IS 

	--sinais para controle do gerador
	--signal mode,wave_type: STD_LOGIC_VECTOR (1 downto 0);
	--signal start: STD_LOGIC;
	
	--trava do modo "01" e sinais com delay para seu funcionamento
	signal lock: STD_LOGIC;
	signal mode_d1, mode_d2, w_type_d: STD_LOGIC_VECTOR (1 downto 0);
	--signal cicles_s: STD_LOGIC_VECTOR (7 downto 0);
	
	--sinal utilizado para "sentido" da onda triangular
	signal rise: STD_LOGIC;
	
		-- memoria para armazenar tabela de valores 
	type memory_type is array (INTEGER range 0 to 1023) of STD_LOGIC_VECTOR ( 7 downto 0);
	signal table: memory_type;
	--signal table_add: STD_LOGIC_VECTOR (9 downto 0);
	--signal table_data: STD_LOGIC_VECTOR (7 downto 0);
	
	--USADOS PARA DEBUG
	signal cyc: UNSIGNED (7 downto 0);
	signal mem: UNSIGNED (7 downto 0);

BEGIN
	PROCESS (clk, rst)
		VARIABLE wave_value,mem_pos, cicles_v : INTEGER := 0;
		BEGIN
		If rst = '1' then --sinal de reset
			data_out <= "00000000000000000000000000000000";
			rise <= '0';
			lock <= '0';
			wave_value:= 0;
			mem_pos := 0;
			--start <='0';
			For i IN 0 TO 1023 loop
				table(i) <= "00000000";
			End loop;
		Elsif clk' EVENT AND clk = '1' then
			If wr_en = '1' then
				If lock = '0' then
					
					w_type_d <= wave_type;
					if mode = "01" then
						cicles_v := TO_INTEGER(UNSIGNED(cicles)); --data_in (23 downto 16);
						cyc	<= TO_UNSIGNED(cicles_v,cyc'length);
					End if;
					
					
					
					If mode_d1 = "01" then
						lock <= '1';
					End if;
					mode_d1 <= mode;
					mode_d2 <= mode_d1;

				Else
					--decremento dos ciclos
					If cicles_v = 1 then
						wave_value := 0;
						lock <= '0';
						mode_d1 <= mode;
						mode_d2 <= mode;
					Else
						cicles_v := cicles_v - 1;
						cyc	<= TO_UNSIGNED(cicles_v,cyc'length);
					End if;
				End if;

				--MODOS DE OPERACAO
				--geracao de onda continua
				If mode_d2 = "00" OR mode_d2 ="01" then
					--start <= data_in (7);
					If start = '1' OR mode_d2 ="01" then
						If w_type_d = "00" then --onda triangular
							If rise = '1' then --subida
								If wave_value < 255 then
									wave_value := wave_value +1;
								Else
									rise <= '0';
									wave_value := wave_value -1;
								End if;
							Else -- descida
								If wave_value > 0 then
									wave_value := wave_value -1;
								Else
									rise <= '1';
									wave_value := wave_value +1;
								End if;
							End if;
						Elsif w_type_d = "01" then --onda dente de serra
							If wave_value < 255 then
								wave_value := wave_value +1;
							Else
								wave_value := 0;
							End if;
						Elsif w_type_d = "10" then --onda quadrada
							If wave_value < 255 then
								wave_value := 255;
							Else
								wave_value := 0;
							End if;						
						Elsif w_type_d = "11" then --onda tabela
							wave_value := TO_INTEGER(UNSIGNED(table (mem_pos)));
							If mem_pos < 1023 then
								mem_pos := mem_pos + 1;
							Else
								mem_pos := 0;
							End if;
						End if;
					Else
						wave_value := 0;
					End if;											
				Elsif mode_d2 = "10" OR mode_d2 = "11" then	
					wave_value := 0;
					--table (TO_INTEGER(SIGNED(table_add))) <= table_data;
				End if;
				
				--modo tabela
				--If mode = "10" then	--gravacao da tabela
				--	table (TO_INTEGER(SIGNED(table_add))) <= table_data;
				--Elsif mode = "11" then	--livre
				--	
				--End if;
			End if;
			If mode = "10" OR mode = "11" then	
				table (TO_INTEGER(SIGNED(table_add))) <= table_data;
			End if;
			If rd_en = '1' then
				data_out <= STD_LOGIC_VECTOR (TO_UNSIGNED(wave_value,data_out'length));
				--data_out <="00000000000000000000000000000010";
			End if;
			mem <= TO_UNSIGNED(mem_pos,mem'length);
		End if; 
		
	END PROCESS;


END a_gen;
