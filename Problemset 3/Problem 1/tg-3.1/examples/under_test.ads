package Under_Test is

  Illegal_Parameter : exception;
  Strange_Error     : exception;
  Another_Error     : exception;

  function Subject (X : in POSITIVE) return POSITIVE;

end Under_Test;
