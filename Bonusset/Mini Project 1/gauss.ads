package Gauss is
    subtype Gauss_Positive is Positive range 1..46340;

	function gauss_sum (n : in Gauss_Positive) return Positive;
    --#return ((n * (n + 1)) / 2);


end Gauss;
