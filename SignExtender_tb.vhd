library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignExtender_tb is
end SignExtender_tb;

architecture tb of SignExtender_tb is

    
    component SignExtender
        port (
            SignIn : in std_logic_vector(15 downto 0);
            SignOut : out std_logic_vector(31 downto 0)
        );
    end component;

    
    signal SignIn : std_logic_vector(15 downto 0);
    signal SignOut : std_logic_vector(31 downto 0);

begin

   
    uut: SignExtender
        port map (
            SignIn => SignIn,
            SignOut => SignOut
        );

    
    stim_proc: process
    begin
        -- Test case 1: SignIn = 0xFFFF
        SignIn <= x"FFFF";
        wait for 10 ns;
        assert SignOut = x"FFFFFFFF" report "Test failed for SignIn=0xFFFF" severity error;

        -- Test case 2: SignIn = 0xAAAA
        SignIn <= x"AAAA";
        wait for 10 ns;
        assert SignOut = x"FFFFFFFF" & x"AAAA" report "Test failed for SignIn=0xAAAA" severity error;

        -- Test case 3: SignIn = 0x5555
        SignIn <= x"5555";
        wait for 10 ns;
        assert SignOut = x"00000000" & x"5555" report "Test failed for SignIn=0x5555" severity error;

        
        wait;
    end process stim_proc;

end tb;

