package RGB_Spark is
   type Color is private;
   subtype Intensity is Integer range 0..255;
      
   function To_Color(Red   : Intensity;
		     Green : Intensity; 
		     Blue  : Intensity)
		    return Color;
   
   
   -- Returs True if "Item" is a valid color, otherwise False
   -- Implementation notes: 
   -- "Item" is valid if and only if Item.Valid = True,
   -- otherwise "Item" is invalid.
   function Is_Valid(Item : Color) return Boolean;
   
   -- Return only True if "Left" and "Right" is a valid color, and 
   -- "Left" and "Right" represent the same color in the RGB  color model,
   function "="(Left : Color; Right : Color)  return Boolean;
       
   -- Perform saturation arithmetic if "Left" and "Right" is a valid color,
   -- otherwise return any invalid color.
   function "+"(Left : Color; Right : Color)  return Color;
   function "-"(Left : Color; Right : Color)  return Color;
   function "*"(Left : Color; Right : Color)  return Color; 
   
   -- Perform saturation arithmetic if "Left" and "Right" is a valid color,
   -- otherwise return an invalid color.
   -- If there is a division by zero, then an invalid number is returned.
   Returns any invalid number if division by zero occurs.
   function "/"(Left : Color; Right : Color)  return Color; 
   
   -- Print the hex string reprensentation of Item if valid,
   -- otherwise print "Invalid Color".
   procedure Put(Item : in Color);
   
private
   type RGB is (Red, Green, Blue);
   type RGB_Color is array (RGB) of Intensity;
    type Color is record
      Value : RGB_Color;
      Valid : Boolean := True;
   end record;
end RGB_Spark;
      
