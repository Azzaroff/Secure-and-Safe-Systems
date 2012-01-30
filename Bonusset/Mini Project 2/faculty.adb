with Ada.Text_IO;

package body Faculty is
	-- maximum n = 12 fac := 12! = 479001600
	procedure calculate_faculty(n : in Positive) is
	fac : Positive := 1;
	i 	: Positive := n;
	begin
		while i > 1 loop
			fac := fac * i;
			i := i - 1;
		end loop;
		Ada.Text_IO.Put_Line("The faculty of n ="&n'Img&" is "&fac'Img);
	end calculate_faculty;

end Faculty;
