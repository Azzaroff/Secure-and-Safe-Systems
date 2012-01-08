package body gcd2 is

procedure GCD (X, Y : in Positive;
		result : out Positive) is
begin
	if (X < Y) then
		result := X;
	else
		result := y;
	end if;
	
	while((result > 1) and not((X mod result = 0) and (Y mod result = 0))) loop
		result := result -1;
	end loop;
end GCD;

end gcd2;
