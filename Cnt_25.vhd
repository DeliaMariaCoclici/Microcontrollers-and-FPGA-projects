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

entity CNT_25 is
    Port ( Rst_25 : in STD_LOGIC;
           En_25 : in STD_LOGIC;
           clk : in STD_LOGIC;
           Num_25 : out STD_LOGIC_VECTOR (4 downto 0);
           FinCnt_25 : out STD_LOGIC);
end CNT_25;

architecture Behavioral of CNT_25 is

signal cnt_25_s : STD_LOGIC_VECTOR (4 downto 0);

begin

process(clk, Rst_25)
begin
if Rst_25 = '1' then
    cnt_25_s <= "00000";
elsif clk'event and clk = '1' then
    if En_25 = '1' then
        cnt_25_s <= cnt_25_s + 1;
    end if;
end if;
end process;

process(cnt_25_s)
begin
if cnt_25_s = "11001" then --25 in binary
    FinCnt_25 <= '1';
    else
    FinCnt_25 <= '0';
end if;
end process;

Num_25 <= cnt_25_s;

end Behavioral;
