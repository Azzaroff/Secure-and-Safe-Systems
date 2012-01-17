with Hofstadter_Parallel;
with Ada.Command_Line; use Ada.Command_Line;

procedure Hofstadter_Main is

begin
	Hofstadter_Parallel.Mute_Workers(Integer'Value(Argument(1)), Duration'Value(Argument(2)));
end Hofstadter_Main;
