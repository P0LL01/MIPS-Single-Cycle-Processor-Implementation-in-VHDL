library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_tb is
end entity ALU_tb;

architecture tb of ALU_tb is

  -- Component declaration for ALU
  component ALU is
    port (
      ALUin1, ALUin2: in std_logic_vector(31 downto 0);
      op: in std_logic_vector(3 downto 0);
      ALUout: out std_logic_vector(31 downto 0);
      Zero: out std_logic
    );
  end component;

  -- Signals for testbench
  signal ALUin1, ALUin2 : std_logic_vector(31 downto 0);
  signal op : std_logic_vector(3 downto 0);
  signal ALUout : std_logic_vector(31 downto 0);
  signal Zero : std_logic;

  -- Clock period
  constant clock_period : time := 20 ns;

begin

  -- Instantiate ALU entity
  UUT : ALU
    port map (
      ALUin1 => ALUin1,
      ALUin2 => ALUin2,
      op => op,
      ALUout => ALUout,
      Zero => Zero
    );

  -- Test process
  process
  begin
    -- Test 1: 5 + (-4)
    ALUin1 <= std_logic_vector(to_signed(5, 32));
    ALUin2 <= std_logic_vector(to_signed(-4, 32));
    op <= "0001"; -- Addition
    wait for clock_period;

    -- Test 2: 5 + (-5)
    ALUin2 <= std_logic_vector(to_signed(-5, 32));
    wait for clock_period;

    -- Test 3: 7 - 8
    ALUin1 <= std_logic_vector(to_signed(7, 32));
    ALUin2 <= std_logic_vector(to_signed(3, 32));
    op <= "0010"; -- Subtraction
    wait for clock_period;

    -- End of test
    wait;
  end process;

end architecture tb;
