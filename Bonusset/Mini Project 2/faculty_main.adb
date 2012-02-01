with Ada.Text_IO, Faculty;
with Ada.Command_Line; use Ada.Command_Line;


procedure Faculty_Main is
begin
	Ada.Text_IO.Put("The faculty of n ="&Argument(1)&" is ");
	Ada.Text_IO.Put_Line(Faculty.calculate_faculty(Integer'Value(Argument(1)))'Img);
end Faculty_Main;
