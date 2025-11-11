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

entity ROM_extra is
    Port ( Addr_extra : in STD_LOGIC_VECTOR (1 downto 0);
           Data_extra : out STD_LOGIC_VECTOR (5 downto 0));
end ROM_extra;

architecture Behavioral of ROM_extra is

type ROM_vector_e is array(0 to 3) of std_logic_vector(5 downto 0);
signal ROM_mem_extra :  ROM_vector_e := ("000101", "001000", "001100", "000000");

begin

Data_extra <= ROM_mem_extra(conv_integer(Addr_extra));

end Behavioral;
