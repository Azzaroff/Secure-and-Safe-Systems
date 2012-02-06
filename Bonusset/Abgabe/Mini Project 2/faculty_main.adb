with Ada.Text_IO, Faculty;
with Ada.Command_Line; use Ada.Command_Line;


procedure Faculty_Main is
result : Positive;
begin
	Ada.Text_IO.Put("The faculty of n ="&Argument(1)&" is ");
	Faculty.calculate_faculty(Integer'Value(Argument(1)), result);
	Ada.Text_IO.Put_Line(result'Img);
end Faculty_Main;
