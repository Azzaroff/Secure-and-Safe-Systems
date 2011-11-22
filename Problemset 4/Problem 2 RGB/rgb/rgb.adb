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
function add (Left : Color; Right : Color)  return Color is
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
end add;

-- MINUS
function sub (Left : Color; Right : Color)  return Color is
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
end sub;

-- MULT
function mult(Left : Color; Right : Color)  return Color is
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
end mult;

-- EQUAL
function equals(Left : Color; Right : Color)  return Boolean is
begin
return (Left(Red) = Right(Red) and
	Left(Green) = Right(Green)) and
	Left(Blue) = Right(Blue);

end equals;
-- PUT
procedure Put(Item  : in Color) is
--# hide Put
begin
Ada.Text_IO.Put ("R: ");
Ada.Integer_Text_IO.Put (Item(Red), 16, 3);
Ada.Text_IO.Put	(" G: ");
Ada.Integer_Text_IO.Put (Item(Green), 16, 3);
Ada.Text_IO.Put	(" B: ");
Ada.Integer_Text_IO.Put (Item(Blue), 16, 3);
Ada.Text_IO.Put	(".");
end Put;

end rgb;
