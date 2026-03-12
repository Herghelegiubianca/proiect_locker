----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2025 15:36:17
-- Design Name: 
-- Module Name: locker - Behavioral
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

entity locker is
    Port (
        UP       : in  std_logic;
        RST      : in  std_logic;
        DOWN     : in  std_logic;
        PRESS    : in  std_logic;
        clk      : in  std_logic;
        led_int  : out std_logic;
        led_liber: out std_logic;
        Cat      : out std_logic_vector(0 to 6);
        An       : out std_logic_vector(3 downto 0)
    );
end locker;

architecture Behavioral of locker is

    component mpg is
        Port (
            btn : in  std_logic;
            clk : in  std_logic;
            en  : out std_logic
        );
    end component;

    component test is
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
end component;


    component comparator_blocat is
        Port (
            en      : in  std_logic;
            cod1    : in  std_logic_vector(3 downto 0);
            cod2    : in  std_logic_vector(3 downto 0);
            cod3    : in  std_logic_vector(3 downto 0);
            unlock1 : in  std_logic_vector(3 downto 0);
            unlock2 : in  std_logic_vector(3 downto 0);
            unlock3 : in  std_logic_vector(3 downto 0);
            rez     : out std_logic
        );
    end component;

    -- Semnale interne
     signal en1: std_logic;
    signal finish_free    : std_logic;
    signal finish_blocked : std_logic;

    signal reg1, reg2, reg3 : std_logic_vector(3 downto 0);
    signal reg4, reg5, reg6 : std_logic_vector(3 downto 0);

    signal blocat           : std_logic := '0';

    signal cat_l, cat_b    : std_logic_vector(0 to 6);
    signal an_l, an_b      : std_logic_vector(3 downto 0);

    signal rez_cmp         : std_logic;

    signal led_l,led_b: std_logic:='0';
    
    signal res_b: std_logic:='0';
    signal res_l: std_logic:='0';
    
    signal unlocked: std_logic:='0';
    signal still_locked: std_logic:='0';
    signal lckd: std_logic:='0';
    signal press_f: std_logic;
    
begin
    en1<=not(blocat);
    res_b<=RST or still_locked;
    res_l<=RST or unlocked;
    
    
    -- Debounce / detectare apasare buton PRESS
    u1: mpg port map (
        btn => PRESS,
        clk => clk,
        en  => press_f
    );
    
    -- Instantiere stare libera
    o1: test port map(
        en => en1,
        UP => UP,
        RST => res_l,
        DOWN => DOWN,
        PRESS =>  press_f,
        clk => clk,
        led=> led_l,
        finish => finish_free,
        Reg1 => reg1,
        Reg2 => reg2,
        Reg3 => reg3,
        Cat => cat_l,
        An_out => an_l
    );

    -- Instantiere stare blocata
    o2: test port map(
        en => blocat,
        UP => UP,
        RST => res_b,
        DOWN => DOWN,
        PRESS =>  press_f,
        clk => clk,
        led=> led_b,
        finish => finish_blocked,
        Reg1 => reg4,
        Reg2 => reg5,
        Reg3 => reg6,
        Cat => cat_b,
        An_out => an_b
    );

    -- Comparator coduri
    o3: comparator_blocat port map(
        en => blocat,
        cod1 => reg1,
        cod2 => reg2,
        cod3 => reg3,
        unlock1 => reg4,
        unlock2 => reg5,
        unlock3 => reg6,
        rez => rez_cmp
    );

    -- Logica de blocare/deblocare
    process(clk, RST)
    begin
        if RST = '1' then
            blocat <= '0'; -- stare initiala liber
            unlocked<='0';
            still_locked<='0';
        elsif rising_edge(clk) then
        still_locked<='0';
        unlocked<='0';
            if blocat = '0' and finish_free = '1' then
                blocat <= '1'; -- blocheaza daca testul din liber s-a terminat
                still_locked <= '1';

              
            elsif blocat = '1' and rez_cmp = '1' and finish_blocked='1' then
                blocat <= '0'; 
               unlocked<='1';
               still_locked <= '0';
            elsif blocat ='1' and rez_cmp='0' and finish_blocked='1' then
                blocat<='1';
                still_locked <= '1';
               -- deblocheaza daca codul este corect
            end if;
        end if;
    end process;

    -- Selectie iesiri in functie de stare
   process(blocat, cat_l, cat_b, an_l, an_b, finish_free, finish_blocked)
begin
    if blocat = '0' then
        Cat <= cat_l;
        An <= an_l;
        led_int<=led_l;
    else
        Cat <= cat_b;
        An <= an_b;
        led_int<=led_b;
    end if;
end process;

led_liber <= blocat;

end Behavioral;

