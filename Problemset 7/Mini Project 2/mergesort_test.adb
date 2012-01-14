with Ada.Text_IO; use Ada.Text_IO; 
with Ada.Strings.Unbounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Command_Line; use Ada.Command_Line;
with Mergesort; 
 
procedure Mergesort_Test is
   type List_Type is array(Positive range <>) of Integer;
   package List_Sort is new Mergesort(Integer, Positive, List_Type);
   procedure Print(Item : List_Type) is
   begin
      for I in Item'range loop
         Put(Integer'Image(Item(I)));
      end loop;
      New_Line;
   end Print;

   function Parse_Commas (Source_String : String) return List_Type is
   Index_List : array(1..256) of Natural;
   Next_Index : Natural := 1;
   Result_List : List_Type(1 .. 1);
   begin
   Index_List(Next_Index) := 1;
   while Index_List(Next_Index) < Source_String'Last loop
      Next_Index := Next_Index + 1;
      Index_List(Next_Index) := 1 + Index(Source_String(Index_List(Next_Index - 1)..Source_String'Last), ",");
      if Index_List(Next_Index) = 1 then 
         Index_List(Next_Index) := Source_String'Last + 2;
      end if;
      Result_List := Result_List & Integer'Value(Source_String(Index_List(Next_Index - 1)..Index_List(Next_Index)-2));
   end loop;
   return Result_List;
   end Parse_Commas;

   function Line_By_Line (Filename : in String) return List_Type is
   File       : Ada.Text_IO.File_Type;
   Line_Count : Natural := 0;
   List_of_Numbers : List_Type(1 .. 1);
   begin
   Ada.Text_IO.Open (File => File,
	             Mode => Ada.Text_IO.In_File,
	             Name => Filename);
   while not Ada.Text_IO.End_Of_File (File) loop
      declare
	 Line : String := Ada.Text_IO.Get_Line (File);
      begin
	 Line_Count := Line_Count + 1;
	 List_of_Numbers := List_of_Numbers & Parse_Commas(Line);
      end;
   end loop;
   Ada.Text_IO.Close (File);
   return List_of_Numbers;
end Line_By_Line;


   
 
   List : List_Type := (1, 5, 2, 7, 3, 9, 4, 6);
begin
   List := Line_By_Line(Argument(1));
   Print(List);
   List_Sort.Sort(List);
   Print(List);
end Mergesort_Test;


