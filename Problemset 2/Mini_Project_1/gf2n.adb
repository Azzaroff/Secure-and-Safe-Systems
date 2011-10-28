with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Ada.Numerics.Elementary_Functions;
with Interfaces; use Interfaces;

package body GF2n is

procedure Put ( Item : Element )is 
use Ada.Integer_Text_IO;
use Ada.Text_IO;
highest_bit, current_bit, result_bit : Unsigned_8;
logarithm : float;
begin
	logarithm   := Ada.Numerics.Elementary_Functions.Log(Float (Item), 2.0 ); --gibt die Position des hoechsten Bits: 16 Logd = 4
	highest_bit := Unsigned_8 (2** Integer (logarithm)); -- errechnet das hoechste Bit: 2 ** 4 = 16, somit ist die 1 beim 4. Bit gesetzt
	current_bit := highest_bit;
	--gibt die ersten n-1 bits in umgekehrter  Reihenfolge aus	
	while current_bit > 1 loop
	    result_bit := current_bit and Unsigned_8(Item);

		if result_bit /= 0 then
				Put("x **");
				Put (Integer(Ada.Numerics.Elementary_Functions.Log(Float (result_bit) , 2.0)));
				Put(" + ");
		end if;

		current_bit := current_bit / 2;
	end loop;

	-- gibt das letzte Bit aus
	result_bit := current_bit and Unsigned_8(Item);
	if result_bit = 0 then
		Put ("0");
	else
		Put ("1");
	end if;
end Put;
 
function "+" ( Left : Element ; Right : Element ) return Element is
begin
	return (Left xor Right);
end "+";

function "-" ( Left : Element ; Right : Element ) return Element is
begin
	return (Left xor Right);
end "-";

function "*" ( Left : Element ; Right : Element ) return Element is
begin
	return Element (Integer (Left) * Integer(Right));
end "*";

function "/" ( Left : Element ; Right : Element ) return Element is
begin
	return Element (Integer(Left) / Integer (Right));
end "/";

end GF2n;
