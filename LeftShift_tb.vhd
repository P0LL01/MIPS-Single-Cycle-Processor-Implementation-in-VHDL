library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_LeftShift is
end tb_LeftShift;

architecture Behavioral of tb_LeftShift is
    
    component LeftShift
        port (
            sin : in std_logic_vector(31 downto 0);
            sout : out std_logic_vector(31 downto 0);
            opS : in std_ulogic;
            num : in std_logic_vector(4 downto 0)
        );
    end component;

    
    signal sin : std_logic_vector(31 downto 0) := (others => '0');
    signal sout : std_logic_vector(31 downto 0);
    signal opS : std_ulogic := '0';
    signal num : std_logic_vector(4 downto 0) := (others => '0');

begin
    
    uut: LeftShift
        port map (
            sin => sin,
            sout => sout,
            opS => opS,
            num => num
        );

    
    stim_proc: process
    begin
        -- Test case 1: Shift 0x0FFFFFFF left by 1
        sin <= x"0FFFFFFF";
        opS <= '1';
        num <= "00001"; -- Shift left by 1
        wait for 10 ns;
        
        -- Test case 2: Shift 0x0FFFFFFF left by 2
        sin <= x"0FFFFFFF";
        opS <= '1';
        num <= "00010"; -- Shift left by 2
        wait for 10 ns;
        
        -- Test case 3: Shift 0x0FFFFFFF left by 4
        sin <= x"0FFFFFFF";
        opS <= '1';
        num <= "00100"; -- Shift left by 4
        wait for 10 ns;
        
        -- Test case 4: No shift when opS is '0'
        sin <= x"0FFFFFFF";
        opS <= '0';
        num <= "00100"; -- Attempt to shift left by 4, but opS is '0'
        wait for 10 ns;
        
        -- Test case 5: Shift 0x0FFFFFFF left by 8
        sin <= x"0FFFFFFF";
        opS <= '1';
        num <= "01000"; -- Shift left by 8
        wait for 10 ns;

        -- Test case 6: Shift 0x0FFFFFFF left by 16
        sin <= x"0FFFFFFF";
        opS <= '1';
        num <= "10000"; -- Shift left by 16
        wait for 10 ns;

        
        wait;
    end process stim_proc;

end Behavioral;

