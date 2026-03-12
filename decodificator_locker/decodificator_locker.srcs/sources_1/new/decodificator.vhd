----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2025 22:57:51
-- Design Name: 
-- Module Name: decodificator - Behavioral
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

entity decodificator is
Port (
clk: in std_logic;

An_out: out std_logic_vector (7 downto 0);

Cat: out std_logic_vector (0 to 6);

Counter: in std_logic_vector (2 downto 0);
Input1: in std_logic_vector (3 downto 0);
Input2: in std_logic_vector (3 downto 0);
Input3: in std_logic_vector (3 downto 0));
end decodificator;

architecture Behavioral of decodificator is

component bcd7segment is
Port ( BCDin : in STD_LOGIC_VECTOR (3 downto 0);
       Seven_Segment : out STD_LOGIC_VECTOR (0 to 6);
       Anod_in : in STD_LOGIC_VECTOR (7 DOWNTO 0);
       Anod_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal BCDin: std_logic_vector (3 downto 0);
signal Anod_in: std_logic_vector(7 DOWNTO 0);
signal count: std_logic_vector (16 downto 0):=(others=>'0');
signal stare: std_logic_vector(1 downto 0):="00";

begin

o1: bcd7segment port map (BCDin, Cat, Anod_in, An_out);

process

constant max_value: std_logic_vector(16 downto 0):="11000011010100000";

begin

if (rising_edge(clk)) then
  count<=count+1;
  
if (count=max_value) then
   count <= (others => '0');
   if (Counter="100") then
   BCDin <= "0000";
   Anod_in <= "11111111";
   
   else
        case stare is
          when "00" =>
            if Counter >= "001" then
              BCDin   <= Input1;
              Anod_in <= "01111111";  -- AN0
            else
              Anod_in <= "11111111";
            end if;
            stare <= "01";

          when "01" =>
            if Counter >= "010" then
              BCDin   <= Input2;
              Anod_in <= "10111111";  -- AN1
            else
              Anod_in <= "11111111";
            end if;
            stare <= "10";

          when "10" =>
            if Counter = "011" then
              BCDin   <= Input3;
              Anod_in <= "11011111";  -- AN2
            else
              Anod_in <= "11111111";
            end if;
            stare <= "00";

          when others =>
            stare <= "00";
        end case;
        
   end if;
   end if;
   end if;
end process;
end Behavioral;
