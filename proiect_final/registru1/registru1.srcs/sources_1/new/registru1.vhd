----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2025 15:20:00
-- Design Name: 
-- Module Name: registru1 - Behavioral
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

entity registru1 is
Port (
RST:in std_logic;
clk: in std_logic;
LOAD: in std_logic;
Input: in std_logic_vector(3 downto 0);
Output: out std_logic_vector(3 downto 0) );
end registru1;

architecture Behavioral of registru1 is
signal aux: std_logic_vector (3 downto 0);

begin

process
begin

if (RST='1') then
   aux<="0000";
elsif (rising_edge(clk)) then
   if(LOAD='1') then
   aux<=Input;
   else
   aux<=aux; --face hold
   end if;
end if;
end process;

Output<=aux;

end Behavioral;

