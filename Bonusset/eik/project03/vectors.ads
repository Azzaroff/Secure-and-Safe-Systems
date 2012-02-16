package Vectors is
   type Float_Vector is array (Positive range <>) of Float;
   
   procedure Vector_Put (X : Float_Vector) ;
      
   -- cross product
   function "*" (Left, Right : Float_Vector) return Float_Vector;
   
    -- scalar product
   function "*" (Left, Right : Float_Vector) return Float;
   
   -- stretching
   function "*" (Left : Float_Vector; Right : Float) return Float_Vector;
end Vectors;
   
