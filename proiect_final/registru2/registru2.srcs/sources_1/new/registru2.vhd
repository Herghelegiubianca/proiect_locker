----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2025 15:27:39
-- Design Name: 
-- Module Name: registru2 - Behavioral
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

entity registru2 is
Port (
    Input: in std_logic_vector (3 downto 0);
    Output_1: out std_logic_vector (3 downto 0);
    Output_2: out std_logic_vector (3 downto 0);
    Output_3: out std_logic_vector (3 downto 0);
    clk: in std_logic;
    RST: in std_logic;
    sel: in std_logic_vector(2 downto 0);
    LOAD: in std_logic
);
end registru2;

architecture Behavioral of registru2 is

component registru1 is
Port (
RST:in std_logic;
clk: in std_logic;
LOAD: in std_logic;
Input: in std_logic_vector(3 downto 0);
Output: out std_logic_vector(3 downto 0) );
end component;

signal output1: std_logic_vector(3 downto 0);
signal output2: std_logic_vector(3 downto 0);
signal output3: std_logic_vector(3 downto 0);
signal load1: std_logic;
signal load2: std_logic;
signal load3: std_logic;
signal reg_out: std_logic_vector(3 downto 0);

begin
load1 <= '1' when (sel = "010" and LOAD = '1') else '0';
load2 <= '1' when (sel = "011" and LOAD = '1') else '0';
load3 <= '1' when (sel = "100" and LOAD = '1') else '0';

reg1: registru1 port map(RST => RST, clk => clk, LOAD => load1, Input => Input, Output => output1);
reg2: registru1 port map(RST => RST, clk => clk, LOAD => load2, Input => Input, Output => output2);
reg3: registru1 port map(RST => RST, clk => clk, LOAD => load3, Input => Input, Output => output3);

Output_1 <= output1;
Output_2 <= output2;
Output_3 <= output3;
end Behavioral;
