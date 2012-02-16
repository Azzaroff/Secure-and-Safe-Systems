package Byte_Utils is
	
	type Byte is mod 2**8;
	for Byte'Size use 8;
	type Byte_Array is array (Natural range <>) of Byte;
	type Half_Byte is mod 2**4;
	
	Argument_Error: exception;
	
	Hex_String: constant String := "0123456789abcdef";
	
	function Byte_To_Hex(Input: Byte) return String;
	function Char_To_Half_Byte(Char: Character) return Half_Byte;
	function Chars_To_Byte(Left, Right: Character) return Byte;
	function Clone(Original: Byte_Array) return Byte_Array;
	
	function Equal(Left, Right: Byte_Array) return Boolean;
	function Is_Subset(Short, Long: Byte_Array) return Boolean;
	function Half_Byte_To_Hex(Input: Half_Byte) return Character;
	procedure Increment(Input: in out Byte_Array; Overflow: out Boolean);
	procedure Put(Target: Byte_Array);
	
	procedure Put_Line(Target: Byte_Array);
	function To_Byte(Left, Right: Half_Byte) return Byte;
	function To_Byte_Array(Input: String) return Byte_Array;
	function To_String(Target: Byte_Array) return String;
	
end Byte_Utils;