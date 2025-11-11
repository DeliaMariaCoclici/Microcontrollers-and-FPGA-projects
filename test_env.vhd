library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity test_env is

    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;
 
architecture Behavioral of test_env is
 
component MPG is
    Port ( enable : out STD_LOGIC;
           btn : in STD_LOGIC;
           clk : in STD_LOGIC);
end component;
 
component SSD is
    Port ( clk : in STD_LOGIC;
           digits : in STD_LOGIC_VECTOR(31 downto 0);
           an : out STD_LOGIC_VECTOR(7 downto 0);
           cat : out STD_LOGIC_VECTOR(6 downto 0));
end component;
 
component IFetch
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           BranchAddress : in STD_LOGIC_VECTOR(31 downto 0);
           JumpAddress : in STD_LOGIC_VECTOR(31 downto 0);
           Jump : in STD_LOGIC;
           PCSrc : in STD_LOGIC;
           Instruction : out STD_LOGIC_VECTOR(31 downto 0);
           PCp4 : out STD_LOGIC_VECTOR(31 downto 0));
end component;
 
component ID
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;    
           Instr : in STD_LOGIC_VECTOR(25 downto 0);
           WD : in STD_LOGIC_VECTOR(31 downto 0);
           RegWrite : in STD_LOGIC;
           RegDst : in STD_LOGIC;
           ExtOp : in STD_LOGIC;
           RD1 : out STD_LOGIC_VECTOR(31 downto 0);
           RD2 : out STD_LOGIC_VECTOR(31 downto 0);
           Ext_Imm : out STD_LOGIC_VECTOR(31 downto 0);
           func : out STD_LOGIC_VECTOR(5 downto 0);
           sa : out STD_LOGIC_VECTOR(4 downto 0);
           WriteAddress: inout STD_LOGIC_VECTOR(4 downto 0));
end component;
 
component UC
    Port ( Instr : in STD_LOGIC_VECTOR(5 downto 0);
           RegDst : out STD_LOGIC;
           ExtOp : out STD_LOGIC;
           ALUSrc : out STD_LOGIC;
           Branch : out STD_LOGIC;
           Jump : out STD_LOGIC;
           ALUOp : out STD_LOGIC_VECTOR(2 downto 0);
           MemWrite : out STD_LOGIC;
           MemtoReg : out STD_LOGIC;
           RegWrite : out STD_LOGIC);
end component;
 
component EX is
    Port ( PCp4 : in STD_LOGIC_VECTOR(31 downto 0);
           RD1 : in STD_LOGIC_VECTOR(31 downto 0);
           RD2 : in STD_LOGIC_VECTOR(31 downto 0);
           Ext_Imm : in STD_LOGIC_VECTOR(31 downto 0);
           func : in STD_LOGIC_VECTOR(5 downto 0);
           sa : in STD_LOGIC_VECTOR(4 downto 0);
           ALUSrc : in STD_LOGIC;
           ALUOp : in STD_LOGIC_VECTOR(2 downto 0);
--           Instruction: in std_logic_vector(31 downto 0);
--           regDst: in std_logic;
           BranchAddress : out STD_LOGIC_VECTOR(31 downto 0);
           ALURes : out STD_LOGIC_VECTOR(31 downto 0);
           Zero : out STD_LOGIC
--           wadr:out std_logic_vector(4 downto 0)
           );
end component;
 
component MEM
    port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           ALUResIn : in STD_LOGIC_VECTOR(31 downto 0);
           RD2 : in STD_LOGIC_VECTOR(31 downto 0);
           MemWrite : in STD_LOGIC;			
           MemData : out STD_LOGIC_VECTOR(31 downto 0);
           ALUResOut : out STD_LOGIC_VECTOR(31 downto 0));
end component;
 
signal Instruction, PCp4, RD1, RD2, WD, Ext_imm : STD_LOGIC_VECTOR(31 downto 0); 
signal JumpAddress, BranchAddress, ALURes, ALURes1, MemData : STD_LOGIC_VECTOR(31 downto 0);
signal func : STD_LOGIC_VECTOR(5 downto 0);
signal sa : STD_LOGIC_VECTOR(4 downto 0);
signal WriteAddress: STD_LOGIC_VECTOR(4 downto 0);
signal zero : STD_LOGIC;
signal digits : STD_LOGIC_VECTOR(31 downto 0);
signal en, rst, PCSrc : STD_LOGIC; 

-- main controls 

signal RegDst, ExtOp, ALUSrc, Branch, Jump, MemWrite, MemtoReg, RegWrite : STD_LOGIC;
signal ALUOp : STD_LOGIC_VECTOR(2 downto 0);
 
