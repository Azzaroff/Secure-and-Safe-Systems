with Ada.Text_IO;

package body Vectors is
   package Float_IO is new Ada.Text_IO.Float_IO (Float);

   procedure Vector_Put (X : Float_Vector) is
   begin
      Ada.Text_IO.Put ("(");
      for I in X'Range loop
         Float_IO.Put (X (I), Aft => 1, Exp => 0);
         if I /= X'Last then
            Ada.Text_IO.Put (", ");
         end if;
      end loop;
      Ada.Text_IO.Put (")");
   end Vector_Put;

   -- cross product
   function "*" (Left, Right : Float_Vector) return Float_Vector is
   begin
      if Left'Length /= Right'Length then
         raise Constraint_Error with
	   "vectors of different size in dot product";
      end if;
      if Left'Length /= 3 then
         raise Constraint_Error with
	   "cross product only implemented for R**3";
      end if;
      return Float_Vector'(Left (Left'First + 1) * Right (Right'First + 2) -
                             Left (Left'First + 2) * Right (Right'First + 1),
                           Left (Left'First + 2) * Right (Right'First) -
                             Left (Left'First) * Right (Right'First + 2),
                           Left (Left'First) * Right (Right'First + 1) -
                             Left (Left'First + 1) * Right (Right'First));
   end "*";

   -- scalar product
   function "*" (Left, Right : Float_Vector) return Float is
      Result : Float := 0.0;
      I, J : Positive;
   begin
      if Left'Length /= Right'Length then
         raise Constraint_Error with
	   "vectors of different size in scalar product";
      end if;
      I := Left'First; J := Right'First;
      while I <= Left'Last and then J <= Right'Last loop
         Result := Result + Left (I) * Right (J);
         I := I + 1; J := J + 1;
      end loop;
      return Result;
   end "*";

   -- stretching
   function "*" (Left : Float_Vector; Right : Float) return Float_Vector is
      Result : Float_Vector (Left'Range);
   begin
      for I in Left'Range loop
         Result (I) := Left (I) * Right;
      end loop;
      return Result;
   end "*";
end Vectors;

