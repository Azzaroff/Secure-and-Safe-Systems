package body rgb is

function To_Color(RedIntensity		: Intensity;
		  GreenIntensity	: Intensity;
		  BlueIntensity		: Intensity ) return Color is
Result : Color;
begin
	Result(Red) 	:= RedIntensity;
	Result(Green)	:= GreenIntensity;
	Result(Blue)	:= BlueIntensity;
	return Result;
end To_Color;

function "+"(Left : Color; Right : Color)  return Color is
Result : Color;
begin
Result(Red) 	:= (Left(Red) + Right(Red)) mod (Intensity'Last+1);
Result(Green)	:= (Left(Green) + Right(Green)) mod (Intensity'Last+1);
Result(Blue) 	:= (Left(Blue) + Right(Blue)) mod (Intensity'Last+1);
return Result;
end "+";


function "-"(Left : Color; Right : Color)  return Color is
Result : Color;
begin
Result(Red) 	:= (Left(Red) - Right(Red)) mod (Intensity'Last+1);
Result(Green)	:= (Left(Green) - Right(Green)) mod (Intensity'Last+1);
Result(Blue) 	:= (Left(Blue) - Right(Blue)) mod (Intensity'Last+1);
return Result;
end "-";


function "*"(Left : Color; Right : Color)  return Color is
Result : Color;
begin
Result(Red) 	:= (Left(Red) * Right(Red)) mod (Intensity'Last+1);
Result(Green)	:= (Left(Green) * Right(Green)) mod (Intensity'Last+1);
Result(Blue) 	:= (Left(Blue) * Right(Blue)) mod (Intensity'Last+1);
return Result;
end "*";

function "="(Left : Color; Right : Color)  return Boolean is
begin
return Left(Red) = Right(Red) and
	Left(Green) = Right(Green) and
	Left(Blue) = Right(Blue);

end "=";

procedure Put(Item  : in Color) is
begin
Ada.Text_IO.Put ("R: ");
Ada.Integer_Text_IO.Put (Item(Red), Base => 16, Width => 3);
Ada.Text_IO.Put	(" G: ");
Ada.Integer_Text_IO.Put (Item(Green), Base => 16, Width => 3);
Ada.Text_IO.Put	(" B: ");
Ada.Integer_Text_IO.Put (Item(Blue), Base => 16, Width => 3);
Ada.Text_IO.Put	(".");

end Put;

end rgb;
