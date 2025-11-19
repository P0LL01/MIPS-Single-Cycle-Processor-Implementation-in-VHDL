library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ProgramCounter is port(
  PCin : in std_logic_vector(31 downto 0);
  PCout : out std_logic_vector(31 downto 0);
  CLK : in std_logic;
  Rst : in std_logic);
end ProgramCounter;

architecture behavioral of ProgramCounter is 
begin
  process (CLK, Rst) 
    begin
      if Rst = '1' then 
        PCout <= (others => '0'); -- resets the PC
    elsif rising_edge(CLK) then 
      PCout <= PCin; -- the PCin is PC + 1
    end if;
  end process;
end behavioral;

  
  
