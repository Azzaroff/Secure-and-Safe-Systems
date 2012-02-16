with Byte_Utils;

use Byte_Utils;

package body Shared is
	
	protected body Mini_RC4_Properties is
		
		function Get_Correct_Candidate return Key_Type is
		begin
			return Correct_Key_Candidate;
		end Get_Correct_Candidate;
		
		procedure Get_Incremented_Key_Candidate(Candidate: out Key_Type; Overflow: out Boolean) is
		begin
			Byte_Utils.Increment(Key_Candidate, Overflow);
			Key_Index := Key_Index + 1; 
			Candidate := Key_Candidate;
		end Get_Incremented_Key_Candidate;
		
		function Get_Key_Candidate return Key_Type is
		begin
			return Key_Candidate;
		end Get_Key_Candidate;
		
		function Get_Key_Index return Natural is
		begin
			return Key_Index;
		end Get_Key_Index;
		
		function Is_Done return Boolean is
		begin
			return Done;
		end Is_Done;
		
		procedure Interrupt is
		begin
			Done := True;
		end Interrupt;
		
		procedure Set_Correct_Candidate(Key_Candidate: Key_Type) is
		begin
			Correct_Key_Candidate := Clone(Key_Candidate);
		end Set_Correct_Candidate;
		
	end Mini_RC4_Properties;
	
end Shared;
