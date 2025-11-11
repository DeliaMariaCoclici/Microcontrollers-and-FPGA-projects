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

entity CNT_extra is
    Port ( Data_extra : in STD_LOGIC_VECTOR (5 downto 0);
           Rst_extra : in STD_LOGIC;
           Ld_extra : in STD_LOGIC;
           En_extra : in STD_LOGIC;
           clk : in STD_LOGIC;
           Num_extra : out STD_LOGIC_VECTOR (5 downto 0);
           FinCnt_extra : out STD_LOGIC);
end CNT_extra;

architecture Behavioral of CNT_extra is

signal cnt_extra_s : STD_LOGIC_VECTOR (5 downto 0);

begin

process(clk, Rst_extra)
begin
if Rst_extra = '1' then
    cnt_extra_s <= "000000";
elsif clk'event and clk = '1' then
    if Ld_extra = '1' then
        cnt_extra_s <= Data_extra;
    elsif En_extra = '1' then
        cnt_extra_s <= cnt_extra_s - 1;
    end if;
end if;
end process;

process(cnt_extra_s)
begin
if cnt_extra_s = x"00" then
    FinCnt_extra <= '1';
    else
    FinCnt_extra <= '0';
end if;
end process;

Num_extra <= cnt_extra_s;

end Behavioral;
