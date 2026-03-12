----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2025 22:12:29
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
Output: out std_logic_vector (3 downto 0);
clk: in std_logic;
RST: in std_logic;
sel: in std_logic_vector(2 downto 0);
LOAD: in std_logic );
end registru2;

architecture Behavioral of registru2 is

component mux_reg is
Port (
En: in std_logic;
Input1: in std_logic_vector(3 downto 0);
Input2: in std_logic_vector (3 downto 0);
Input3: in std_logic_vector (3 downto 0);
Output: out std_logic_vector (3 downto 0);
Sel: in std_logic_vector (2 downto 0) );
end component;

component registru_mic is
Port (
RST:in std_logic;
clk: in std_logic;
LOAD: in std_logic;
Input: in std_logic_vector(3 downto 0);
Output: out std_logic_vector(3 downto 0) );
end component;


component demux_reg is
Port (
Input: in std_logic_vector(3 downto 0);
En: in std_logic;
Output1: out std_logic_vector(3 downto 0);
Output2: out std_logic_vector(3 downto 0);
Output3: out std_logic_vector(3 downto 0);
Sel: in std_logic_vector(2 downto 0));
end component;

signal input1: std_logic_vector(3 downto 0);
signal input2: std_logic_vector(3 downto 0);
signal input3: std_logic_vector(3 downto 0);
signal output1: std_logic_vector(3 downto 0);
signal output2: std_logic_vector(3 downto 0);
signal output3: std_logic_vector(3 downto 0);
signal load1: std_logic;
signal load2: std_logic;
signal load3: std_logic;
signal en_mux: std_logic;
signal reg_out: std_logic_vector(3 downto 0);

begin
load1<=LOAD and (not(sel(0))) and sel(1) and (not(sel(2)));
load2<=LOAD and (not(sel(2))) and sel(1) and sel(0);
load3<=LOAD and sel(2) and (not(sel(1))) and (not(sel(0)));
en_mux<=not(LOAD);

demux_inst: demux_reg port map(
  Input => Input,
  En => LOAD,
  Sel => sel,
  Output1 => input1,
  Output2 => input2,
  Output3 => input3
);

reg1: registru_mic port map(RST => RST, clk => clk, LOAD => load1, Input => input1, Output => output1);
reg2: registru_mic port map(RST => RST, clk => clk, LOAD => load2, Input => input2, Output => output2);
reg3: registru_mic port map(RST => RST, clk => clk, LOAD => load3, Input => input3, Output => output3);

mux_inst: mux_reg port map(
  En => en_mux,
  Input1 => output1,
  Input2 => output2,
  Input3 => output3,
  Output => reg_out,
  Sel => sel
);

Output<=reg_out;
end Behavioral;
