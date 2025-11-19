library ieee;
use ieee.std_logic_1164.all;

-- Include numeric_std if not already included in your FullAdder entity
use ieee.numeric_std.all;

entity FullAdder_tb is
end entity FullAdder_tb;

architecture tb of FullAdder_tb is

  -- Component declaration for FullAdder
  component FullAdder is
    port(
      in1, in2 : in std_logic_vector(31 downto 0);
      Cin : in std_logic_vector(0 downto 0);
      Cout : out std_logic;
      sum : out std_logic_vector(31 downto 0)
    );
  end component;

  -- Signals for testbench
  signal in1, in2 : std_logic_vector(31 downto 0);
  signal Cin : std_logic_vector(0 downto 0);
  signal Cout : std_logic;
  signal sum : std_logic_vector(31 downto 0);

  -- Expected results
  constant expected_sum : std_logic_vector(31 downto 0) := x"55555555";
  constant expected_cout : std_logic := '1';

begin

  -- Instantiate FullAdder entity
  UUT : FullAdder port map (
    in1 => in1,
    in2 => in2,
    Cin => Cin,
    Cout => Cout,
    sum => sum
  );

  -- Test process
  process
  begin
    -- Apply test inputs
    in1 <= x"80000000";
    in2 <= x"80000000";
    Cin <= (others => '0'); -- Set carry-in to 0

    -- Wait for some simulation time
    wait for 50 ns;

    -- Check outputs
    if Cout /= expected_cout then
      --report "Error: Carry-out mismatch. Expected: '1', Actual: " & std_logic'image(cout);
    end if;

    if sum /= expected_sum then
      --report "Error: Sum mismatch. Expected: " & x"55555555" & ", Actual: ";
    end if;

    wait;
  end process;

end architecture tb;
