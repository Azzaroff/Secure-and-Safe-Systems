with Ada.Text_IO, Faculty;
with Ada.Command_Line; use Ada.Command_Line;


procedure Faculty_Main is
begin
	Faculty.calculate_faculty(Integer'Value(Argument(1)));
end Faculty_Main;
