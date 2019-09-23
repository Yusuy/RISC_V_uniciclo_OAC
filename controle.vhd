library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controle is
	port(
		opcode:		in	std_logic_vector(6 downto 0);
		alusrc:		out std_logic;
		mem2reg:		out std_logic;
		regwrite:	out std_logic;
		memread:		out std_logic;
		memwrite:	out std_logic;
		branch:		out std_logic;
		reg_data:	out std_logic;
		pc_ctrl:		out std_logic;
		lui:			out std_logic;
		aluop:		out std_logic_vector(1 downto 0)
	);
end controle;

architecture behavior of controle is
begin
	process(opcode) begin
		case opcode is
			when "0000000" => -- Sem instrucao
				alusrc   <= '0';
				mem2reg  <= '0';
				regwrite <= '0';
				memread	<= '0';
				memwrite <= '0';
				branch	<= '0';
				reg_data <= '0';
				pc_ctrl	<= '0';
				lui		<= '0';
				aluop		<= "00";
			when "0110011" => -- R -type
				alusrc   <= '0';
				mem2reg  <= '0';
				regwrite <= '1';
				memread	<= '0';
				memwrite <= '0';
				branch	<= '0';
				reg_data <= '0';
				pc_ctrl	<= '0';
				lui		<= '0';
				aluop		<= "10";
			when "0010011" => -- I -type
				alusrc   <= '1';
				mem2reg  <= '0';
				regwrite <= '1';
				memread	<= '0';
				memwrite <= '0';
				branch	<= '0';
				reg_data <= '0';
				pc_ctrl	<= '0';
				lui		<= '0';
				aluop		<= "11";
			when "0000011" =>	-- Load
				alusrc   <= '1';
				mem2reg  <= '1';
				regwrite <= '1';
				memread	<= '1';
				memwrite <= '0';
				branch	<= '0';
				reg_data <= '0';
				pc_ctrl	<= '0';
				lui		<= '0';
				aluop		<= "00";
			when "0100011" =>	-- Store
				alusrc   <= '1';
				mem2reg  <= '0';
				regwrite <= '0';
				memread	<= '0';
				memwrite <= '1';
				branch	<= '0';
				reg_data <= '0';
				pc_ctrl	<= '0';
				lui		<= '0';
				aluop		<= "00";
			when "1100011" =>	-- B-Type
				alusrc   <= '0';
				mem2reg  <= '0';
				regwrite <= '0';
				memread	<= '0';
				memwrite <= '0';
				branch	<= '1';
				pc_ctrl	<= '0';
				reg_data <= '0';
				lui		<= '0';
				aluop		<= "01";	
			when "1101111" =>	-- Jal
				alusrc   <= '1';
				mem2reg  <= '0';
				regwrite <= '1';
				memread	<= '0';
				memwrite <= '0';
				branch	<= '0';
				pc_ctrl	<= '1';
				reg_data <= '1';
				lui		<= '0';
				aluop		<= "00";
			when "1100111" =>	-- Jalr
				alusrc   <= '1';
				mem2reg  <= '1';
				regwrite <= '1';
				memread	<= '0';
				memwrite <= '0';
				branch	<= '0';
				pc_ctrl	<= '1';
				reg_data <= '0';
				lui		<= '0';
				aluop		<= "00";
			when "0110111" => -- LUI
				alusrc   <= '1';
				mem2reg  <= '0';
				regwrite <= '1';
				memread	<= '0';
				memwrite <= '0';
				branch	<= '0';
				reg_data <= '0';
				pc_ctrl	<= '0';
				lui		<= '1';
				aluop		<= "00";
			when others =>
				alusrc	<= '-';
				mem2reg  <= '-';
				regwrite <= '-';
				memread  <= '-';
				memwrite <= '-';
				branch   <= '-';
				aluop    <= "--";
		end case;
	end process;	
end architecture behavior;

