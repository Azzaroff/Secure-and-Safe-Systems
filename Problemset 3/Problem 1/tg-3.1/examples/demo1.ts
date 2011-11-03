
error_handling continue

context with Text_IO;    
	use  Text_IO;
	with Under_Test; 
	use  Under_Test;

***** X = 1
define Result : Positive;
test   Result := Subject(1);
pass   Result = 1

***** X = 2
define Result : Positive;
test   Result := Subject(2);
pass   exception Strange_Error

***** X = 3
define Result : Positive;
test   Result := Subject(3);
pass   exception Another_Error

***** X = 4
define Result : Positive;
test   Result := Subject(4);
pass   exception Illegal_Parameter

***** X = 5
define Result : Positive;
test   Result := Subject(5);
pass   exception Illegal_Parameter
