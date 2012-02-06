with Ada.Text_IO;

procedure Read_Line (Result : out String; Filename : in String) is
   File       : Ada.Text_IO.File_Type;
begin
   Ada.Text_IO.Open (File => File,
                     Mode => Ada.Text_IO.In_File,
                     Name => Filename);
   while not Ada.Text_IO.End_Of_File (File) loop
      begin
         Result := Ada.Text_IO.Get_Line (File);
      end;
   end loop;
   Ada.Text_IO.Close (File);
end Read_Line;
