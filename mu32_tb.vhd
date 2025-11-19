library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux32_tb is 
end mux32_tb;

architecture tb of mux32_tb is 
component mux32 port(
  MUXin1 : in std_logic_vector(31 downto 0);
  MUXin2 : in std_logic_vector(31 downto 0);
  MUXout : out std_logic_vector(31 downto 0);
  en : in std_logic);
end component;

signal MUXin1,MUXin2,MUXout: std_logic_vector(31 downto 0);
signal en: std_logic;

begin
  mux1: mux32 port map (MUXin1=>MUXin1, MUXin2=>MUXin2, MUXout=>MUXout, en=> en);
    process
      begin
        MUXin1 <= x"AAAAAAAA";
        MUXin2 <= x"BBBBBBBB";
        en <= '0';
    wait for 10 ns;

        en <= '1';
    wait for 10 ns;
  end process;
end tb;