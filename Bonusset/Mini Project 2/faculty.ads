package Faculty is
	subtype Faculty_Positive is Positive range 1 .. 12;
	type Faculty_Array is array (Faculty_Positive) of Positive;

	
	procedure calculate_faculty(n : in Faculty_Positive; fac : out Natural);
	--# derives fac from n;
	--# pre n >= Faculty_Positive'First and n <= Faculty_Positive'Last;
end Faculty;
