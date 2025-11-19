library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX32 is port (
  MUXin1 : in std_logic_vector(31 downto 0);
  MUXin2 : in std_logic_vector(31 downto 0);
  MUXout : out std_logic_vector(31 downto 0);
  en : in std_logic);
end mux32;

architecture dataflow of MUX32 is 
begin
  MUXout <= MUXin1 when en='0' else 
            MUXin2 when en='1';
end dataflow;
