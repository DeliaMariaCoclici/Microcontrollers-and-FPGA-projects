----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2023 02:57:02 PM
-- Design Name: 
-- Module Name: tb_main - Behavioral
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

entity tb_main is
--  Port ( );
end tb_main;

architecture Behavioral of tb_main is

component main is
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
end component main;

signal CLK : STD_LOGIC;
signal Reset : STD_LOGIC;
signal Start : STD_LOGIC;
signal SelTempOk : STD_LOGIC;
signal OptiuneTemp : STD_LOGIC_VECTOR (1 downto 0);
signal Btn_gatire : STD_LOGIC;
signal SemnExtra : STD_LOGIC;
signal GatireExtraOk : STD_LOGIC;
signal Getire_extra : STD_LOGIC_VECTOR (1 downto 0);
signal AlegeTemp : STD_LOGIC;
signal Preincalzire : STD_LOGIC;
signal InsertMancare : STD_LOGIC;
signal Gatire : STD_LOGIC;
signal ExtindereGatire : STD_LOGIC;
signal Final : STD_LOGIC;

begin

clock_process :process
begin
     clk <= '0';
     wait for 10 ns;
     clk <= '1';
     wait for 10 ns;
end process;

ust: main port map(CLK,
           Reset,
           Start,
           SelTempOk,
           OptiuneTemp,
           Btn_gatire,
           SemnExtra,
           GatireExtraOk,
           Getire_extra,
           AlegeTemp,
           Preincalzire,
           InsertMancare,
           Gatire,
           ExtindereGatire,
           Final);

process
begin

--reset
Reset <= '1';
wait for 20 ns;

--start
Reset <= '0';
Start <= '1';
wait for 20 ns;

--select temperatura
Start <= '0';
SelTempOk <= '1';
OptiuneTemp <= "01";
wait for 20 ns;
--wait for 20 ns; --to remove for original

--preincalzire
SelTempOk <= '0';
wait for 20*220 ns; --astept atatea cicluri cat e necesar pt preincalzire + extra un ciclu

--astept mancare
Btn_gatire <= '1';
wait for 20 ns;

--gatire astept 25 min
wait for 20*25 ns;

--extra gatire
GatireExtraOk <='1';
SemnExtra <= '1';
Getire_extra <= "10";
wait for 20 ns;



wait;

end process;

end Behavioral;
