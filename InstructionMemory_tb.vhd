library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionMemory_tb is
end InstructionMemory_tb;

architecture tb of InstructionMemory_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component InstructionMemory
        port (
            IMin : in std_logic_vector(31 downto 0);
            IMout : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals for UUT inputs and outputs
    signal IMin : std_logic_vector(31 downto 0) := (others => '0');
    signal IMout : std_logic_vector(31 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: InstructionMemory
        port map (
            IMin => IMin,
            IMout => IMout
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test writing code to memory (indirectly by checking the output)
        -- Check the first instruction (starting at position 0)
        IMin <= std_logic_vector(to_unsigned(0, 32));
        wait for 10 ns;
        assert IMout = X"20000000" report "Test failed for instruction at position 0" severity error;
        
        -- Check the fourth instruction (starting at position 3)
        IMin <= std_logic_vector(to_unsigned(3, 32));
        wait for 10 ns;
        assert IMout = X"20030001" report "Test failed for instruction at position 3" severity error;

        -- Finish the simulation
        wait;
    end process stim_proc;

end tb;

