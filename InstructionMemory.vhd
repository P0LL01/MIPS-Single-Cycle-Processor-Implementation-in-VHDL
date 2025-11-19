library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionMemory is port(
  IMin : in std_logic_vector(31 downto 0);
  IMout : out std_logic_vector(31 downto 0));
end InstructionMemory;

architecture behavioral of InstructionMemory is 
  type IM_array is array(0 to 15) of std_logic_vector(31 downto 0); -- 16 slots of 32 bits each
	signal commands: IM_array:=(X"20000000", -- addi $0, $0, 0
								X"20420000", -- addi $2, $2, 0
								X"20820000", -- addi $2, $4, 0
								X"20030001", -- addi $3, $0, 1
								X"20050003", -- addi $5, $0, 3
								X"00603020", -- L1: add $6, $3, $0
								X"AC860000", -- sw $6, 0($4)
								X"20630001", -- addi $3, $3, 1
								X"20840001", -- addi $4, $4, 1
								X"20A5FFFF", -- addi $5, $5, -1
								X"14A0FFFA", -- bne $5,$0,L1
								X"00000000", -- slot padding
								X"00000000", -- slot padding
								X"00000000", -- slot padding
								X"00000000", -- slot padding
								X"00000000");-- slot padding

begin

	IMout <= commands(to_integer(unsigned(IMin))); --assigning a value (instruction) from the commands array to the signal IMout based on the value of IMin

end behavioral;