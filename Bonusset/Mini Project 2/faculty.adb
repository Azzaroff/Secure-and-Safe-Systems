package body Faculty is
	-- maximum n = 12 fac := 12! = 479001600
	function calculate_faculty(n : in Faculty_Positive) return Positive is
	fac : Positive := 1;
	i 	: Integer := 0;
	begin
		--# Assert i >= 0 and fac = 1;
		while i < n loop
			--# Assert i >= 0 and i < n and n>= Faculty_Positive'First and n <= Faculty_Positive'Last and (fac*(i+1)) <= Positive'Last;
			i := i + 1;	
			-- Assert i <= n and i <= Integer'Last and fac = fac_arr(i-1) and fac*i <= Positive'Last ;			
			fac := fac * i;				
			-- Assert i <= n and fac = fac_arr(i) and fac <= Positive'Last and fac >= Positive'First;
		end loop;
		-- Assert i >= n and fac = fac_arr(n) and fac <= Positive'Last and fac >= Positive'First;
		return fac;
	end calculate_faculty;

end Faculty;
