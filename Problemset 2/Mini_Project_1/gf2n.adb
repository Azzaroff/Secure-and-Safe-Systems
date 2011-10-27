with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Ada.Numerics.Elementary_Functions;
with Interfaces; use Interfaces;

package body GF2n is

procedure Put ( Item : Element )is 
use Ada.Integer_Text_IO;
use Ada.Text_IO;
highest_bit, current_bit, result_bit : Unsigned_8;
begin
	highest_bit := Item'Last + 1;
	current_bit := 1;
	while current_bit /= highest_bit loop
	    result_bit := current_bit and Unsigned_8(Item);

		if result_bit /= 0 then
				Put("x**");
				Put (Integer(Ada.Numerics.Elementary_Functions.Log(result_bit , 2.0)));
				Put(" +");
		end if;

		current_bit := current_bit * 2;
	end loop;
end Put;
 
function "+" ( Left : Element ; Right : Element ) return Element is
begin
	return Left;
end "+";

function "-" ( Left : Element ; Right : Element ) return Element is
begin
	return Left;
end "-";

function "*" ( Left : Element ; Right : Element ) return Element is
begin
	return Left;
end "*";

end GF2n;
