library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux5_2to1_tb is 
end mux5_2to1_tb;

architecture tb of mux5_2to1_tb is 
component mux5_2to1 port(
  MUXin1 : in std_logic_vector(4 downto 0);
  MUXin2 : in std_logic_vector(4 downto 0);
  MUXout : out std_logic_vector(4 downto 0);
  en : in std_logic);
end component;

signal MUXin1,MUXin2,MUXout: std_logic_vector(4 downto 0);
signal en: std_logic;

begin
  mux1: mux5_2to1 port map (MUXin1=>MUXin1, MUXin2=>MUXin2, MUXout=>MUXout, en=> en);
    process
      begin
        MUXin1 <= "11010";
        MUXin2 <= "01011";
        en <= '0';
    wait for 10 ns;

        en <= '1';
    wait for 10 ns;
  end process;
end tb;
