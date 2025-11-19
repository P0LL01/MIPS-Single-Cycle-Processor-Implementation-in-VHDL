library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ICE22390240_TSOUCHLIS_02_MIPS is port(
	reset: in std_logic;
	clock: in std_logic);
end ICE22390240_TSOUCHLIS_02_MIPS;

architecture structural of ICE22390240_TSOUCHLIS_02_MIPS is

	component ALU port(
		ALUin1, ALUin2: in std_logic_vector(31 downto 0);
		op: in std_logic_vector(3 downto 0);
		ALUout: out std_logic_vector(31 downto 0);
		Zero: out std_logic);
	end component;
	--
	component RegisterFile port(
		clock: in std_logic;
		RegIn1: in std_logic_vector(4 downto 0);
		RegIn2: in std_logic_vector(4 downto 0);
		RegWriteIn: in std_logic_vector(4 downto 0);
		DataWriteIn: in std_logic_vector(31 downto 0);
		RegWrite: in std_logic;
		RegOut1: out std_logic_vector(31 downto 0);
		RegOut2: out std_logic_vector(31 downto 0));
	end component;
  --
	component DataMemory port(
		clock: in std_logic;
		Min: in std_logic_vector(31 downto 0);
		WriteData:  in std_logic_vector(31 downto 0);
		MemWrite: in std_logic;
		MemRead: in std_logic;
		Mout: out std_logic_vector(31 downto 0);
		reset: in std_logic);
	end component;
  --
	component InstructionMemory port(
		IMin: in std_logic_vector(31 downto 0);
		IMout: out std_logic_vector(31 downto 0));
	end component;
  --
	component ControlUnit port(
		clock: in std_logic;
		OPcode: in std_logic_vector(5 downto 0);
		RegWrite: out std_logic;
		ALUsrc: out std_logic;
		ALUop: out std_logic_vector(2 downto 0);
		MemWrite: out std_logic;
		MemRead: out std_logic;
		RegDst: out std_logic;
		MemToReg: out std_logic;
		Branch: out std_logic);
	end component;
  --
	component ALUcontrol port(
		ALUop: in std_logic_vector(2 downto 0);
		Funct: in std_logic_vector(5 downto 0);
		ALUcontrolOut: out std_logic_vector(3 downto 0));
	end component;
  --
	component ProgramCounter port(
		PCin: in std_logic_vector(31 downto 0);
		PCout: out std_logic_vector(31 downto 0);
		CLK, Rst: in std_logic);
	end component;
  --
	component mux5_2to1 port(
		MUXin1, MUXin2: in std_logic_vector(4 downto 0);
		MUXout: out std_logic_vector(4 downto 0);
		en: in std_logic);
	end component;
  --
	component SignExtender port(
		SignIn: in std_logic_vector(15 downto 0);
		SignOut: out std_logic_vector(31 downto 0));
	end component;
  --
	component MUX32 port(
		MUXin1, MUXin2: in std_logic_vector(31 downto 0);
		MUXout: out std_logic_vector(31 downto 0);
		en: in std_logic);
	end component;
  --
	component ANDgate is port(
		ANDin1, ANDin2: in std_logic;
		ANDout: out std_logic);
	end component;
	--
	component FullAdder port(
		in1, in2: in std_logic_vector(31 downto 0);
		Cin: in std_logic_vector(0 downto 0);
		Cout: out std_logic;
		sum: out std_logic_vector(31 downto 0));
	end component;
  --
  
  --Control Unit signals
signal RegDst: std_logic;
signal Branch: std_logic;
signal MemRead: std_logic;
signal MemToReg: std_logic;
signal ALUop: std_logic_vector(2 downto 0);
signal MemWrite: std_logic;
signal ALUSrc: std_logic;
signal RegWrite: std_logic;
signal Zero: std_logic;
signal BranchOut: std_logic;

