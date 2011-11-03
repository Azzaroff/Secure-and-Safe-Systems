with Ada.Text_IO, Ada.Integer_Text_IO;

package RGB is
	type Color is private;
	subtype Intensity is Integer range 0..255;

	function To_Color(	RedIntensity		: Intensity;
		  		GreenIntensity		: Intensity;
		  		BlueIntensity		: Intensity )
			return Color;

-- Saturation arithmetics
function "+"(Left : Color; Right : Color)  return Color;	
function "-"(Left : Color; Right : Color)  return Color;
function "*"(Left : Color; Right : Color)  return Color; -- dot product
function "="(Left : Color; Right : Color)  return Boolean;


--print the Intensity of each color as hex values.
procedure Put(Item  : in Color);

private
	type RGB is (Red, Green, Blue);
	type Color is array (RGB) of Intensity;
end RGB;
