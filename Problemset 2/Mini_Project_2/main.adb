with Ada.Text_IO;
with Sets_From_List;
with Ada.Containers;


procedure main is

   package IO renames Ada.Text_IO;

   package List_Set is new Sets_From_List
     ( Item_Type => Positive,
      "=" => "=");

   s1, s2, s3 : List_Set.Set;

   use List_Set;
begin
   IO.Put_Line("Running all tests");

   insert(s1,3);
   insert(s2,4);
   insert(s3,3);
   insert(s3,4);

   IO.Put_Line("");
   IO.Put_Line("Testing UNION");
   IO.Put_Line("");

   IO.Put_Line("{3} union {4} should be equal to {3,4}");
   if ((s1 and s2) = s3) then
      IO.Put_Line("TRUE");
   else
      IO.Put_Line("FALSE");
   end if;

   IO.Put_Line("{3} union {4} should not be equal to {6,56,133}");
   s3 := Empty_Set;
   insert(s3,133);
   insert(s3,6);
   insert(s3,56);
   if not((s1 and s2) = s1) then
      IO.Put_Line("TRUE");
   else
      IO.Put_Line("FALSE");
   end if;

   IO.Put_Line("");
   IO.Put_Line("-----------------------------");
   IO.Put_Line("");
end main;
