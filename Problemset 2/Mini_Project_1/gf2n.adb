with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Ada.Numerics.Elementary_Functions;
with Interfaces; use Interfaces;

package body GF2n is

procedure Put ( Item : Element )is 
use Ada.Integer_Text_IO;
use Ada.Text_IO;
highest_bit, current_bit, result_bit : Unsigned_32;
logarithm : float;
begin
	logarithm   := Ada.Numerics.Elementary_Functions.Log(Float (Item), 2.0 ); --gibt die Position des hoechsten Bits: 16 Logd = 4
	highest_bit := Unsigned_32 (2** Integer (logarithm)); -- errechnet das hoechste Bit: 2 ** 4 = 16, somit ist die 1 beim 4. Bit gesetzt
	current_bit := highest_bit;
	--gibt die ersten n-1 bits in umgekehrter  Reihenfolge aus	
	while current_bit > 1 loop
	    result_bit := current_bit and Unsigned_32(Item);

		if result_bit /= 0 then
        declare
                Exponent : Integer := Integer(Ada.Numerics.Elementary_Functions.Log(Float (result_bit) , 2.0));
                Exponent_Width : Integer := Integer(Ada.Numerics.Elementary_Functions.Log(Float (Exponent) , 10.0)) + 1;
        begin
				Put("x **");
				Put (Width => (Exponent_Width -1), Item => Exponent); --Hack für korrekte Breite 
				Put(" + ");
        end;
		end if;

		current_bit := current_bit / 2;
	end loop;

	-- gibt das letzte Bit aus
	result_bit := current_bit and Unsigned_32(Item);
	if result_bit = 0 then
		Put ("0");
	else
		Put ("1");
	end if;
    Put_Line("");
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
p,a,b : Element := 0;
logarithm : float;
leftmost_a : Unsigned_32;
begin
    --http://en.wikipedia.org/wiki/Finite_field_arithmetic
    a := Left;
    b := Right;
	logarithm   := Ada.Numerics.Elementary_Functions.Log(Float (F), 2.0 ); --gibt die Position des hoechsten Bits: 16 Logd = 4
    for I in Unsigned_32 range 1..8 loop -- loop höchstes-bit mal des irreduziblen Polynoms
        if (1 = (Unsigned_32(b) and Unsigned_32(1))) then 
                p := p xor a; --If the rightmost bit of b is set, exclusive OR the product p by the value of a.
        end if;
        leftmost_a := Unsigned_32(a) and Unsigned_32(16#8#);-- Keep track of whether the leftmost bit of a is set to one
        a := Element(Shift_Left(Unsigned_32(a), 1));-- Shift a one bit to the left, discarding the old leftmost bit, and making the new rightmost bit zero
        if leftmost_a = 1 then
            a := a xor 16#1b#;  -- If a's leftmost bit had a value of one prior to this shift, exclusive or a with the hexadecimal number 0x1b (00011011 in binary). 0x1b corresponds to the irreducible polynomial with the high term eliminated. Muss noch generischer werden, momentan hard coded        
        end if;
    b := Element(Shift_Right(Unsigned_32(b), 1));-- Shift b one bit to the right, discarding the rightmost bit, and making the leftmost bit have a value of zero.
    end loop;
    return p;
end "*";

function "/" ( Left : Element ; Right : Element ) return Element is
begin
	return gf2n."*"(Left, gf2n.Inverse(Right));
end "/";

-- calculating inverse using brute force algorithm
function Inverse(Item : Element) return Element is
Inverse : Element := 1;
begin

	if Item = Element (0) then -- 0 ist zu sich selbst invers
		return Item;
	end if;
	
	while Item = Element'Last loop
		if gf2n."*"(Item, Inverse) = 1 then
			exit;
		else
			Inverse := Inverse + 1;		
		end if;
	end loop;
	
	return Inverse;
end Inverse;

end GF2n;
