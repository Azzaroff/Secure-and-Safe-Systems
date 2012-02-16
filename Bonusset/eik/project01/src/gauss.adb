package body Gauss is
	
	procedure Gauss_Sum(N: Constraint_Positive; Result: out Positive) is
		I: Constraint_Positive := 1;
	begin
		--# assert I = 1 and I <= N and N >= 1;
		
		Result := 1;
		--# assert I = 1 and Result = 1 and Result = (I * (I + 1)) / 2;
		
		while I < N loop
			--# assert I < N and Result = (I * (I + 1)) / 2;
			
			I := I + 1;
			--# assert I <= N and Result = ((I - 1) * ((I - 1) + 1)) / 2;
			
			Result := Result + I;
			--# assert I <= N and Result = (I * (I + 1)) / 2;
		end loop;
		
		--# assert I >= N and I <= N and Result = (I * (I + 1)) / 2;
		--# assert I = N and Result = (I * (I + 1)) / 2;
	end Gauss_Sum;
	
end Gauss;