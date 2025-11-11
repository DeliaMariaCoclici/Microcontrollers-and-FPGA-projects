----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2023 12:23:11 PM
-- Design Name: 
-- Module Name: UnitControlMicroprogramata - Behavioral
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
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UnitControlMicroprogramata is
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
end UnitControlMicroprogramata;

architecture Behavioral of UnitControlMicroprogramata is

type ROM_microprog_t is array(0 to 14) of std_logic_vector(11 downto 0);
signal ROM_mem_microprog :  ROM_microprog_t := (x"810", x"022", x"931", x"014",
x"A53", x"086", x"B87", x"C05", x"109", x"DA8", x"02B", x"ECA",
x"04D", x"FEC", x"200");

signal Addr_microprog, Addr_next : STD_LOGIC_VECTOR (3 downto 0);
signal Data_microprog : STD_LOGIC_VECTOR (11 downto 0);
signal T, MC : std_logic;

begin

Data_microprog <= ROM_mem_microprog(conv_integer(Addr_microprog));

MUX_ADDR: process(Data_microprog, T, MC)
begin
if (MC = '0') then --execute
    Addr_next <= Data_microprog(3 downto 0);
elsif (T = '1') then --test
    Addr_next <= Data_microprog(7 downto 4);
    else
    Addr_next <= Data_microprog(3 downto 0);
end if;
end process;

reg_adresa: process(clk)
begin
if Reset = '1' then
    Addr_microprog <= "0000";
elsif clk'event and clk = '1' then
    Addr_microprog <= Addr_next;
end if;
end process;

MC <= Data_microprog(11);

Ld_tmp <= Data_microprog(5);
En_tmp <= Data_microprog(4);
Ld_extra  <= Data_microprog(5);
En_extra <= Data_microprog(6);
En_25 <= Data_microprog(8);
En_5 <= Data_microprog(7);

AlegeTemp <= Data_microprog(5);
Preincalzire <= Data_microprog(4);
InsertMancare <= Data_microprog(7);
Gatire <= Data_microprog(8);
ExtindereGatire <= Data_microprog(6);
Final <= Data_microprog(9);

MUX_TEST: process(Start,SelTempOk,Btn_gatire,GatireExtraOk,FinCnt_temp,FinCnt_extra,
         FinCnt_25,FinCnt_5,Data_microprog)
begin
case Data_microprog(10 downto 8) is
when "000" => T <= Start;
when "001" => T <= SelTempOk;
when "010" => T <= FinCnt_temp;
when "011" => T <= Btn_gatire;
when "100" => T <= FinCnt_5;
when "101" => T <= FinCnt_25;
when "110" => T <= GatireExtraOk;
when others => T <= FinCnt_extra;
end case;
end process;

end Behavioral;
