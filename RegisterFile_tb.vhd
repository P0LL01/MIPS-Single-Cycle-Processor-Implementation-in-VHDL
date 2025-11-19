library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFile_tb is
end RegisterFile_tb;

architecture tb of RegisterFile_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component RegisterFile
        port (
            clock: in std_logic;
            RegIn1: in std_logic_vector(4 downto 0);
            RegIn2: in std_logic_vector(4 downto 0);
            RegWriteIn: in std_logic_vector(4 downto 0);
            DataWriteIn: in std_logic_vector(31 downto 0);
            RegWrite: in std_logic;
            RegOut1: out std_logic_vector(31 downto 0);
            RegOut2: out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals for UUT inputs and outputs
    signal clock: std_logic := '0';
    signal RegIn1: std_logic_vector(4 downto 0) := (others => '0');
    signal RegIn2: std_logic_vector(4 downto 0) := (others => '0');
    signal RegWriteIn: std_logic_vector(4 downto 0) := (others => '0');
    signal DataWriteIn: std_logic_vector(31 downto 0) := (others => '0');
    signal RegWrite: std_logic := '0';
    signal RegOut1: std_logic_vector(31 downto 0);
    signal RegOut2: std_logic_vector(31 downto 0);

    -- Clock period definition
    constant CLOCK_PERIOD: time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: RegisterFile
        port map (
            clock => clock,
            RegIn1 => RegIn1,
            RegIn2 => RegIn2,
            RegWriteIn => RegWriteIn,
            DataWriteIn => DataWriteIn,
            RegWrite => RegWrite,
            RegOut1 => RegOut1,
            RegOut2 => RegOut2
        );

    -- Clock process
    clock_process :process
    begin
        while True loop
            clock <= '0';
            wait for CLOCK_PERIOD / 2;
            clock <= '1';
            wait for CLOCK_PERIOD / 2;
        end loop;
    end process clock_process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize Inputs
        RegWrite <= '0';
        RegIn1 <= "00000";
        RegIn2 <= "00000";
        RegWriteIn <= "00000";
        DataWriteIn <= (others => '0');
        wait for 20 ns;

        -- Write 5 to register $3
        RegWrite <= '1';
        RegWriteIn <= "00011";
        DataWriteIn <= std_logic_vector(to_unsigned(5, 32));
        wait for CLOCK_PERIOD;

        -- Write 7 to register $4
        RegWriteIn <= "00100";
        DataWriteIn <= std_logic_vector(to_unsigned(7, 32));
        wait for CLOCK_PERIOD;

        -- Write 9 to register $5
        RegWriteIn <= "00101";
        DataWriteIn <= std_logic_vector(to_unsigned(9, 32));
        wait for CLOCK_PERIOD;

        -- Read from registers $3 and $4
        RegWrite <= '0';
        RegIn1 <= "00011";
        RegIn2 <= "00100";
        wait for CLOCK_PERIOD;

        -- Check the output values
        assert RegOut1 = std_logic_vector(to_unsigned(5, 32)) report "Test failed for register $3" severity error;
        assert RegOut2 = std_logic_vector(to_unsigned(7, 32)) report "Test failed for register $4" severity error;

        -- Finish the simulation
        wait;
    end process stim_proc;

end tb;
