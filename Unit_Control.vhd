----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2023 01:44:14 PM
-- Design Name: 
-- Module Name: Unit_Control - Behavioral
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

entity Unit_Control is
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
end Unit_Control;

architecture Behavioral of Unit_Control is

type stare_t is (Astept, AsteptTemp, Preincalzire_st, InsertFood, Gatire_st, 
    Extra_gatireDec, ExtraGatire, Final_St);
signal Stare, Nx_Stare : stare_t;
    
begin

act_stare : process(clk, Reset)
begin
if Reset = '1' then
    Stare <= Astept;
elsif clk'event and clk = '1' then
    Stare <= Nx_Stare;
end if;
end process;

tranzitii : process(Stare,  FinCnt_temp, FinCnt_extra, FinCnt_25, FinCnt_5,
        Start, SelTempOk, Btn_gatire, GatireExtraOk)
begin
AlegeTemp <= '0';
Ld_tmp    <= '0';
Preincalzire <= '0';
En_tmp       <= '0';
InsertMancare <= '0';
En_5          <= '0';
Gatire <= '0';
En_25  <= '0';
Ld_extra        <= '0';
ExtindereGatire <= '0';
En_extra <= '0';
Final <= '0';
case Stare is
    when Astept => 
        if Start = '1' then
            Nx_Stare <= AsteptTemp;
        else 
            Nx_Stare <= Astept;
        end if;
    when AsteptTemp => 
        AlegeTemp <= '1';
        Ld_tmp <= '1';
        if SelTempOk = '1' then
            Nx_Stare <= Preincalzire_st;
        else 
            Nx_Stare <= AsteptTemp;
        end if;
    when Preincalzire_st =>
        Preincalzire <= '1';
        En_tmp       <= '1';
        if FinCnt_temp = '1' then
            Nx_Stare <= InsertFood;
        else
            Nx_Stare <= Preincalzire_st;
        end if;
     when InsertFood =>
        InsertMancare <= '1';
        En_5          <= '1';
        if Btn_gatire = '0' then
            if FinCnt_5 = '1' then
                Nx_Stare <= Astept; -- au trecut 5 minute si nu s-a inserat
            else 
                Nx_Stare <= InsertFood; -- asteptam
            end if;
        else
            Nx_Stare <= Gatire_st;
        end if;
     when Gatire_st =>
        Gatire <= '1';
        En_25  <= '1';
        if FinCnt_25 = '1' then
            Nx_Stare <= Extra_gatireDec; --s-a terminat gatirea prestabilita
        else
            Nx_Stare <= Gatire_st; --inca gateste
        end if;
     when Extra_gatireDec =>
        Ld_extra        <= '1'; -- incarcam timp extra
        ExtindereGatire <= '1'; --se vor calcula timpii extra!
        if GatireExtraOk = '1' then
            Nx_Stare <= ExtraGatire; --gatim extra timp
        else
            Nx_Stare <= Extra_gatireDec;
        end if;
     when ExtraGatire =>
        ExtindereGatire <= '1'; -- se gateste extra (acelasi semnal va afisa)
        En_extra <= '1';
        if FinCnt_extra = '1' then
            Nx_Stare <= Final_St;
        else
            Nx_Stare <= ExtraGatire;
        end if;
     when Final_St =>
        Final <= '1';
        Nx_Stare <= Astept;
     when Others =>
           Nx_Stare <= Astept;
end case;
end process;
end Behavioral;
