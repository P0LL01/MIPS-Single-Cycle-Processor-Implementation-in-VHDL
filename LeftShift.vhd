library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LeftShift is
    port (
        sin : in std_logic_vector(31 downto 0);
        sout : out std_logic_vector(31 downto 0);
        opS : in std_ulogic;
        num : in std_logic_vector(4 downto 0)
    );
end LeftShift;

architecture Behavioral of LeftShift is
begin
    process(sin, opS, num)
    begin
        if opS = '1' then
            sout <= std_logic_vector(shift_left(unsigned(sin), to_integer(unsigned(num))));
        else
            sout <= sin; -- No shift if opS is not '1'
        end if;
    end process;
end Behavioral;


