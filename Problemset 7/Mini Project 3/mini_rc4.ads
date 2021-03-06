
package Mini_RC4 is
   type Byte is mod 2**8;
   for Byte'Size use 8;
   type Byte_Array is array (Natural range <>) of Byte;
   
   subtype Key_Type is Byte_Array(0..3);
   
   type Context_Type is private;
   
   procedure Key_Scheduler(Key : in Key_Type; Ctx : out Context_Type);   
   procedure Get_Keystream(Ctx : in out Context_Type;
			   Keystream : out Byte_Array);
   
private
   subtype Expanded_Key_Type is Byte_Array(0..255);
   
   type Context_Type is record
      S : Expanded_Key_Type;
   end record;
      
end Mini_RC4;
   
