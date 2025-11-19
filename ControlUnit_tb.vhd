library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit_tb is
end entity ControlUnit_tb;

architecture tb of ControlUnit_tb is

  -- Component declaration for ControlUnit
  component ControlUnit is
    port (
      clock: in std_logic;
      OPcode: in std_logic_vector(5 downto 0);
      RegWrite: out std_logic := '0';
      ALUsrc: out std_logic;
      ALUop: out std_logic_vector(2 downto 0);
      MemWrite: out std_logic;
      MemRead: out std_logic;
      RegDst: out std_logic;
      MemToReg: out std_logic;
      Branch: out std_logic
    );
  end component;

  -- Signals for testbench
  signal clock : std_logic := '0';
  signal OPcode : std_logic_vector(5 downto 0);
  signal RegWrite : std_logic;
  signal ALUsrc : std_logic;
  signal ALUop : std_logic_vector(2 downto 0);
  signal MemWrite : std_logic;
  signal MemRead : std_logic;
  signal RegDst : std_logic;
  signal MemToReg : std_logic;
  signal Branch : std_logic;

  -- Clock period
  constant clock_period : time := 20 ns;

begin

  -- Instantiate ControlUnit entity
  UUT : ControlUnit
    port map (
      clock => clock,
      OPcode => OPcode,
      RegWrite => RegWrite,
      ALUsrc => ALUsrc,
      ALUop => ALUop,
      MemWrite => MemWrite,
      MemRead => MemRead,
      RegDst => RegDst,
      MemToReg => MemToReg,
      Branch => Branch
    );

  -- Clock generation process
  clock_process : process
  begin
    while true loop
      clock <= '0';
      wait for clock_period / 2;
      clock <= '1';
      wait for clock_period / 2;
    end loop;
  end process clock_process;

  test_process : process 
  begin
    -- Test addi $0, $0, 0 (opcode for addi is 001000)
    OPcode <= "001000";
    wait for clock_period;

    -- Check outputs
    assert RegWrite = '1' and ALUsrc = '1' and ALUop = "000" and
           MemWrite = '0' and MemRead = '0' and RegDst = '0' and
           MemToReg = '0' and Branch = '0'
    report "Error: Control signals for addi instruction are incorrect."
    severity error;

    -- Test sw $6, 0($4) (opcode for sw is 101011)
    OPcode <= "101011";
    wait for clock_period;

    -- Check outputs
    assert RegWrite = '0' and ALUsrc = '1' and ALUop = "000" and
           MemWrite = '1' and MemRead = '0' and RegDst = '0' and
           MemToReg = '0' and Branch = '0'
    report "Error: Control signals for sw instruction are incorrect."
    severity error;

    -- Test bne $5, $0, L1 (opcode for bne is 000101)
    OPcode <= "000101";
    wait for clock_period;

    -- Check outputs
    assert RegWrite = '0' and ALUsrc = '0' and ALUop = "001" and
           MemWrite = '0' and MemRead = '0' and RegDst = '0' and
           MemToReg = '0' and Branch = '1'
    report "Error: Control signals for bne instruction are incorrect."
    severity error;

    -- End of test
    wait;
  end process test_process;

end tb;