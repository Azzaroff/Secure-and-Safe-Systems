package Faculty is
	subtype Faculty_Positive is Positive range 1 .. 12;

        --# function Test(N: Faculty_Positive) return Positive;
	procedure calculate_faculty(n : in Faculty_Positive; fac : out Natural);
	--# derives fac from n;
	--# pre n >= Faculty_Positive'First and n <= Faculty_Positive'Last;
        --# post fac = Test(n);

        function Proof_Factorial(N: Faculty_Positive) return Positive;

end Faculty;
