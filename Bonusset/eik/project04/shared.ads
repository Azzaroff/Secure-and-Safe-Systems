with Mini_RC4;

use Mini_RC4;

package Shared is
	
	protected type Mini_RC4_Properties is
		function Get_Correct_Candidate return Key_Type;
		procedure Get_Incremented_Key_Candidate(Candidate: out Key_Type; Overflow: out Boolean);
		function Get_Key_Candidate return Key_Type;
		function Get_Key_Index return Natural;
		
		function Is_Done return Boolean;
		procedure Interrupt;
		procedure Set_Correct_Candidate(Key_Candidate: Key_Type);
	private
		Context: Context_Type;
		Correct_Key_Candidate: Key_Type := (0, 0, 0, 0);
		Done: Boolean := False;
		Key_Candidate: Key_Type := (0, 0, 0, 0);
		Key_Index: Natural := 0;
	end Mini_RC4_Properties;
	
end Shared;
