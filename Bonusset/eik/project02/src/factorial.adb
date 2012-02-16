package body Factorial is
	
	function Fac(N: Constraint_Positive) return Positive is
		I: Constraint_Positive := 1;
		Result: Positive := 1;
	begin
		--# assert I = 1 and Result = 1 and Result = Test(I);
		loop
			exit when I >= N;
			
			I := I + 1;
			--# assert I >= 1 and I <= N and Result = Test(I - 1);
			
			Result := Result * Positive(I);
			--# assert I >= 1 and I <= N and Result = Test(I);
		end loop;
		
		--# assert I <= N and I >= N and Result = Test(I);
		return Result;
	end Fac;
	
	function Proof_Factorial(N: Constraint_Positive) return Positive is
	--# hide Proof_Factorial;
		P: Positive := 1;
	begin
		for I in Positive range 1 .. Positive(N) loop
			P := P * I;
		end loop;
		
		return P;
	end Proof_Factorial;
	
end Factorial;