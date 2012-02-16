
package body Gauss is

	-- maximum n could be n = 46340, gaussian sum = 1073720970
	procedure gauss_sum (n : in Gauss_Positive; result : out Positive) is
	begin
		result := (n * (n + 1)) / 2;
	end gauss_sum;

end Gauss;
