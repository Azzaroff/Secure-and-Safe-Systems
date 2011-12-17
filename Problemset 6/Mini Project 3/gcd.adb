package body gcd is

procedure GCD (X, Y : in Integer;
		result : out Integer) is
xhelp, yhelp : Integer;
begin
	xhelp := X;
	yhelp := Y;
	while (yhelp /= 0) loop
		result := xhelp mod yhelp;
		xhelp := yhelp;
		yhelp := result; 
	end loop;
	result := xhelp;
end GCD;

end gcd;
