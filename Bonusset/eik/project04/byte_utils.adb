with Ada.Text_IO;

use Ada.Text_IO;

package body Byte_Utils is
	
	function Byte_To_Hex(Input: Byte) return String is
		Left: constant Half_Byte := Half_Byte(Natural(Input) / 16);
		Right: constant Half_Byte := Half_Byte(Natural(Input) mod 16);
	begin
		 return Half_Byte_To_Hex(Left) & Half_Byte_To_Hex(Right); 
	end Byte_To_Hex;
	
	function Char_To_Half_Byte(Char: Character) return Half_Byte is
	begin
		case Char is
			when '0' => return 0;
			when '1' => return 1;
			when '2' => return 2;
			when '3' => return 3;
			when '4' => return 4;
			when '5' => return 5;
			when '6' => return 6;
			when '7' => return 7;
			when '8' => return 8;
			when '9' => return 9;
			when 'a' | 'A' => return 10;
			when 'b' | 'B' => return 11;
			when 'c' | 'C' => return 12;
			when 'd' | 'D' => return 13;
			when 'e' | 'E' => return 14;
			when 'f' | 'F' => return 15;
			when others => raise Argument_Error with "Invalid Character: " & Char;
		end case;
	end Char_To_Half_Byte;
	
	function Chars_To_Byte(Left, Right: Character) return Byte is
	begin
		return To_Byte(Char_To_Half_Byte(Left), Char_To_Half_Byte(Right));
	end Chars_To_Byte;
	
	function Clone(Original: Byte_Array) return Byte_Array is
		Copy: Byte_Array(Original'Range);
	begin
		for I in Original'Range loop
			Copy(I) := Original(I);
		end loop;
		
		return Copy;
	end Clone;
	
	function Equal(Left, Right: Byte_Array) return Boolean is
	begin
		if Left'Length /= Right'Length then
			return False;
		end if;
		
		for I in Left'Range loop
			if Left(I) /= Right(I) then
				return False; 
			end if;
		end loop;
		
		return True;
	end Equal;
	
	function Half_Byte_To_Hex(Input: Half_Byte) return Character is
	begin
		return Hex_String(Integer(Input) + 1);
	end Half_Byte_To_Hex;
	
	procedure Increment(Input: in out Byte_Array; Overflow: out Boolean) is
	begin
		for I in reverse Input'Range loop
			if Input(I) = Byte'Last then
				Input(I) := Byte'First;
			else
				Input(I) := Input(I) + 1;
				Overflow := False;
				return;
			end if;
		end loop;
		
		Overflow := True;
	end Increment;
	
	function Is_Subset(Short, Long: Byte_Array) return Boolean is
	begin
		if Short'Length > Long'Length then
			return False;
		end if;
		
		for I in Short'Range loop
			if Short(I) /= Long(I) then
				return False; 
			end if;
		end loop;
		
		return True;
	end Is_Subset;
	
	procedure Put(Target: Byte_Array) is
	begin
		Put(To_String(Target));
	end Put;
	
	procedure Put_Line(Target: Byte_Array) is
	begin
		Put_Line(To_String(Target));
	end Put_Line;
	
	function To_Byte(Left, Right: Half_Byte) return Byte is
	begin
		return Byte(Left) * 16 + Byte(Right);
	end To_Byte;
	
	function To_Byte_Array(Input: String) return Byte_Array is
		Length: constant Natural := Input'Length;
		Result: Byte_Array(0 .. (Length / 2) - 1);
		Byte_Index: Natural := 0;
		Index: Natural := 0;
	begin
		for I in Input'Range loop
			if Index mod 2 = 1 then
				Result(Byte_Index) := Chars_To_Byte(Input(I - 1), Input(I));
				Byte_Index := Byte_Index + 1;
			end if;
			
			Index := Index + 1;
		end loop;
		return Result;
	end To_Byte_Array;
	
	function To_String(Target: Byte_Array) return String is
		Length: constant Natural := Target'Last - Target'First + 1;
		Result: String(1 .. 2 * Length);
		Index: Natural := 1;
	begin
		for I in Target'Range loop
			Result(Index .. Index + 1) := Byte_To_Hex(Target(I));
			Index := Index + 2;
		end loop;
		
		return Result;
	end To_String;
	
end Byte_Utils;
