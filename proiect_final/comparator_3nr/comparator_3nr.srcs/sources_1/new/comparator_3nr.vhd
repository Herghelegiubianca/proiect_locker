----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2025 16:07:47
-- Design Name: 
-- Module Name: comparator_3nr - Behavioral
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

entity comparator_3nr is
Port (
Input1: in std_logic_vector (3 downto 0);
Input2: in std_logic_vector (3 downto 0);
Input3: in std_logic_vector (3 downto 0);
sel: in std_logic_vector (2 downto 0);
en: out std_logic );
end comparator_3nr;

architecture Behavioral of comparator_3nr is

component comparator is
Port (
A: in std_logic_vector(3 downto 0);
B: in std_logic_vector (3 downto 0);
Output: out std_logic);
end component;

signal rez1: std_logic;
signal rez2: std_logic;
signal rez3: std_logic;

begin

o1: comparator port map(
A => Input1,
B => Input2,
Output => rez1);

o2: comparator port map(
A => Input1,
B => Input3,
Output => rez2);

o3: comparator port map(
A => Input2,
B => Input3,
Output => rez3);

process(sel, rez1, rez2, rez3)
begin

   case sel is 
       
       when "010" =>
       if (rez1='1') then
       en<='0';
       else
       en<='1';
       end if;
       
       when "100" =>
       if (rez2='1' and rez3='1') then
       en<='0';
       else
       en<='1';
       end if;
       
       when others =>
       en<='0';
   end case;

end process;
end Behavioral;
