package body Faculty is
	-- maximum n = 12 fac := 12! = 479001600
	procedure calculate_faculty(n : in Faculty_Positive; fac : out Natural) is
	i 	: Faculty_Positive := 1;
	begin 
		fac := 1;
		---# Assert i >= 1 and i <= n and n <= Faculty_Positive'Last and n >= Faculty_Positive'First and fac*i <= Positive'Last and fac*i >= Positive'First 
		---# and fac >= 1 and fac = fac_arr(i);
		while i < n loop
			---# Assert i < n and n <= Faculty_Positive'Last and n >= Faculty_Positive'First and fac*i <= Positive'Last and fac*i >= Positive'First and fac = fac_arr(i);
            if fac <= Positive'Last / i then
                fac := fac * i;
                i := i + 1;
            else
              --ungültiger zustand falls i zu groß
              fac := 0;
            end if;
		end loop;
		---# Assert fac = fac_arr(i);
	end calculate_faculty;

end Faculty;
