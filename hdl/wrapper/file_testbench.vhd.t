-- -*- vhdl -*- 
  
library ieee;
use ieee.std_logic_1164.all;

entity FileTestBench is
end FileTestBench;
 
architecture arch of FileTestBench is
  constant WIDTHIN: natural := {{total_width_in}};
  constant WIDTHOUT: natural := {{total_width_out}};
  constant DATAINFILENAME: string := "{{input_filename}}";
  constant DATAOUTFILENAME: string := "{{output_filename}}";
  constant CLOCK_PERIOD: time := {{clock_period}};
  constant MAX_CYCLES: natural := {{max_cycles}};
  signal in_data: std_logic_vector(WIDTHIN-1 downto 0);
  signal out_data: std_logic_vector(WIDTHOUT-1 downto 0);
  signal clk: std_logic;
  signal offset_clk: std_logic;
begin

  file_reader: entity work.ReadFile
    generic map(FILENAME => DATAINFILENAME,
                WIDTH => WIDTHIN)
    port map(clk => offset_clk,
             out_data => in_data);
  file_writer: entity work.WriteFile
    generic map(FILENAME => DATAOUTFILENAME,
                WIDTH => WIDTHOUT)
    port map(clk => clk,
             in_data => out_data);
  clock_generator: entity work.ClockGenerator
    generic map(CLOCK_PERIOD => CLOCK_PERIOD,
                CLOCK_OFFSET => 0 ns
                )
    port map(clk => clk);
  offset_clock_generator: entity work.ClockGenerator
    generic map(CLOCK_PERIOD => CLOCK_PERIOD,
                CLOCK_OFFSET => CLOCK_PERIOD/10
                )
    port map(clk => offset_clk);
  dut: entity work.OutsideDutWrapper
    port map(clk => clk,
             in_data => in_data,
             out_data => out_data);
 
  process(clk)
    variable counter: natural := 0;
  begin
    if rising_edge(clk) then
      counter := counter + 1;
    end if;
    if (MAX_CYCLES > 0) and (counter >= MAX_CYCLES) then
      assert false report "end of simulation" severity failure;
    end if;
  end process;
end arch;
