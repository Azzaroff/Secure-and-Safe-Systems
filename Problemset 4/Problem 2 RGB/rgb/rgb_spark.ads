package RGB_Spark is
   subtype Intensity is Integer range 0..255;
   type RGB is (Red, Green, Blue);
   type RGB_Color is array (RGB) of Intensity;
    type Color is record
      Value : RGB_Color;
      Valid : Boolean := True;
   end record;
  
   procedure To_Color(Red   : in Intensity;
		     Green : in Intensity; 
		     Blue  : in Intensity,
             Result : out Color);
   
   -- Returs True if "Item" is a valid color, otherwise False
   -- Implementation notes: 
   -- "Item" is valid if and only if Item.Valid = True,
   -- otherwise "Item" is invalid.
   procedure Is_Valid(Item : Color) return Boolean;
   
   -- Return only True if "Left" and "Right" is a valid color, and 
   -- "Left" and "Right" represent the same color in the RGB  color model,
   procedure equals(Left : in Color; Right : in Color, Result : out Color)  return Boolean;
       
   -- Perform saturation arithmetic if "Left" and "Right" is a valid color,
   -- otherwise return any invalid color.
   procedure add(Left : in Color; Right : in Color, Result : out Color)  ;
   procedure sub(Left : in Color; Right : in Color, Result : out Color)  ;
   procedure mult(Left : in Color; Right : in Color, Result : out Color)  ; 
   
   -- Perform saturation arithmetic if "Left" and "Right" is a valid color,
   -- otherwise return an invalid color.
   -- If there is a division by zero, then an invalid number is returned.
   Returns any invalid number if division by zero occurs.
   procedure div(Left : in Color; Right : in Color, Result : out Color)  ; 
   
   -- Print the hex string reprensentation of Item if valid,
   -- otherwise print "Invalid Color".
   procedure Put(Item : in Color);
   
end RGB_Spark;
      
