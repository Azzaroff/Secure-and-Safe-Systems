
package body Under_Test is

  function Subject (X : in POSITIVE) return POSITIVE is
  begin
    case X is
      when 1      => return 1; 
      when 2      => raise Strange_Error;
      when 3      => raise Another_Error;
      when others => raise Illegal_Parameter;
    end case;
  end Subject;

end Under_Test;
