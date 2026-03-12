----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2025 14:24:59
-- Design Name: 
-- Module Name: numarator_lckr - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity numarator_lckr is
Port (
UP: in std_logic;
DOWN: in std_logic;
clk: in std_logic;
RST: in std_logic;
EN: in std_logic;
Output: out std_logic_vector(3 downto 0) );
end numarator_lckr;

architecture Behavioral of numarator_lckr is

component MPG is

    Port ( btn : in STD_LOGIC;

           clk : in STD_LOGIC;

           en : out STD_LOGIC);

end component;

signal UP_f: std_logic;
signal DOWN_f: std_logic;
signal aux: std_logic_vector(3 downto 0):=(others=>'0');

begin
o1: MPG port map (UP,clk,UP_f);
o2: MPG port map (DOWN,clk,DOWN_f);

process
begin

if (RST='1') then
aux<="0000";

elsif (rising_edge(clk) and (EN='1')) then

  if (UP_f='1') then
   
     if (aux<"1111") then
     aux<=aux+"0001";
     else
     aux<="0000";
     end if;
     
  elsif (DOWN_f='1') then
  
      if(aux>"0000") then
      aux<=aux-"0001";
      else
      aux<="1111";
      end if;
end if;
end if;
Output<=aux;
end process;
end Behavioral;
