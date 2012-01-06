package body gcd2 is

procedure GCD (X, Y : in Natural;
		result : out Natural) is
min, i : Natural;
begin
	if (X < Y) then
		min := X;
	else
		min := y;
	end if;
	
	i := min;
	while((i > 0) and not((X mod i = 0) and (Y mod i = 0))) loop
		i := i -1;
	end loop;

	result := i;
end GCD;

end gcd2;
