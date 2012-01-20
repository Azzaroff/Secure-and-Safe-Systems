with Ada.Text_IO; use Ada.Text_IO; 
with Ada.Strings.Unbounded;
with Ada.Integer_Text_IO;
with Ada.Containers.Vectors;
with Ada.Command_Line; use Ada.Command_Line;
with Mergesort; 
with Ada.Calendar;
with Ada.Calendar.Formatting;

procedure Mergesort_Test is
   type List_Type is array(Positive range <>) of Integer;
   package Integer_Vectors is new Ada.Containers.Vectors(Natural, Integer);

   

   package List_Sort is new Mergesort(Integer, Positive, List_Type);

   procedure Print(Item : List_Type) is
	Command : Character;
	Available : Boolean;

   begin 
      for I in Item'range loop
	 Ada.Text_IO.Get_Immediate (Command, Available);
	 exit when Available and (Command = 'q' or Command = 'Q'); 
         Put(Integer'Image(Item(I)));
      end loop;
      New_Line;
   end Print;

   function Read_Ints (File_Name : String) return Integer_Vectors.Vector is
 
   Input_File      	: Ada.Text_IO.File_Type;
   Num       		: Integer;
   
   Numbers : Integer_Vectors.Vector;
 
   begin
 
   Ada.Text_IO.Open (File=>Input_File, Mode=>Ada.Text_IO.In_File, Name=>File_Name);
   while not (Ada.Text_IO.End_Of_File (Input_File)) loop
      Ada.Integer_Text_IO.Get(Item => Num, File => Input_File);
      --Ada.Text_IO.Put_Line(Integer'Image(Num));
      Numbers.Append(Num);
   end loop;
   Ada.Text_IO.Close (File=>Input_File);
   return Numbers;
   end Read_Ints;


   
 
   --List : List_Type := (1, 5, 2, 7, 3, 9, 4, 6);
   Numbers : Integer_Vectors.Vector := Read_Ints(Argument(1));
   Cursor : Integer_Vectors.Cursor;
   List : List_Type(1 .. Integer(Numbers.Length));
   Index : Integer := 1;
   Start_Zeit, End_Zeit : Ada.Calendar.Time;
   Diff_Zeit : Ada.Calendar.Day_Duration;
--   h : Natural;
--   m : Natural;
--   s : Natural;
--   ms : Ada.Calendar.Day_Duration;
begin
   Cursor := Integer_Vectors.First(Numbers);
   while Integer_Vectors.Has_Element(Cursor) loop
        List(Index) := Integer_Vectors.Element(Cursor);
        Integer_Vectors.Next(Cursor);
        Index := Index + 1;
   end loop;
   
   Ada.Text_IO.Put_Line("unsorted List from file: ");
   --Print(List);
   Start_Zeit := Ada.Calendar.Clock;
   Ada.Text_IO.Put_Line("sorting");
   List := List_Sort.Sort_with_Tasks(List, Integer'Value(Argument(2)));
   Ada.Text_IO.Put_Line("done");
   Ada.Text_IO.Put_Line("sorted List: ");
   End_Zeit := Ada.Calendar.Clock;
   Diff_Zeit := Ada.Calendar."-"(End_Zeit,Start_Zeit);
   Print(List);
   --Ada.Calendar.Formatting.Split(Diff_Zeit,h,m,s,ms);
   Ada.Text_IO.Put_Line(Ada.Calendar.Formatting.Image(Diff_Zeit));
--   Ada.Text_IO.Put_Line(Integer'Image(h));
--   Ada.Text_IO.Put_Line(Integer'Image(m));
--   Ada.Text_IO.Put_Line(Integer'Image(s));
--   Ada.Text_IO.Put_Line(Ada.Calendar.Formatting.Image(ms));
end Mergesort_Test;


