library ieee;
use ieee.std_logic_1164.all;

entity ALUControl_tb is
end ALUControl_tb;

architecture tb of ALUControl_tb is

    
    component ALUControl
        port (
            ALUop : in std_logic_vector(2 downto 0);
            Funct : in std_logic_vector(5 downto 0);
            ALUControlOut : out std_logic_vector(3 downto 0)
        );
    end component;

    
    signal ALUop : std_logic_vector(2 downto 0);
    signal Funct : std_logic_vector(5 downto 0);
    signal ALUControlOut : std_logic_vector(3 downto 0);

begin

    
    uut: ALUControl
        port map (
            ALUop => ALUop,
            Funct => Funct,
            ALUControlOut => ALUControlOut
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case 1: Funct = 100000, ALUop = 10
        Funct <= "100000";
        ALUop <= "010";
        wait for 10 ns;
        assert ALUControlOut = "0001" report "Test failed for Funct=100000, ALUop=10" severity error;
        
        -- Test case 2: Funct = 100010, ALUop = 10
        Funct <= "100010";
        ALUop <= "010";
        wait for 10 ns;
        assert ALUControlOut = "0001" report "Test failed for Funct=100010, ALUop=10" severity error;

        -- Test case 3: Funct = 111111, ALUop = 00
        Funct <= "111111";
        ALUop <= "000";
        wait for 10 ns;
        assert ALUControlOut = "1111" report "Test failed for Funct=111111, ALUop=00" severity error;

        -- Test case 4: Funct = 111111, ALUop = 01
        Funct <= "111111";
        ALUop <= "001";
        wait for 10 ns;
        assert ALUControlOut = "0001" report "Test failed for Funct=111111, ALUop=01" severity error;

        
        wait;
    end process stim_proc;

end tb;

