with Byte_Utils;

use Byte_Utils;

package Mini_RC4 is
	
	subtype Key_Type is Byte_Array(0..3);
	type Context_Type is private;
	
	procedure Key_Scheduler(Key: in Key_Type; Ctx: out Context_Type);
	-- Initializes the context's S-Box.	
	procedure Get_Keystream(Ctx: in out Context_Type; Keystream: out Byte_Array);
	-- Generates the pseudo random keystream. The keystream is XORed with the
	-- plaintext to generate the cipher text.
	
private
	
	subtype Expanded_Key_Type is Byte_Array(0..255);
	
	type Context_Type is record
		S : Expanded_Key_Type;
	end record;
	
end Mini_RC4;
	
