----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2023 02:46:16 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
    Port ( Op1 : in STD_LOGIC_VECTOR (5 downto 0);
           Op2 : in STD_LOGIC_VECTOR (5 downto 0);
           Oper : in STD_LOGIC;
           Rez : out STD_LOGIC_VECTOR (5 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

process(Op1, Op2, Oper)
begin
if Oper = '0' then
    Rez <= Op1 + Op2;
    else
    Rez <= Op1 - Op2;
end if;
end process;

end Behavioral;
