package gcd2 is

procedure GCD (X, Y : in Positive;
		result :out Positive);
--# derives result from X,Y;
--# pre X > 0 and Y > 0;
--# post X > 0 and Y > 0 and result > 0;

end gcd2;
