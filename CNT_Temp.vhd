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

entity CNT_Temp is
    Port ( Data_temp : in STD_LOGIC_VECTOR (7 downto 0);
           Rst_tmp : in STD_LOGIC;
           Ld_tmp : in STD_LOGIC;
           En_tmp : in STD_LOGIC;
           clk : in STD_LOGIC;
           Num_temp : out STD_LOGIC_VECTOR (7 downto 0);
           FinCnt_temp : out STD_LOGIC);
end CNT_Temp;

architecture Behavioral of CNT_Temp is

signal cnt_tmp : STD_LOGIC_VECTOR (7 downto 0);

begin

process(clk, Rst_tmp)
begin
if Rst_tmp = '1' then
    cnt_tmp <= "00000000";
elsif clk'event and clk = '1' then
    if Ld_tmp = '1' then
        cnt_tmp <= Data_temp;
    elsif En_tmp = '1' then
        cnt_tmp <= cnt_tmp - 1;
    end if;
end if;
end process;

process(cnt_tmp)
begin
if cnt_tmp = x"00" then
    FinCnt_temp <= '1';
    else
    FinCnt_temp <= '0';
end if;
end process;

Num_temp <= cnt_tmp;

end Behavioral;
