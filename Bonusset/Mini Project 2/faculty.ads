package Faculty is
	subtype Faculty_Positive is Positive range 1 .. 12;
	type Faculty_Array is array (Faculty_Positive) of Positive;

	fac_arr : constant Faculty_Array := Faculty_Array'(1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800, 39916800, 479001600);

	
	procedure calculate_faculty(n : in Faculty_Positive; fac : out Natural);
	--# derives fac from n;
	--# pre n >= Faculty_Positive'First and n <= Faculty_Positive'Last;
end Faculty;
