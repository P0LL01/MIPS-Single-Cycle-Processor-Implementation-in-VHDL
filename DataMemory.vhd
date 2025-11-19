library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataMemory is port (
  clock : std_logic;
  Min : in std_logic_vector(31 downto 0); --address from ALU
  WriteData : in std_logic_vector(31 downto 0); --data from second reg
  MemWrite : in std_logic; --write signal from OutputControl
  MemRead : in std_logic; --read signal from OutputControl
  Mout : out std_logic_vector(31 downto 0);
  reset : in std_logic);
end DataMemory;

architecture dataflow of DataMemory is 
  type M_array is array(0 to 15) of std_logic_vector(31 downto 0);
  signal ram : M_array := (others => (others => '0'));
  signal address : integer := 0;
  begin
    address <= to_integer(unsigned(Min)) when (to_integer(unsigned(Min)) <= 15) else 0;
    ram(address) <= WriteData when (MemWrite='1' and reset='0' and rising_edge(clock));
    
    Mout <= ram(address) when (reset = '0' and MemRead = '1') else x"00000000"; 		
end dataflow;
    
