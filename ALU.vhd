library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is port(
		ALUin1, ALUin2: in std_logic_vector(31 downto 0);
		op: in std_logic_vector(3 downto 0);
		ALUout: out std_logic_vector(31 downto 0);
		Zero: out std_logic);
end ALU;

architecture dataflow of ALU is
	
	component FullAdder port(
		in1, in2: in std_logic_vector(31 downto 0);
		Cin: in std_logic_vector(0 downto 0);
		Cout: out std_logic;
		sum: out std_logic_vector(31 downto 0));
	end component;
	
	signal Cout: std_logic;
	signal FAout: std_logic_vector(31 downto 0);
	signal X: std_logic_vector(31 downto 0) := (others => 'X');
	
begin
	FA_ALU: FullAdder port map( in1 => ALUin1, in2 => ALUin2, Cin => "0", sum => FAout, Cout => Cout);
	
	with op select
		ALUout <=
			FAout when "0001", --sum
			FAout when "1101", --addi
			X when others;
			
	Zero <= '1' when ( (ALUin1 /= ALUin2) and (op = "1011") ) else '0';
	
end dataflow;

