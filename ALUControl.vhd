library ieee;
use ieee.std_logic_1164.all;

entity ALUControl is port(
	ALUop: in std_logic_vector(2 downto 0);
	Funct: in std_logic_vector(5 downto 0);
	ALUControlOut: out std_logic_vector(3 downto 0));
end ALUControl;

architecture dataflow of ALUControl is
	
	signal tmpFunct: std_logic_vector(3 downto 0) := (others => '0');
	signal tmpALUop: std_logic_vector(3 downto 0) := (others => '0');
begin							 
	with Funct select
		tmpFunct <=
			"0001" when "100000", --add/sub
			"1111" when others;
			
		with ALUop select
			tmpALUop <=
				"0001" when "001", --store/load
				"1011" when "011", --bne
				"1101" when "100", --addi
				"1111" when others;
				
		with ALUop select
			ALUControlOut <=
				tmpFunct when "000",
				tmpALUop when others;
end dataflow;
