package body Faculty is
	-- maximum n = 12 fac := 12! = 479001600
	procedure calculate_faculty(n : in Faculty_Positive; fac : out Natural) is
	i 	: Positive := 1;
	begin 
		fac := 1;
		while i <= n loop
            if fac <= Positive'Last / i then
                fac := fac * i;
                i := i + 1;
            else
              --ungültiger zustand falls i zu groß
              fac := 0;
            end if;
		end loop;
	end calculate_faculty;

	function Proof_Factorial(N: Faculty_Positive) return Positive is
	--# hide Proof_Factorial;
		P: Positive := 1;
	begin
		for I in Positive range 1 .. Positive(N) loop
			P := P * I;
		end loop;
		
		return P;
	end Proof_Factorial;
end Faculty;
