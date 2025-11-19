library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit is port(
	clock: in std_logic;
	OPcode: in std_logic_vector(5 downto 0);
	RegWrite: out std_logic := '0';
	ALUsrc: out std_logic;
	ALUop: out std_logic_vector(2 downto 0);
	MemWrite: out std_logic;
	MemRead: out std_logic;
	RegDst: out std_logic;
	MemToReg: out std_logic;
	Branch: out std_logic);
end ControlUnit;

architecture dataflow of ControlUnit is
begin
	with OPcode select
		RegWrite <=
			('1' and clock) when "100011", --load by memory
			('1' and clock) when "000000", --arithmetic functions
			('1' and clock) when "001000", --addi
			'0' when others;
	
	with OPcode select
		ALUsrc <=
			'1' after 2 ns when "100011", --load word
			'1' after 2 ns when "101011", --store word
			'1' after 2 ns when "001000", --addi
			'0' when others;
	
	with OPcode select
		ALUop <=
			"000" after 2 ns when "000000", --arithmetic operation
			"001" after 2 ns when "100011", --load
			"001" after 2 ns when "101011", --store
			"010" after 2 ns when "000100", --beq
			"011" after 2 ns when "000101", --bne 
			"100" after 2 ns when "001000", --addi
			"111" when others;
		
	with OPcode select
		MemWrite <=
			'1' after 10 ns when "101011", --store only
			'0' when others;
	
	with OPcode select
		MemRead <=
			'1' after 2 ns when "100011", --read only
			'0' when others;
			
	with OPcode select
		MemToReg <=
			'1' after 2 ns when "100011", --read
			'0' when others;
	
	with OPcode select
		RegDst <=
			'0' when "100011", --load
			'0' when "001000", --addi
			'1' when others;
	
	with OPcode select
		Branch <=
		  '1' when "000100", --beq
			'1' when "000101", --bne
			'0' when others;
		
end dataflow;
