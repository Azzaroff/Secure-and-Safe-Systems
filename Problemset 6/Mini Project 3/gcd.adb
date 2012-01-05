package body gcd is

procedure GCD (X, Y : in Natural;
		result : out Natural) is
xhelp, yhelp : Natural;
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
