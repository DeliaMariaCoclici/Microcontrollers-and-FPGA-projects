----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2023 02:58:02 PM
-- Design Name: 
-- Module Name: Unit_Executie - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Unit_Executie is
    Port ( clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           OptiuneTemp : in STD_LOGIC_VECTOR (1 downto 0);
           SemnExtra : in STD_LOGIC;
           GatireExtra : in STD_LOGIC_VECTOR (1 downto 0);
           Ld_tmp : in STD_LOGIC;
           En_tmp : in STD_LOGIC;
           Ld_extra : in STD_LOGIC;
           En_extra : in STD_LOGIC;
           En_25 : in STD_LOGIC;
           En_5 : in STD_LOGIC;
           FinCnt_temp : out STD_LOGIC;
           FinCnt_extra : out STD_LOGIC;
           FinCnt_25 : out STD_LOGIC;
           FinCnt_5 : out STD_LOGIC
           );
end Unit_Executie;

architecture Behavioral of Unit_Executie is

component ROM_temp is
    Port ( Addr_temp : in STD_LOGIC_VECTOR (1 downto 0);
           Data_temp : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component ROM_extra is
    Port ( Addr_extra : in STD_LOGIC_VECTOR (1 downto 0);
           Data_extra : out STD_LOGIC_VECTOR (5 downto 0));
end component;

component ALU is
    Port ( Op1 : in STD_LOGIC_VECTOR (5 downto 0);
           Op2 : in STD_LOGIC_VECTOR (5 downto 0);
           Oper : in STD_LOGIC;
           Rez : out STD_LOGIC_VECTOR (5 downto 0));
end component ALU;

component CNT_Temp is
    Port ( Data_temp : in STD_LOGIC_VECTOR (7 downto 0);
           Rst_tmp : in STD_LOGIC;
           Ld_tmp : in STD_LOGIC;
           En_tmp : in STD_LOGIC;
           clk : in STD_LOGIC;
           Num_temp : out STD_LOGIC_VECTOR (7 downto 0);
           FinCnt_temp : out STD_LOGIC);
end component CNT_Temp;

component CNT_extra is
    Port ( Data_extra : in STD_LOGIC_VECTOR (5 downto 0);
           Rst_extra : in STD_LOGIC;
           Ld_extra : in STD_LOGIC;
           En_extra : in STD_LOGIC;
           clk : in STD_LOGIC;
           Num_extra : out STD_LOGIC_VECTOR (5 downto 0);
           FinCnt_extra : out STD_LOGIC);
end component CNT_extra;

component CNT_25 is
    Port ( Rst_25 : in STD_LOGIC;
           En_25 : in STD_LOGIC;
           clk : in STD_LOGIC;
           Num_25 : out STD_LOGIC_VECTOR (4 downto 0);
           FinCnt_25 : out STD_LOGIC);
end component CNT_25;

component CNT_5 is
    Port ( Rst_5 : in STD_LOGIC;
           En_5 : in STD_LOGIC;
           clk : in STD_LOGIC;
           Num_5 : out STD_LOGIC_VECTOR (2 downto 0);
           FinCnt_5 : out STD_LOGIC);
end component CNT_5;

--data signals
signal Data_temperatura : STD_LOGIC_VECTOR (7 downto 0);
signal Data_extra_Op2 : STD_LOGIC_VECTOR (5 downto 0);
signal Timp_gatire_extra : STD_LOGIC_VECTOR (5 downto 0);

--cnt_Temp signals
signal Num_temp : STD_LOGIC_VECTOR (7 downto 0);

--cnt_extra signals
signal Num_extra : STD_LOGIC_VECTOR (5 downto 0);

--cnt_25 signals
signal Num_25 : STD_LOGIC_VECTOR (4 downto 0);

--cnt_5 signals
signal Num_5 : STD_LOGIC_VECTOR (2 downto 0);

begin

ROM_temp1 : ROM_temp port map(OptiuneTemp, Data_temperatura);
ROM_extra1 : ROM_extra port map(GatireExtra, Data_extra_Op2);
SumScaz : ALU port map("110010", Data_extra_Op2, SemnExtra, Timp_gatire_extra);
CNT_Temp1 : CNT_Temp port map(Data_temperatura, Reset, Ld_tmp, En_tmp, clk, Num_temp, FinCnt_temp);
CNT_extra1 : CNT_extra port map(Timp_gatire_extra, Reset, Ld_extra, En_extra, clk, Num_extra, FinCnt_extra);
CNT_25_1 : CNT_25 port map(Reset, En_25, clk, Num_25, FinCnt_25);
CNT_5_1 : CNT_5 port map(Reset, En_5, clk, Num_5, FinCnt_5);


end Behavioral;
