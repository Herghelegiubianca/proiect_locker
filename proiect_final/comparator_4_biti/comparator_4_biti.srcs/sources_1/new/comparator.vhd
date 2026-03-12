----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2025 15:27:12
-- Design Name: 
-- Module Name: comparator - Behavioral
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

entity comparator is
Port (
A: in std_logic_vector(3 downto 0);
B: in std_logic_vector (3 downto 0);
Output: out std_logic);
end comparator;

architecture Behavioral of comparator is

signal rez: std_logic;

begin

process (A,B)
begin

  --ma intereseaza sa aflu daca sunt egale sau diferite , prin urmare nu am implementat
  --cele 3 functii: mai mic, mai mare, egal
 
 if(A=B) then
 rez<='0';
 elsif(A/=B) then
 rez<='1';
 
end if;
end process;

Output<=rez;
end Behavioral;
