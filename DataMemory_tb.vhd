library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataMemory_tb is
end DataMemory_tb;

architecture tb of DataMemory_tb is
  component DataMemory port( 
  clock : std_logic;
  Min : in std_logic_vector(31 downto 0); --address from ALU
  WriteData : in std_logic_vector(31 downto 0); --data from second reg
  MemWrite : in std_logic; --write signal from OutputControl
  MemRead : in std_logic; --read signal from OutputControl
  Mout : out std_logic_vector(31 downto 0);
  reset : in std_logic);
end component;

signal clock: std_logic;
signal reset: std_logic;
signal Min: std_logic_vector(31 downto 0);
signal WriteData: std_logic_vector(31 downto 0);
signal MemWrite: std_logic;
signal MemRead: std_logic;
signal Mout: std_logic_vector(31 downto 0);

begin
  UUT: DataMemory port map (clock => clock,
      Min => Min,
      WriteData => WriteData,
      MemWrite => MemWrite,
      MemRead => MemRead,
      Mout => Mout,
      reset => reset
    );
    
    clock_process : process
      begin
        while true loop  
        clock <= '0';
        wait for 25 ns;
        clock <= '1';
        wait for 25 ns;
      end loop;
    end process clock_process;
    
    test_process : process
    begin
      -- Initial reset
      reset <= '1';
      wait for 40 ns;
      reset <= '0';

      -- Step 1: Write 5 to memory location 0
      MemWrite <= '1';
      WriteData <= std_logic_vector(to_unsigned(5, 32));
      Min <= std_logic_vector(to_unsigned(0, 32));
      wait for 25 ns;

      -- Step 2: Write 7 to memory location 1
      WriteData <= std_logic_vector(to_unsigned(7, 32));
      Min <= std_logic_vector(to_unsigned(1, 32));
      wait for 25 ns;

      -- Step 3: Read from memory location 0
      MemWrite <= '0';
      MemRead <= '1';
      Min <= std_logic_vector(to_unsigned(0, 32));
      wait for 25 ns;

      -- Check the output value
      assert Mout = std_logic_vector(to_unsigned(5, 32))
      report "Error: Read value from memory location 0 does not match expected value."
      severity error;

      -- End simulation
      wait;
    end process test_process;
end tb;
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      