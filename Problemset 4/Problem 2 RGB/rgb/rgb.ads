with Ada.Text_IO, Ada.Integer_Text_IO;
--#inherit Text_IO, Integer_Text_IO, Ada;

package RGB is
	type Color is private;
	subtype Intensity is Integer range 0..255;

	function To_Color(	RedIntensity		: Intensity;
		  		GreenIntensity		: Intensity;
		  		BlueIntensity		: Intensity )
			return Color;

-- Saturation arithmetics
function add 	(Left : Color; Right : Color)  return Color;	
function sub	(Left : Color; Right : Color)  return Color;
function mult	(Left : Color; Right : Color)  return Color; -- dot product
function equals	(Left : Color; Right : Color)  return Boolean;


--print the Intensity of each color as hex values.
procedure Put(Item  : in Color);
--# derives null from Item;

type RGB_Type is (Red, Green, Blue);
type Color is array (RGB_Type) of Intensity;

private
	
end RGB;
