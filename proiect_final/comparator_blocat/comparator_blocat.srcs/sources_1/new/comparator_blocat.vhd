----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2025 17:08:06
-- Design Name: 
-- Module Name: comparator_blocat - Behavioral
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

entity comparator_blocat is
Port (
en: in std_logic;
cod1: in std_logic_vector(3 downto 0);
cod2: in std_logic_vector(3 downto 0);
cod3: in std_logic_vector(3 downto 0);

unlock1: in std_logic_vector(3 downto 0);
unlock2: in std_logic_vector(3 downto 0);
unlock3: in std_logic_vector(3 downto 0);

rez: out std_logic
 );
end comparator_blocat;

architecture Behavioral of comparator_blocat is

begin

process(en, cod1, cod2, cod3, unlock1, unlock2, unlock3)
begin
       if(en='1') then
       if (cod1=unlock1 and cod2=unlock2 and cod3=unlock3) then
           rez<='1';
       else
           rez<='0';
    end if;       
   end if;
end process;
end Behavioral;
