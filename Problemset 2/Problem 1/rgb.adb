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
-- PLUS
function "+"(Left : Color; Right : Color)  return Color is
Result : Color;
begin
if Left(Red) + Right(Red) > Intensity'Last then
	Result(Red) := Intensity'Last;
else
	Result(Red) := Left(Red) + Right(Red);
end if;

if Left(Green) + Right(Green) > Intensity'Last then
	Result(Green) := Intensity'Last;
else
	Result(Green) := Left(Green) + Right(Green);
end if;

if Left(Blue) + Right(Blue) > Intensity'Last then
	Result(Blue) := Intensity'Last;
else
	Result(Blue) := Left(Blue) + Right(Blue);
end if;

return Result;
end "+";

-- MINUS
function "-"(Left : Color; Right : Color)  return Color is
Result : Color;
begin
if Left(Red) - Right(Red) < Intensity'First then
	Result(Red) := Intensity'First;
else
	Result(Red) := Left(Red) - Right(Red);
end if;

if Left(Green) - Right(Green) < Intensity'First then
	Result(Green) := Intensity'First;
else
	Result(Green) := Left(Green) - Right(Green);
end if;

if Left(Blue) - Right(Blue) < Intensity'First then
	Result(Blue) := Intensity'First;
else
	Result(Blue) := Left(Blue) - Right(Blue);
end if;
return Result;
end "-";

-- MULT
function "*"(Left : Color; Right : Color)  return Color is
Result : Color;
begin
if Left(Red) * Right(Red) > Intensity'Last then
	Result(Red) := Intensity'Last;
else
	Result(Red) := Left(Red) * Right(Red);
end if;

if Left(Green) * Right(Green) > Intensity'Last then
	Result(Green) := Intensity'Last;
else
	Result(Green) := Left(Green) * Right(Green);
end if;

if Left(Blue) * Right(Blue) > Intensity'Last then
	Result(Blue) := Intensity'Last;
else
	Result(Blue) := Left(Blue) * Right(Blue);
end if;
return Result;
end "*";

-- EQUAL
function "="(Left : Color; Right : Color)  return Boolean is
begin
return (Left(Red) = Right(Red) and
	Left(Green) = Right(Green)) and
	Left(Blue) = Right(Blue);

end "=";
-- PUT
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
