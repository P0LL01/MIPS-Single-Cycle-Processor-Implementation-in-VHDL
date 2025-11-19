library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFile is port (
		clock: in std_logic;
        RegIn1: in std_logic_vector(4 downto 0);
        RegIn2: in std_logic_vector(4 downto 0);
        RegWriteIn: in std_logic_vector(4 downto 0);
        DataWriteIn: in std_logic_vector(31 downto 0);
        RegWrite: in std_logic;
        RegOut1: out std_logic_vector(31 downto 0);
        RegOut2: out std_logic_vector(31 downto 0));
end RegisterFile;

architecture behavioral of RegisterFile is
    type RF_ARRAY is array(0 to 15) of std_logic_vector(31 downto 0);
	
	signal X: std_logic_vector(31 downto 0) := (others => 'X');
    signal reg: RF_ARRAY := (others => (others => '0'));
	signal RegWriteDelayed: std_logic;
begin
	process (clock) begin
		RegOut1 <= reg(to_integer(unsigned(RegIn1)));
		RegOut2 <= reg(to_integer(unsigned(RegIn2)));
		RegWriteDelayed <= transport RegWrite after 1 ns;	
		if (rising_edge(clock) and RegWriteDelayed = '1' and DataWriteIn /= X) then			
			reg(to_integer(unsigned(RegWriteIn))) <= DataWriteIn;
		end if;
	end process;
end behavioral;
