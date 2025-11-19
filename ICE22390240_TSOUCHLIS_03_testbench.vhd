library ieee;
use ieee.std_logic_1164.all;

entity ICE22390240_TSOUCHLIS_03_testbench is
end entity ICE22390240_TSOUCHLIS_03_testbench;

architecture behavioral of ICE22390240_TSOUCHLIS_03_testbench is

  component ICE22390240_TSOUCHLIS_02_MIPS is
    port(
      reset: in std_logic;
      clock: in std_logic
    );
  end component;

  -- Signals for testbench
  signal reset : std_logic;
  signal clock : std_logic;

begin

  -- Instantiate DUT (Device Under Test)
  UUT : ICE22390240_TSOUCHLIS_02_MIPS port map (
    reset => reset,
    clock => clock
  );

  -- Clock generation process
  clock_process: process
  begin
    clock <= '0';
    wait for 10 ns; -- Adjust clock period as needed
    clock <= '1';
    wait for 10 ns;
  end process clock_process;

  -- Initial reset
  process
  begin
    reset <= '1';
    wait for 50 ns; -- Adjust reset pulse width as needed
    reset <= '0';
    wait;
  end process;

end architecture behavioral;
