----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2025 20:47:13
-- Design Name: 
-- Module Name: mux_reg - Behavioral
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

entity mux_reg is
Port (
En: in std_logic;
Input1: in std_logic_vector(3 downto 0);
Input2: in std_logic_vector (3 downto 0);
Input3: in std_logic_vector (3 downto 0);
Output: out std_logic_vector (3 downto 0);
Sel: in std_logic_vector (2 downto 0) );
end mux_reg;

architecture Behavioral of mux_reg is

begin
process
begin 

Output<=(others=>'0');

if (En='1') then
   
   case Sel is
   when "010" =>
   Output<=Input1;
   when "011" =>
   Output<=Input2;
   when "100" =>
   Output<=Input3;
   when others =>
   null;
   end case;
end if;
end process;
end Behavioral;
