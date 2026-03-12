----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2025 14:20:06
-- Design Name: 
-- Module Name: test - Behavioral
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

entity test is
    Port (
        en      : in  std_logic;
        UP      : in  std_logic;
        RST     : in  std_logic;
        DOWN    : in  std_logic;
        PRESS   : in  std_logic;
        clk     : in  std_logic;
        led: out std_logic;
        finish  : out std_logic;
        Reg1    : out std_logic_vector(3 downto 0);
        Reg2    : out std_logic_vector(3 downto 0);
        Reg3    : out std_logic_vector(3 downto 0);
        Cat     : out std_logic_vector(0 to 6);
        An_out  : out std_logic_vector(3 downto 0)
    );
end test;

architecture Behavioral of test is

    component numarator_lckr is
        Port (
            UP    : in  std_logic;
            DOWN  : in  std_logic;
            clk   : in  std_logic;
            RST   : in  std_logic;
            EN    : in  std_logic;
            Output: out std_logic_vector(3 downto 0)
        );
    end component;


    component afisare_cod is
        Port (
            stop        : in  std_logic;
            cnt_display : in  std_logic_vector(1 downto 0);
            Input1      : in  std_logic_vector(3 downto 0);
            Input2      : in  std_logic_vector(3 downto 0);
            Input3      : in  std_logic_vector(3 downto 0);
            clk         : in  std_logic;
            an          : out std_logic_vector(3 downto 0);
            cat         : out std_logic_vector(0 to 6)
        );
    end component;

    component comparator is
        Port (
            A      : in  std_logic_vector(3 downto 0);
            B      : in  std_logic_vector(3 downto 0);
            Output : out std_logic
        );
    end component;

    
    signal cnt_display : std_logic_vector(1 downto 0) := "00";

    signal val1, val2, val3 : std_logic_vector(3 downto 0) := (others => '0');

    signal en1, en2, en3 : std_logic;
    signal stop          : std_logic:='0';
    signal cmp1, cmp2, cmp3 : std_logic;

    signal light : std_logic := '0';
    
    

begin


    -- Activează numărătoarele în funcție de stadiul apăsărilor
    en1 <= '1' when cnt_display = "01" else '0';
    en2 <= '1' when cnt_display = "10" else '0';
    en3 <= '1' when cnt_display = "11" else '0';

    -- Numărătoarele
    u2: numarator_lckr port map (
        UP => UP,
        DOWN => DOWN,
        clk => clk,
        RST => RST,
        EN => en1,
        Output => val1
    );

    u3: numarator_lckr port map (
        UP => UP,
        DOWN => DOWN,
        clk => clk,
        RST => RST,
        EN => en2,
        Output => val2
    );

    u4: numarator_lckr port map (
        UP => UP,
        DOWN => DOWN,
        clk => clk,
        RST => RST,
        EN => en3,
        Output => val3
    );

    -- Afisarea codului
    u5: afisare_cod port map (
        stop => stop,
        cnt_display => cnt_display,
        Input1 => val1,
        Input2 => val2,
        Input3 => val3,
        clk => clk,
        an => An_out,
        cat => Cat
    );

    -- Comparatorii pentru validarea codului
    u6: comparator port map (A => val1, B => val2, Output => cmp1);
    u7: comparator port map (A => val1, B => val3, Output => cmp2);
    u8: comparator port map (A => val2, B => val3, Output => cmp3);

    -- Procesul principal: gestionează schimbarea stadiilor de apăsare și validarea codului
    process(clk, RST)
    begin
        if RST = '1' then
            cnt_display <= "00";
            light <= '0';
            stop<='0';
        elsif rising_edge(clk) and (en='1') then
            if PRESS = '1' then
                case cnt_display is
                    when "00" =>
                        stop<='0';
                        cnt_display <= "01";
                        light<='1';
                   
                    when "01" =>
                        cnt_display <= "10";
                    when "10" =>
                        if cmp1 = '1' then
                            cnt_display <= "11";
                        else
                            cnt_display <= "10"; -- rămâne la 10 dacă nu sunt egale
                        end if;
                    when "11" =>
                        if cmp1 = '1' and cmp2 = '1' and cmp3 = '1' then
                            cnt_display <= "00"; -- reset la final
                            light<='0';
                            stop<='1';
                        else
                            cnt_display <= "11"; -- rămâne la 11 dacă codul nu e valid
                        end if;
                end case;
            end if;
        end if;
    end process;

    -- Ieșirile reg1, reg2, reg3 - valorile celor 3 coduri introduse
    Reg1 <= val1;
    Reg2 <= val2;
    Reg3 <= val3;
    led<=light;
    finish<=stop;
end Behavioral;


