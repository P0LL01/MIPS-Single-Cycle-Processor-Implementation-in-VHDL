library ieee;
use ieee.std_logic_1164.all;

entity ProgramCounter_tb is
end ProgramCounter_tb;

architecture tb of ProgramCounter_tb is

  component ProgramCounter is
    port (
      PCin : in std_logic_vector(31 downto 0);
      PCout : out std_logic_vector(31 downto 0);
      CLK : in std_logic;
      Rst : in std_logic
    );
  end component;

  -- Signals for testbench
  signal CLK, Rst : std_logic;
  signal test_pc_in, test_pc_out : std_logic_vector(31 downto 0);

begin

  -- Instantiate ProgramCounter entity
  UUT : ProgramCounter port map (
    PCin => test_pc_in,
    PCout => test_pc_out,
    CLK => CLK,
    Rst => Rst
  );

  -- Clock generation process
  clock_process : process
  begin
    CLK <= '0';
    wait for 10 ns;
    CLK <= '1';
    wait for 10 ns;
  end process clock_process;

  -- Test stimulus process
  stim_proc: process
  begin
    -- Initial reset
    Rst <= '1';
    wait for 20 ns;
    Rst <= '0';
    wait for 20 ns;

    -- Apply first test input
    test_pc_in <= x"AAAA_BBBB";
    wait for 20 ns;

    -- Wait for clock edge to check the output
    wait for 20 ns;

    -- Check output
    assert (test_pc_out = x"AAAA_BBBB") report "Error: PC output mismatch for first input" severity error;

    -- Apply second test input
    test_pc_in <= x"FFFF_CCCC";
    wait for 20 ns;

    -- Wait for clock edge to check the output
    wait for 20 ns;

    -- Check output
    assert (test_pc_out = x"FFFF_CCCC") report "Error: PC output mismatch for second input" severity error;

    -- End of test
    wait;
  end process stim_proc;

end architecture tb;

