library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gerador_imediatos is
	port (
		instr: in std_logic_vector (31 downto 0);
		imm32: out std_logic_vector(31 downto 0)
	);
end gerador_imediatos;

architecture gen of gerador_imediatos is
	signal immI, immS: std_logic_vector (11 downto 0);
	signal immSB: std_logic_vector (12 downto 0);
	signal immUJ: std_logic_vector (20 downto 0);
	signal immU: std_logic_vector (31 downto 0);
	signal ImmOut: signed(31 downto 0);
	signal op_code: std_logic_vector (7 downto 0);
	signal shamt: std_logic_vector (4 downto 0);
	signal f3: std_logic_vector(2 downto 0);
	constant no_imm: signed := X"00000000";
	
	begin
		genImm: process (op_code, immI, immS, immSB, immUJ, immU, instr, ImmOut, shamt, f3)
	
	begin
		op_code <= "0" & instr(6 downto 0);
		f3 <= instr(14 downto 12);
		immI <= instr(31 downto 20);
		immS <= instr(31 downto 25) & instr(11 downto 7);
		immSB <= instr(31) & instr(7) & instr(30 downto 25) & instr (11 downto 8) & "0";
		immUJ <= instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & "0";
		immU <= instr(31 downto 12) & "000000000000";
		shamt <= instr(24 downto 20);
	
		case op_code is
			when X"33" => ImmOut <= no_imm;
			when X"03"|X"13"|X"67" => 
				case f3 is
					when "001"|"101" => ImmOut <= resize(signed(shamt), 32);
					when others => ImmOut <= resize(signed(immI), 32);
				end case;
			when X"23" => ImmOut <= resize(signed(immS), 32);
			when X"63" => ImmOut <= resize(signed(immSB), 32);
			when X"37" => ImmOut <= resize(signed(immU), 32);
			when X"6F" => ImmOut <= resize(signed(immUJ), 32);
			when others => ImmOut <= no_imm;
		end case;
		
		imm32 <= std_logic_vector(ImmOut);
		
		end process genImm;
end architecture gen;