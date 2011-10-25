with Ada.Text_IO;
with Sets_With_Hash;
with Ada.Containers;


procedure main is

   package IO renames Ada.Text_IO;

   function Hash ( Item : Positive ) return Ada.Containers.Hash_Type is
   begin
      return Ada.Containers.Hash_Type(Item);
   end Hash;

   package Hash_Set is new Sets_With_Hash
     ( Item_Type => Positive,
      "=" => "=",
      Hash => Hash);

   s1, s2, s3 : Hash_Set.Set;

   use Hash_Set;
begin
   IO.Put_Line("Running all tests");

   Hash_Set.insert(s1,3);
   Hash_Set.insert(s2,4);
   Hash_Set.insert(s3,3);
   Hash_Set.insert(s3,4);

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
   s3 := Hash_Set.Empty_Set;
   Hash_Set.insert(s3,133);
   Hash_Set.insert(s3,6);
   Hash_Set.insert(s3,56);
   if not((s1 and s2) = s1) then
      IO.Put_Line("TRUE");
   else
      IO.Put_Line("FALSE");
   end if;

   IO.Put_Line("");
   IO.Put_Line("-----------------------------");
   IO.Put_Line("");
end main;