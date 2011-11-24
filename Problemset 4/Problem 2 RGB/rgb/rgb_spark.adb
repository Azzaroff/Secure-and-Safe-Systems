package body rgb is

function To_Color(RedIntensity		: Intensity;
		  GreenIntensity	: Intensity;
		  BlueIntensity		: Intensity ) return Color is
begin
	return Color'(Red => RedIntensity, Green => GreenIntensity, Blue => BlueIntensity);
end To_Color;
-- PLUS
procedure add(Left : in Color; Right : in Color, Result : out Color) is
Result : Color := Color'(others => 0);
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
procedure sub(Left : in Color; Right : in Color, Result : out Color) is
Result : Color := Color'(others => 0);
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
procedure mult(Left : in Color; Right : in Color, Result : out Color) is
Result : Color := Color'(others => 0);
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

--DIVISION

procedure divi(Left : in Color; Right : in Color, Result : out Color)  is
begin
	if Left(Valid) = False or Right(Valid) = False then
		Result(Valid) := False;
	else
		Result(Red) := Left(Red) / Right(Red);
		Result(Green) := Left(Green) / Right(Green);
		Result(Blue) := Left(Blue) / Right(Blue);
		Result(Vaild) := True;
	end if;
end divi;

-- EQUAL
 procedure equals(Left : in Color; Right : in Color, Result : out Color) is
begin
Result := (Left(Red) = Right(Red) and
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
