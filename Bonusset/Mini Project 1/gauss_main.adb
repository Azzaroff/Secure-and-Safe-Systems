with Ada.Text_IO, Gauss;
with Ada.Command_Line; use Ada.Command_Line;

procedure gauss_main is


begin
	Gauss.gauss_sum(Integer'Value(Argument(1)));
end gauss_main;
