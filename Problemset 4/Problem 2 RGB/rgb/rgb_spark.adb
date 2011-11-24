package body RGB_Spark is

procedure To_Color(RedIntensity   : in Intensity;
		     GreenIntensity : in Intensity; 
		     BlueIntensity  : in Intensity;
             Result : out Color)is
begin
	Result.Value := RGB_Color'(Red => RedIntensity, Green => GreenIntensity, Blue => BlueIntensity);
	Result.Valid := True;
end To_Color;

--is vaild
function Is_Valid(Item : Color) return Boolean is
begin
	return Item.Valid;
end Is_Valid;

-- PLUS
procedure add(Left : in Color; Right : in Color; Result : out Color) is
begin
if Left.Value(Red) + Right.Value(Red) > Intensity'Last then
	Result.Value(Red) := Intensity'Last;
else
	Result.Value(Red) := Left.Value(Red) + Right.Value(Red);
end if;

if Left.Value(Green) + Right.Value(Green) > Intensity'Last then
	Result.Value(Green) := Intensity'Last;
else
	Result.Value(Green) := Left.Value(Green) + Right.Value(Green);
end if;

if Left.Value(Blue) + Right.Value(Blue) > Intensity'Last then
	Result.Value(Blue) := Intensity'Last;
else
	Result.Value(Blue) := Left.Value(Blue) + Right.Value(Blue);
end if;
Result.Valid := True;
end add;

-- MINUS
procedure sub(Left : in Color; Right : in Color; Result : out Color) is
begin
if Left.Value(Red) - Right.Value(Red) < Intensity'First then
	Result.Value(Red) := Intensity'First;
else
	Result.Value(Red) := Left.Value(Red) - Right.Value(Red);
end if;

if Left.Value(Green) - Right.Value(Green) < Intensity'First then
	Result.Value(Green) := Intensity'First;
else
	Result.Value(Green) := Left.Value(Green) - Right.Value(Green);
end if;

if Left.Value(Blue) - Right.Value(Blue) < Intensity'First then
	Result.Value(Blue) := Intensity'First;
else
	Result.Value(Blue) := Left.Value(Blue) - Right.Value(Blue);
end if;
end sub;

-- MULT
procedure mult(Left : in Color; Right : in Color; Result : out Color) is
begin
if Left.Value(Red) * Right.Value(Red) > Intensity'Last then
	Result.Value(Red) := Intensity'Last;
else
	Result.Value(Red) := Left.Value(Red) * Right.Value(Red);
end if;

if Left.Value(Green) * Right.Value(Green) > Intensity'Last then
	Result.Value(Green) := Intensity'Last;
else
	Result.Value(Green) := Left.Value(Green) * Right.Value(Green);
end if;

if Left.Value(Blue) * Right.Value(Blue) > Intensity'Last then
	Result.Value(Blue) := Intensity'Last;
else
	Result.Value(Blue) := Left.Value(Blue) * Right.Value(Blue);
end if;
end mult;

--DIVISION

procedure divi(Left : in Color; Right : in Color; Result : out Color)  is
begin
	if Left.Valid = False or Right.Valid = False then
		Result.Valid := False;
	else
		Result.Value(Red) := Left.Value(Red) / Right.Value(Red);
		Result.Value(Green) := Left.Value(Green) / Right.Value(Green);
		Result.Value(Blue) := Left.Value(Blue) / Right.Value(Blue);
		Result.Valid := True;
	end if;
end divi;

-- EQUAL
 procedure equals(Left : in Color; Right : in Color; Result : out Boolean) is
begin
Result := (Left.Value(Red) = Right.Value(Red) and
	Left.Value(Green) = Right.Value(Green)) and
	Left.Value(Blue) = Right.Value(Blue);

end equals;
-- PUT
procedure Put(Item  : in Color) is
--# hide Put
begin
Ada.Text_IO.Put ("R: ");
Ada.Integer_Text_IO.Put (Item.Value(Red), 16, 3);
Ada.Text_IO.Put	(" G: ");
Ada.Integer_Text_IO.Put (Item.Value(Green), 16, 3);
Ada.Text_IO.Put	(" B: ");
Ada.Integer_Text_IO.Put (Item.Value(Blue), 16, 3);
Ada.Text_IO.Put	(".");
end Put;

end RGB_Spark;
