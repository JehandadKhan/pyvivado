library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package pyvivado_utils is
  
  function logceil(v: integer) return integer;
  function std_logic_to_slv(input: std_logic) return std_logic_vector;
  function get_index_of_first_one(slv: std_logic_vector) return integer;
  function or_slv(slv: std_logic_vector) return std_logic;
  function and_slv(slv: std_logic_vector) return std_logic;
  
end package;

package body pyvivado_utils is

  function std_logic_to_slv(input: std_logic) return std_logic_vector is
    variable output: std_logic_vector(0 downto 0);
  begin
    output(0) := input;
    return output;
  end;

  function logceil(v: integer) return integer is
  begin
    if (v = 0) then
      return 0;
    end if;
    return integer(ceil(log2(real(v))));
  end function;

  function get_index_of_first_one(slv: std_logic_vector) return integer is
    variable counter: integer range 0 to slv'LENGTH;
  begin
    for counter in 0 to slv'LENGTH-1 loop
      if (slv(counter) = '1') then
        return counter;
      end if;
    end loop;
    return slv'LENGTH;
  end function;

  function or_slv(slv:std_logic_vector) return std_logic is
    variable ii: integer range slv'LOW to slv'HIGH;
  begin
    for ii in slv'LOW to slv'HIGH loop
      if (slv(ii) = '1') then
        return '1';
      end if;
    end loop;
    return '0';
  end function;

  function and_slv(slv:std_logic_vector) return std_logic is
  begin
    return not or_slv(not slv);
  end function;

end package body;