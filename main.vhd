----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2023 02:23:02 PM
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main is
    Port ( CLK : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Start : in STD_LOGIC;
           SelTempOk : in STD_LOGIC;
           OptiuneTemp : in STD_LOGIC_VECTOR (1 downto 0);
           Btn_gatire : in STD_LOGIC;
           SemnExtra : in STD_LOGIC;
           GatireExtraOk : in STD_LOGIC;
           Getire_extra : in STD_LOGIC_VECTOR (1 downto 0);
           AlegeTemp : out STD_LOGIC;
           Preincalzire : out STD_LOGIC;
           InsertMancare : out STD_LOGIC;
           Gatire : out STD_LOGIC;
           ExtindereGatire : out STD_LOGIC;
           Final : out STD_LOGIC);
end main;

architecture Behavioral of main is

component Unit_Executie is
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
           FinCnt_5 : out STD_LOGIC);
end component;

component Unit_Control is --component UnitControlMicroprogramata is
    Port ( clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Ld_tmp : out STD_LOGIC; --semnale spre si dinspre UC
           En_tmp : out STD_LOGIC;
           Ld_extra : out STD_LOGIC;
           En_extra : out STD_LOGIC;
           En_25 : out STD_LOGIC;
           En_5 : out STD_LOGIC;
           FinCnt_temp : in STD_LOGIC;
           FinCnt_extra : in STD_LOGIC;
           FinCnt_25 : in STD_LOGIC;
           FinCnt_5 : in STD_LOGIC;
           Start : in STD_LOGIC; --semnale spre si dinspre utilizator
           SelTempOk : in STD_LOGIC;
           Btn_gatire : in STD_LOGIC;
           GatireExtraOk : in STD_LOGIC;
           AlegeTemp : out STD_LOGIC;
           Preincalzire : out STD_LOGIC;
           InsertMancare : out STD_LOGIC;
           Gatire : out STD_LOGIC;
           ExtindereGatire : out STD_LOGIC;
           Final : out STD_LOGIC
           );
end component;

signal Ld_tmp : STD_LOGIC;
signal En_tmp : STD_LOGIC;
signal Ld_extra : STD_LOGIC;
signal En_extra : STD_LOGIC;
signal En_25 : STD_LOGIC;
signal En_5 : STD_LOGIC;
signal FinCnt_temp : STD_LOGIC;
signal FinCnt_extra : STD_LOGIC;
signal FinCnt_25 : STD_LOGIC;
signal FinCnt_5 : STD_LOGIC;

begin

Unit_Executie1 : Unit_Executie port map(clk => clk, 
                                        Reset => Reset, 
                                        OptiuneTemp => OptiuneTemp, 
                                        SemnExtra => SemnExtra, 
                                        GatireExtra => Getire_extra,
                                        Ld_tmp => Ld_tmp,
                                        En_tmp => En_tmp,
                                        Ld_extra => Ld_extra,
                                        En_extra => En_extra,
                                        En_25 => En_25,
                                        En_5 => En_5,
                                        FinCnt_temp => FinCnt_temp,
                                        FinCnt_extra => FinCnt_extra,
                                        FinCnt_25 => FinCnt_25,
                                        FinCnt_5 => FinCnt_5);
                                        
Unit_Control1 : Unit_Control port map(clk, --Unit_Control2 : UnitControlMicroprogramata port map(clk,
                                      Reset,
                                      Ld_tmp, --semnale spre si dinspre UC
                                      En_tmp,
                                      Ld_extra,
                                      En_extra,
                                      En_25,
                                      En_5,
                                      FinCnt_temp,
                                      FinCnt_extra,
                                      FinCnt_25,
                                      FinCnt_5,
                                      Start, --semnale spre si dinspre utilizator
                                      SelTempOk,
                                      Btn_gatire,
                                      GatireExtraOk,
                                      AlegeTemp,
                                      Preincalzire,
                                      InsertMancare,
                                      Gatire,
                                      ExtindereGatire,
                                      Final);

end Behavioral;
