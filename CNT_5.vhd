----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2023 03:10:41 PM
-- Design Name: 
-- Module Name: CNT_Temp - Behavioral
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

entity CNT_5 is
    Port ( Rst_5 : in STD_LOGIC;
           En_5 : in STD_LOGIC;
           clk : in STD_LOGIC;
           Num_5 : out STD_LOGIC_VECTOR (2 downto 0);
           FinCnt_5 : out STD_LOGIC);
end CNT_5;

architecture Behavioral of CNT_5 is

signal cnt_5_s : STD_LOGIC_VECTOR (2 downto 0);

begin

process(clk, Rst_5)
begin
if Rst_5 = '1' then
    cnt_5_s <= "000";
elsif clk'event and clk = '1' then
    if En_5 = '1' then
        cnt_5_s <= cnt_5_s + 1;
    end if;
end if;
end process;

process(cnt_5_s)
begin
if cnt_5_s = "101" then --5 in binary
    FinCnt_5 <= '1';
    else
    FinCnt_5 <= '0';
end if;
end process;

Num_5 <= cnt_5_s;

end Behavioral;
