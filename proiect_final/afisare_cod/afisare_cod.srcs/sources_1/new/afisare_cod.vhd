----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2025 22:52:06
-- Design Name: 
-- Module Name: afisare_cod - Behavioral
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
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity afisare_cod is
Port ( 
stop: in std_logic;
cnt_display: in std_logic_vector(1 downto 0);
Input1: in std_logic_vector (3 downto 0);
Input2: in std_logic_vector (3 downto 0);
Input3: in std_logic_vector (3 downto 0);
clk: in std_logic;
an: out std_logic_vector(3 downto 0);
cat: out std_logic_vector(0 to 6)
);
end afisare_cod;

architecture Behavioral of afisare_cod is
component bcd7segment is
Port ( BCDin : in STD_LOGIC_VECTOR (3 downto 0);
       Seven_Segment : out STD_LOGIC_VECTOR (0 to 6);
       Anod_in : in STD_LOGIC_VECTOR (3 DOWNTO 0);
       Anod_out : out STD_LOGIC_VECTOR (3 downto 0));
end component;
signal BCDin: std_logic_vector (3 downto 0);
signal Anod_in: std_logic_vector(3 DOWNTO 0);
signal count: std_logic_vector (16 downto 0):=(others=>'0');
signal stare: std_logic_vector(1 downto 0);

begin
c1:bcd7segment port map(BCDin,cat,Anod_in,an);
process
constant max_value: std_logic_vector(16 downto 0):="11000011010100000";
begin
if (rising_edge(clk)) then
count<=count+1;
if(count=max_value) then
count <= (others => '0');
if (stare="00") then
BCDin<=Input1;
if (stop='0' and cnt_display>="01") then
Anod_in<="1011";
else
Anod_in<="1111";
end if;
stare<=stare+1;
elsif(stare="01") then
BCDin<= Input2;
if(stop='0' and cnt_display>="10") then
Anod_in<="1101";
else
Anod_in<="1111";
end if;
stare<=stare+1;
elsif(stare="10") then
BCDin<=Input3;
if(stop='0' and cnt_display="11") then
Anod_in<="1110";
else
Anod_in<="1111";
end if;
stare<="00";
else
Anod_in<="1111";
end if;
end if;
end if;
end process;

end Behavioral;
