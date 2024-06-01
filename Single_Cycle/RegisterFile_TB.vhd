library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFile_TB is
	port(CLK	: in std_logic;
		RST	: in std_logic;
		WE3	: out std_logic;
		A1	: out std_logic_vector(3 downto 0);
		A2	: out std_logic_vector(3 downto 0);
		A3	: out std_logic_vector(3 downto 0);
		WD3	: out std_logic_vector(31 downto 0);
		R15	: out std_logic_vector(31 downto 0));
end;

architecture sim of RegisterFile_TB is
begin
	process(clk) is
		variable ticks : integer := 0;
		variable value : integer := 0;
		variable test_phase : std_logic := '0'; --0 for write phase, 1 for read phase
	begin
		if RST = '1' then
			ticks := 0;
			value := 0;
			test_phase:= '0'; --0 for write phase, 1 for read phase
		end if;
		if rising_edge(clk) then
			case test_phase is
				when '0' => --First start the verification by writing a unique value into each of the registers of the file
					WE3 <= '1';
					A3 <= std_logic_vector(to_unsigned(value, A3'length));
					WD3 <= std_logic_vector(to_unsigned(value, WD3'length));
					R15 <= std_logic_vector(to_unsigned(15, R15'length)); --TODO:Determine a better way to set this value as it shouldn't change
					value := value + 1;
				when '1' => --Read back out the values to ensure that the write operation was successful
					WE3 <= '0';
					A1 <= std_logic_vector(to_unsigned(value, a1'length));
					A2 <= std_logic_vector(to_unsigned(value + 1, a2'length));
					R15 <= std_logic_vector(to_unsigned(15, R15'length)); --TODO:Determine a better way to set this value as it shouldn't change
					value := value + 1;
				when others => --seems a bit unncessary to do this as I would assume that a std_logic type only has two possibles states
					WE3 <= '0';
					A1 <= "0000";
					A2 <= "0000";
					A3 <= "0000";
					WD3 <= std_logic_vector(to_unsigned(15, WD3'length));
					R15 <= std_logic_vector(to_unsigned(0, R15'length));
			end case;
			
			ticks := ticks + 1;

			if ticks = 15 then --Switch over to the read phase after all the values have been written
				test_phase := '1';
				value := 0;
			elsif ticks = 31 then --Set this be inactive and not change things after the tests have completed
				test_phase := 'Z';
			end if;
		end if;
	end process;
end architecture;
