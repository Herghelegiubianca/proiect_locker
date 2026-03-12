----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2025 15:23:24
-- Design Name: 
-- Module Name: demux_reg - Behavioral
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

entity demux_reg is
Port (
Input: in std_logic_vector(3 downto 0);
En: in std_logic;
Output1: out std_logic_vector(3 downto 0);
Output2: out std_logic_vector(3 downto 0);
Output3: out std_logic_vector(3 downto 0);
Sel: in std_logic_vector(2 downto 0));
end demux_reg;

architecture Behavioral of demux_reg is

begin
process
begin

Output1<=(others=>'0');
Output2<=(others=>'0');
Output3<=(others=>'0');


if (En='1') then
    
    case Sel is
    when "010" =>
    Output1<=Input;
    when "011" =>
    Output2<=Input;
    when "100" =>
    Output3<=Input;
    when others =>
    null;
    end case;

end if;
end process;
end Behavioral;