--pipeline reg

--IF/ID

signal PCinc_IF_ID, instruc_if_id:std_logic_vector(31 downto 0);

--id/ex

signal rd1_id_ex, rd2_id_ex,ext_id_ex,pcinc_id_ex:std_logic_vector(31 downto 0);
signal func_id_ex:std_logic_vector(5 downto 0);
signal rt_id_ex,rs_id_ex,rd_id_ex,sa_id_ex:std_logic_vector(4 downto 0);
signal aluop_id_ex:std_logic_vector(2 downto 0);
signal writeaddr_id_ex:std_logic_vector(4 downto 0);
signal memtoreg_id_ex,regdst_id_ex,regw_id_ex,memw_id_ex,branch_id_ex,alusrc_id_ex:std_logic;

--ex_mem

signal memtoreg_regw, br_memw:std_logic_vector(1 downto 0);
signal braddr_ex_mem,alurez_ex_mem,rd2_ex_mem:std_logic_vector(31 downto 0);
signal extregdst: std_logic_vector(4 downto 0);
signal zero_ex_mem:std_logic;

--memwb

signal memtoreg_regw_memwb:std_logic_vector(1 downto 0);
signal rd_memwb,alures_memwb:std_logic_vector(31 downto 0);
signal extregdst_memwb: std_logic_vector(4 downto 0);
 
begin
     monopulse1 : MPG port map(en, btn(0), clk);

     monopulse2 : MPG port map(rst, btn(1), clk);

    -- main units

   -- inst_IFetch : IFetch port map(clk, rst, en, BranchAddress, JumpAddress, Jump, PCSrc, Instruction, PCp4);

   --inst_IFetch : IFetch port map(clk, rst, en, braddr_ex_mem , JumpAddress, Jump, PCSrc, Instruction, PCp4);

--    inst_ID : ID port map(clk, en, instruc_if_id(25 downto 0), WD, RegWrite, RegDst, ExtOp, RD1, RD2, Ext_imm, func, sa);

--   inst_UC : UC port map(Instruction(31 downto 26), RegDst, ExtOp, ALUSrc, Branch, Jump, ALUOp, memw_, MemtoReg, RegWrite);

--   signal rd1_id_ex, rd2_id_ex,ext_id_ex,pcinc_id_ex:std_logic_vector(31 downto 0);

--signal func_id_ex:std_logic_vector(5 downto 0);

--signal rt_id_ex,rs_id_ex,rd_id_ex,sa_id_ex:std_logic_vector(4 downto 0);

--signal aluop_id_ex:std_logic_vector(2 downto 0);

--signal memtoreg_id_ex,regdst_id_ex,regw_id_ex,memw_id_ex,branch_id_ex,alusrc_id_ex:std_logic;

--    inst_EX : EX port map(pcinc_id_ex, rd1_id_ex, rd2_id_ex, ext_id_ex, func_id_ex, sa_id_ex, alusrc_id_ex, ALUOp_id_ex, BranchAddress, ALURes, Zero); 

--    inst_MEM : MEM port map(clk, en, ALURez_ex_mem, RD2_ex_mem, br_memw(0), MemData, ALURes1);


--           func : in STD_LOGIC_VECTOR(5 downto 0);

--           sa : in STD_LOGIC_VECTOR(4 downto 0);

--           ALUSrc : in STD_LOGIC;

--           ALUOp : in STD_LOGIC_VECTOR(2 downto 0);

--           Instruction: in std_logic_vector(31 downto 0);

--           regDst: in std_logic;

--           BranchAddress : out STD_LOGIC_VECTOR(31 downto 0);

--           ALURes : out STD_LOGIC_VECTOR(31 downto 0);

--           Zero : out STD_LOGIC;

--           wadr:out std_logic_vector(4 downto 0)

--signal rd1_id_ex, rd2_id_ex,ext_id_ex,pcinc_id_ex:std_logic_vector(31 downto 0);

--signal func_id_ex:std_logic_vector(5 downto 0);

--signal rt_id_ex,rs_id_ex,rd_id_ex,sa_id_ex:std_logic_vector(4 downto 0);

--signal aluop_id_ex:std_logic_vector(2 downto 0);

--signal memtoreg_id_ex,regdst_id_ex,regw_id_ex,memw_id_ex,branch_id_ex,alusrc_id_ex:std_logic;
 
