with Ada.Text_IO;

package body Gauss is

	-- maximum n could be n = 46340, gaussian sum = 1073720970
	procedure gauss_sum (n : in Positive) is
		sum : Positive := 1;	
	begin
		sum := n * (n + 1) / 2;
		Ada.Text_IO.Put_Line("gaussian sum of n="&n'Img&" is"&sum'Img);
	end gauss_sum;

end Gauss;
