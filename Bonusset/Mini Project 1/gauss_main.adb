with Ada.Text_IO, Gauss;
with Ada.Command_Line; use Ada.Command_Line;

procedure gauss_main is


begin
	Ada.Text_IO.Put("Gauss sum of " & Argument(1) & " =");
    Ada.Text_IO.Put_Line(Gauss.gauss_sum(Gauss.Gauss_Positive'Value(Argument(1)))'Img);
end gauss_main;
