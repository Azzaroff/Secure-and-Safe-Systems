package Gauss is
	
	subtype Constraint_Positive is Positive range 1 .. 46340;
	
	procedure Gauss_Sum(N: Constraint_Positive; Result: out Positive);
	--# derives Result from N;
	--# pre Constraint_Positive'First = Positive'First 
	--#		and Positive'First = 1
	--#		and Positive'Last = 2147483647
	--#		and Integer'Base'First = -2147483648
	--#		and Integer'Base'Last = 2147483647
	--#		and Constraint_Positive'Last = 46340
	--#		and Constraint_Positive'Last < Positive'Last;
	--# post Result = (N * (N + 1)) / 2;
	
end Gauss;