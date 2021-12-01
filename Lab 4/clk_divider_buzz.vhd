library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.ceil;
use IEEE.math_real.log2;

entity clk_divider_buzz is
    PORT ( clk    		: in  STD_LOGIC; -- clock to be divided
           reset  		: in  STD_LOGIC; -- active-high reset
           enable 		: in  STD_LOGIC; -- active-high enable
			  dis_freq		: in  STD_LOGIC_VECTOR(12 downto 0);
           clock_out   	: out STD_LOGIC -- creates a positive pulse every time current_count hits zero
													 -- useful to enable another device, like to slow down a counter
     --      value  : out STD_LOGIC_VECTOR(integer(ceil(log2(real(period)))) - 1 downto 0) -- outputs the current_count value, if needed
         );
end clk_divider_buzz;

architecture Behavioral of clk_divider_buzz is

  signal current_count : natural;			
  
BEGIN

		
   count: process(clk) begin
     if (rising_edge(clk)) then 
       if (reset = '1') then 
          current_count <= 0 ;
          clock_out          <= '0';										 -- acts as an enable for the counter in freq_buz_gen
       elsif (enable = '1') then 
          if (current_count = 0) then
            current_count <= (to_integer(unsigned(dis_freq))) - 1; -- resets current count
            clock_out          <= '1'; 									 -- pulses to high after dis_freq amount of clk cycles
          else 
            current_count <= current_count - 1;							 -- decrements current_count
            clock_out          <= '0';
          end if;
       else 
          clock_out <= '0';
       end if;
     end if;
   end process;
   
 --  value <= std_logic_vector(to_signed(current_count, value'length)); 
   
END Behavioral;
