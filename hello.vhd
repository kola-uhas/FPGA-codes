----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/19/2026 05:43:48 PM
-- Design Name: 
-- Module Name: hello - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hello is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           speed_sw : in STD_LOGIC_VECTOR (1 downto 0);
           led : out STD_LOGIC);
end hello;

architecture Behavioral of hello is
signal led_toggle : std_logic := '0';
signal count : unsigned (7 downto 0):= (others => '0');
constant prescaler_val : unsigned (7 downto 0) := to_unsigned(49,8); --decimal value is 50 
signal slower_clk:  std_logic := '0';
signal led_toggle_count: unsigned (19 downto 0) := (others => '0'); 
signal speed_val_index: std_logic_vector(2 downto 0);
type speed_val_array is array (3 downto 0) of unsigned(19 downto 0);
signal speed_val : speed_val_array := (to_unsigned(99000,20),to_unsigned(249000,20),to_unsigned(499000,20),to_unsigned(999000,20));
begin
    clk_div: process(clk,rst)
    begin
        if rising_edge(clk) then
            if rst = '1' or count = prescaler_val then
                count <= (others => '0');
                slower_clk <= not slower_clk;
            else
                count <= count + 1;
            end if;
        end if;
    end process;
    
    led_toggle_logic : process(slower_clk)
    begin
        if rising_edge(slower_clk) then
            if led_toggle_count = speed_val(to_integer(unsigned(speed_sw))) then
                led_toggle_count <= (others => '0');
                led_toggle <= not led_toggle;
            else
                led_toggle_count <= led_toggle_count + 1;
            end if;
        end if;
    end process;
led <= led_toggle;
end Behavioral;
