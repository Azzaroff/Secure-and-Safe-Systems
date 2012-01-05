with Ada.Text_IO;
with Ada.Command_Line;
with gcd;

procedure main is
res : Natural;
begin
    gcd.GCD(Integer'Value(Ada.Command_Line.Argument(1)),Integer'Value(Ada.Command_Line.Argument(2)),res);
    Ada.Text_IO.put(Natural'Image(res));
end main;