IF_Pipe:IFetch port map(clk, rst, en, BranchAddress, JumpAddress, Jump, PCSrc, Instruction, PCp4);
inst_ID : ID port map(clk, en, instruc_if_id(25 downto 0), WD, RegWrite, RegDst, ExtOp, RD1, RD2, Ext_imm, func, sa,WriteAddress);
inst_UC : UC port map(Instruc_if_id(31 downto 26), RegDst, ExtOp, ALUSrc, Branch, Jump, ALUOp, memwrite, MemtoReg, RegWrite);
EX_pipe: EX port map(pcinc_id_ex,rd1_id_ex,rd2_id_ex,ext_id_ex,func_id_ex,sa_id_ex,
alusrc_id_ex, aluop_id_ex,BranchAddress,ALURes,Zero);
mem_pipe: MEM port map(clk,en,alurez_ex_mem,rd2_ex_mem,br_memw(0),memdata,alures1);

process(clk,rst)
begin
if clk='1' and clk'event then
    if rst='1' then
         PCinc_IF_ID<=(others=>'0'); 
         instruc_if_id<=(others=>'0');
          
--id/ex
        rd1_id_ex<=(others=>'0');  rd2_id_ex<=(others=>'0'); ext_id_ex<=(others=>'0'); pcinc_id_ex<=(others=>'0'); 
        func_id_ex<=(others=>'0'); 
        rt_id_ex<=(others=>'0'); rs_id_ex<=(others=>'0'); rd_id_ex<=(others=>'0'); sa_id_ex<=(others=>'0'); 
        aluop_id_ex<=(others=>'0'); 
        writeaddr_id_ex<=(others=>'0'); 
        memtoreg_id_ex<='0';regdst_id_ex<='0';regw_id_ex<='0';memw_id_ex<='0';branch_id_ex<='0';alusrc_id_ex<='0';

--ex_mem
        memtoreg_regw<=(others=>'0');  br_memw<=(others=>'0'); 
        braddr_ex_mem<=(others=>'0'); alurez_ex_mem<=(others=>'0'); rd2_ex_mem<=(others=>'0'); 
        extregdst<=(others=>'0'); 
        zero_ex_mem<='0'; 

--memwb
        memtoreg_regw_memwb<=(others=>'0'); 
        rd_memwb<=(others=>'0'); alures_memwb<=(others=>'0'); 
        extregdst_memwb<=(others=>'0'); 

    else
        PCinc_IF_ID<=PCp4;
        instruc_if_id<=Instruction; 
        rd1_id_ex<=rd1;  
        rd2_id_ex<=rd2; 
        ext_id_ex<=ext_imm; 
        pcinc_id_ex<=PCinc_IF_ID; 
        func_id_ex<=func; 
        sa_id_ex<=sa; 
        aluop_id_ex<=aluop; 
        writeaddr_id_ex<=WriteAddress; 
        memtoreg_id_ex<=memtoreg;
        regdst_id_ex<=regdst;
        regw_id_ex<=regwrite;
        memw_id_ex<=memwrite;
        branch_id_ex<=branch;
        alusrc_id_ex<=alusrc;
        memtoreg_regw<=regw_id_ex&memtoreg_id_ex;  
        br_memw<=branch_id_ex&memw_id_ex; 
        braddr_ex_mem<=branchaddress;
        alurez_ex_mem<=alures; 
        rd2_ex_mem<= rd2_id_ex; 
        extregdst<=writeaddr_id_ex; 
        zero_ex_mem<=zero;
        memtoreg_regw_memwb<=memtoreg_regw; 
        rd_memwb<=memdata; alures_memwb<=alures1; 
        extregdst_memwb<=extregdst;
        end if;
    end if;
end process;
 
      -- Write-Back unit 
    WD <= rd_memwb when memtoreg_regw_memwb(0) = '1' else ALURes_memwb;
 
    -- branch control
    PCSrc <= Zero_ex_mem and br_memw(1) ;
 
    -- jump address
    JumpAddress <= PCp4(31 downto 28) & Instruction(25 downto 0) & "00";
 
   -- SSD display MUX
    with sw(7 downto 5) select
        digits <=  Instruction when "000", 
                   PCp4 when "001",
                   RD1 when "010",
                   RD2 when "011",
                   Ext_Imm when "100",
                   ALURes when "101",
                   MemData when "110",
                   WD when "111",
                   (others => 'X') when others;
     display : SSD port map(clk, digits, an, cat);

    -- main controls on the leds
    led(10 downto 0) <= ALUOp & RegDst & ExtOp & ALUSrc & Branch & Jump & MemWrite & MemtoReg & RegWrite;

end Behavioral;
 