--Program Counter signals
signal PCtoFAorIM: std_logic_vector(31 downto 0); -- PC output towards FullAdder or InstructionMemory
signal number1: std_logic_vector(31 downto 0); --integer number 1
signal FAplusplusOut: std_logic_vector(31 downto 0); -- output of FullAdder + 1
signal FA2toMUX: std_logic_vector(31 downto 0); --FA2 to MUX
signal MUXtoPC: std_logic_vector(31 downto 0); -- MUX to PC

-- others
signal IMoutput: std_logic_vector(31 downto 0); -- InstructionMemory output
signal MUXtoReg: std_logic_vector(4 downto 0); -- MUX to RegisterFile
signal ExtendedSign: std_logic_vector(31 downto 0); -- SignExtension to Adder (Shifter doesnt exist)

signal RegOut1: std_logic_vector(31 downto 0); -- RegisterFile to ALU
signal RegOut2: std_logic_vector(31 downto 0); -- RegisterFile to MUX
signal MUXtoALU: std_logic_vector(31 downto 0); -- MUX to ALU
signal ALUControlToALU: std_logic_vector(3 downto 0);-- ALUcontrolUnit to ALU
signal ALUout: std_logic_vector(31 downto 0); -- ALU output towards DataMemory or MUX	
signal DataWriteIn: std_logic_vector(31 downto 0); -- RegisterFile output towards DataMemory
signal Mout: std_logic_vector(31 downto 0); --DataMemory to MUX

begin

	number1 <= std_logic_vector(to_unsigned(1, 32));
	FA: FullAdder port map (in1 => PCtoFAorIM, in2 => number1, Cin => "0", sum => FAplusplusOut); --Cin is String (0 downto 0)
	FA2: FullAdder port map(in1 => FAplusplusOut, in2 => ExtendedSign, Cin => "0", sum => FA2toMUX); --Cin is String (0 downt 0)
	PC: ProgramCounter port map(PCin => MUXtoPC, PCout => PCtoFAorIM, CLK => clock, Rst => reset);
	IM: InstructionMemory port map(IMin => PCtoFAorIM, IMout => IMoutput);
	MUX_RF: mux5_2to1 port map(MUXin1 => IMoutput(20 downto 16), MUXin2 => IMoutput(15 downto 11), MUXout => MUXtoReg, en => RegDst);
	RF: RegisterFile port map(clock => clock, RegIn1 => IMoutput(25 downto 21), RegIn2 => IMoutput(20 downto 16), RegWriteIn => MUXtoReg, DataWriteIn => DataWriteIn, RegWrite => RegWrite, RegOut1 => RegOut1, RegOut2 => RegOut2);
	CU: ControlUnit port map(clock => clock, OPcode => IMoutput(31 downto 26), RegWrite => RegWrite, ALUsrc => ALUSrc, ALUop => ALUop, MemWrite => MemWrite, MemRead => MemRead, RegDst => RegDst, MemToReg => MemToReg, Branch => Branch);
	ALU_CU: ALUControl port map(ALUop => ALUop, Funct => IMoutput(5 downto 0), ALUControlOut => ALUControlToALU);
	S_EXT: SignExtender port map(SignIn => IMoutput(15 downto 0), SignOut => ExtendedSign);
	MUX_ALU: MUX32 port map(MUXin1 => RegOut2, MUXin2 => ExtendedSign, MUXout => MUXtoALU, en => ALUSrc);
	A_LU: ALU port map(ALUin1 => RegOut1, ALUin2 => MUXtoALU, op => ALUControlToALU, ALUout => ALUout, Zero => Zero);
	DM: DataMemory port map(clock => clock, Min => ALUout, WriteData => RegOut2, MemWrite => MemWrite, MemRead => MemRead, Mout => Mout, reset => reset);
	MUX_DM: MUX32 port map(MUXin1 => ALUout, MUXin2 => Mout, MUXout => DataWriteIn, en => MemToReg);
	BRNCH: ANDgate port map(ANDin1 => Branch, ANDin2 => Zero, ANDout => BranchOut);
	MUX_BRNCH: MUX32 port map(MUXin1 => FAplusplusOut, MUXin2 => FA2toMUX, MUXout => MUXtoPC, en => BranchOut);
	
end structural;












  
  
  
  