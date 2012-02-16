package Factorial is
	
    type Constraint_Positive is new Integer range 1 .. 12;
    type Positive_Array is array (Constraint_Positive) of Positive;
    
	--# function Test(N: Constraint_Positive) return Positive; 
	function Fac(N: Constraint_Positive) return Positive;
    --# pre (N >= Constraint_Positive'First) and (N <= Constraint_Positive'Last)
	--#		and Positive'First = 1
	--#		and Positive'Last = 2147483647
	--#		and Integer'Base'First = -2147483648
	--#		and Integer'Base'Last = 2147483647
	--#		and Constraint_Positive'First = 1
	--#		and Constraint_Positive'Last = 12;
    --# return Test(N);
	
	function Proof_Factorial(N: Constraint_Positive) return Positive;
	
end Factorial;