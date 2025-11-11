----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2023 02:24:50 PM
-- Design Name: 
-- Module Name: ROM_temp - Behavioral
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

entity ROM_temp is
    Port ( Addr_temp : in STD_LOGIC_VECTOR (1 downto 0);
           Data_temp : out STD_LOGIC_VECTOR (7 downto 0));
end ROM_temp;

architecture Behavioral of ROM_temp is

type ROM_vector_t is array(0 to 3) of std_logic_vector(7 downto 0);
signal ROM_mem_temp :  ROM_vector_t := (x"B4", x"C8", x"DC", x"F0");

begin

Data_temp <= ROM_mem_temp(conv_integer(Addr_temp));

end Behavioral;
