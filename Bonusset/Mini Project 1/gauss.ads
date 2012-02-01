package Gauss is
    subtype Gauss_Positive is Positive range 1..46340;

	procedure gauss_sum (n : in Gauss_Positive; result : out Positive);
    --#derives result from n;
    --#pre n <= 46340 and n > 0;


end Gauss;
