package body Hofstadter is

   function Q(N: Positive) return Positive is
   begin
      if N < 3 then
         return 1;
      else
         return Q(N - Q(N-1)) + Q(N - Q(N-2));
      end if;
   end Q;

end Hofstadter;

