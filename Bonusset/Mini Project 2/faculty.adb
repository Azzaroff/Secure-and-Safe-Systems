package body Faculty is
	-- maximum n = 12 fac := 12! = 479001600
	procedure calculate_faculty(n : in Faculty_Positive; fac : out Natural) is
	i 	: Faculty_Positive := 1;
	begin 
		fac := 1;
		while i < n loop
            if fac <= Positive'Last / i then
                fac := fac * i;
                i := i + 1;
            else
              --ungültiger zustand falls i zu groß
              fac := 0;
            end if;
		end loop;
	end calculate_faculty;

end Faculty;
