library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignExtender is port(
  SignIn : in std_logic_vector(15 downto 0);
  SignOut : out std_logic_vector(31 downto 0));
end SignExtender;

architecture behavioral of SignExtender is 
  signal ones : std_logic_vector(15 downto 0) := (others=>'1');
  signal zeros : std_logic_vector(15 downto 0) := (others=>'0');
begin
  SignOut <= ones & SignIn when SignIn(15)='1' else
             zeros & SignIn when SignIn(15)='0';
end behavioral;
  