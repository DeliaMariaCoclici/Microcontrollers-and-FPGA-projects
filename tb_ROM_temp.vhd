----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2023 02:32:06 PM
-- Design Name: 
-- Module Name: tb_ROM_temp - Behavioral
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

entity tb_ROM_temp is
end tb_ROM_temp;

architecture Behavioral of tb_ROM_temp is

component ROM_temp is
    Port ( Addr_temp : in STD_LOGIC_VECTOR (1 downto 0);
           Data_temp : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal Addr_temp_tb : STD_LOGIC_VECTOR (1 downto 0);
signal Data_temp_tb : STD_LOGIC_VECTOR (7 downto 0);

begin

ROM_temp1 : ROM_temp port map(Addr_temp_tb, Data_temp_tb);

process
begin

Addr_temp_tb <= "00";
wait for 20 ns;

Addr_temp_tb <= "01";
wait for 20 ns;

Addr_temp_tb <= "11";
wait for 20 ns;

Addr_temp_tb <= "10";
wait for 20 ns;

wait;

end process;

end Behavioral;
