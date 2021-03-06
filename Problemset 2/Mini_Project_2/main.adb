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
   
   procedure Test_Union is
   s1, s2, s3 : List_Set.Set;
   begin
       List_Set.insert(s1,3);
       List_Set.insert(s2,4);
       List_Set.insert(s3,3);
       List_Set.insert(s3,4);

       IO.Put_Line("");
       IO.Put_Line("Testing UNION ('and')");
       IO.Put_Line("");

       IO.Put_Line("{3} union {4} should be equal to {3,4}");
       if ((s1 and s2) = s3) then
          IO.Put_Line("TRUE");
       else
          IO.Put_Line("FALSE");
       end if;

       IO.Put_Line("{3} union {4} should not be equal to {6,56,133}");
       s3 := List_Set.Empty_Set;
       List_Set.insert(s3,133);
       List_Set.insert(s3,6);
       List_Set.insert(s3,56);
   if not((s1 and s2) = s1) then
      IO.Put_Line("TRUE");
   else
      IO.Put_Line("FALSE");
   end if;

   IO.Put_Line("");
   IO.Put_Line("-----------------------------");
   IO.Put_Line("");

        
   end Test_Union;

   procedure Test_Intersection is
   s1, s2, s3 : List_Set.Set;
   begin
       IO.Put_Line("");
       IO.Put_Line("Testing Intersection ('or')");
       IO.Put_Line("");
       
       List_Set.insert(s1,3);
       List_Set.insert(s1,213);
       List_Set.insert(s1,3478364);
       List_Set.insert(s2,3);
       List_Set.insert(s2,4);
       List_Set.insert(s2,213);
       List_Set.insert(s3,3);
       List_Set.insert(s3,213);
       
       IO.Put_Line("{3,213,3478364} intersect {3,4,213} should be equal to {3,213}");
       if ((s1 or s2) = s3) then
          IO.Put_Line("TRUE");
       else
          IO.Put_Line("FALSE");
       end if;
       
          IO.Put_Line("");
       IO.Put_Line("-----------------------------");
       IO.Put_Line("");
       
   end Test_Intersection;

   procedure Test_Subsets is
   s1, s2 : List_Set.Set;
   begin
       IO.Put_Line("");
       IO.Put_Line("Testing Subsets ('<=','<')");
       IO.Put_Line("");
       
       List_Set.insert(s1,3);
       List_Set.insert(s1,213);
       List_Set.insert(s1,3478364);
       List_Set.insert(s2,3);
       List_Set.insert(s2,213);
       
       IO.Put_Line("{3,213} is a subset of {3,213,3478364}.");
       if (s2 <= s1) then
          IO.Put_Line("TRUE");
       else
          IO.Put_Line("FALSE");
       end if;
       
       IO.Put_Line("{3,213,3478364} is not  a subset of {3,213}.");
       if not(s1 <= s2) then
          IO.Put_Line("TRUE");
       else
          IO.Put_Line("FALSE");
       end if;
       
       IO.Put_Line("{3,213} is a subset of {3,213}.");
       if (s2 <= s2) then
          IO.Put_Line("TRUE");
       else
          IO.Put_Line("FALSE");
       end if;
       
       IO.Put_Line("{3,213} is a proper subset of {3,213,3478364}.");
       if (s2 < s1) then
          IO.Put_Line("TRUE");
       else
          IO.Put_Line("FALSE");
       end if;
       
       IO.Put_Line("{3,213} is not a propper subset of {3,213}.");
       if not(s2 < s2) then
          IO.Put_Line("TRUE");
       else
          IO.Put_Line("FALSE");
       end if;
       
       
       IO.Put_Line("");
       IO.Put_Line("-----------------------------");
       IO.Put_Line("");
       
   end Test_Subsets;
 
   procedure Test_Difference is
   s1,s2,s3 : List_Set.Set;
   begin
       IO.Put_Line("");
       IO.Put_Line("Testing Difference ('-')");
       IO.Put_Line("");
  
       List_Set.insert(s1,1);
       List_Set.insert(s1,2);
       List_Set.insert(s1,3);
       List_Set.insert(s1,4);
       List_Set.insert(s2,1);
       List_Set.insert(s2,2);
       List_Set.insert(s3,3);
       List_Set.insert(s3,4);

       IO.Put_Line("{1,2,3,4} - {1,2} should be {3,4}.");
       if ((s1 - s2) = s3) then
          IO.Put_Line("TRUE");
       else
          IO.Put_Line("FALSE");
       end if;

       IO.Put_Line("");
       IO.Put_Line("-----------------------------");
       IO.Put_Line("");
       
   end Test_Difference;

  
   procedure Test_Contains is
   s1 : List_Set.Set;
   begin
       IO.Put_Line("");
       IO.Put_Line("Testing Contains ('<=')");
       IO.Put_Line("");
  
       List_Set.insert(s1,1);
       List_Set.insert(s1,2);
       List_Set.insert(s1,3);
       List_Set.insert(s1,4);

       IO.Put_Line("{1,2,3,4} contains 3.");
       if (3 <= s1) then
          IO.Put_Line("TRUE");
       else
          IO.Put_Line("FALSE");
       end if;
 
       IO.Put_Line("{1,2,3,4} should not contain 5.");
       if not(5 <= s1) then
          IO.Put_Line("TRUE");
       else
          IO.Put_Line("FALSE");
       end if;

       IO.Put_Line("");
       IO.Put_Line("-----------------------------");
       IO.Put_Line("");
       
   end Test_Contains;


begin
   IO.Put_Line("Running all tests");
   Test_Union;
   Test_Intersection;
   Test_Difference;
   Test_Subsets;
   Test_Contains;


end main;
