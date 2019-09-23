library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controle_ula is
	port(
		funct7:	in	std_logic_vector(6 downto 0);
		funct3: 	in std_logic_vector(2 downto 0);
		aluop:	in std_logic_vector(1 downto 0);
		aluctr:	out std_logic_vector(3 downto 0)
	);
end controle_ula;

architecture behavior of controle_ula is
begin 	
	process(funct3, funct7, aluop) begin
	
		case aluop is
			when "00" => aluctr <= "0000"; -- soma
			when "01" => aluctr <= "0001"; -- subtracao
			when "10" => --R-type
				case funct3 is
					when "000" => 
						if (funct7(5) = '1') then
							aluctr <= "0001"; --sub
						else
							aluctr <= "0000"; --add
		            end if;
					when "001" => aluctr <= "0101";
					when "010" => aluctr <= "1000";
					when "011" => aluctr <= "1001";
					when "100" => aluctr <= "0100";
					when "101" =>
						if (funct7(5) = '1') then
							aluctr <= "0111"; --sra
						else
							aluctr <= "0110"; --srl
		            end if;
					when "110" => aluctr <= "0011";
					when "111" => aluctr <= "0010";
					when others => aluctr <= "XXXX";
				end case;
			when "11" => -- I-type
				case funct3 is
					when "000" => aluctr <= "0000"; 
					when "001" => aluctr <= "0101";
					when "010" => aluctr <= "1000";
					when "011" => aluctr <= "1001";
					when "100" => aluctr <= "0100";
					when "101" =>
						if (funct7(5) = '1') then
							aluctr <= "0111"; --sra
						else
							aluctr <= "0110"; --srl
		            end if;
					when "110" => aluctr <= "0011";
					when "111" => aluctr <= "0010";
					when others => aluctr <= "XXXX";
				end case;
			when others =>
				aluctr <= "XXXX";
		end case;
		
	end process;
end architecture behavior;

