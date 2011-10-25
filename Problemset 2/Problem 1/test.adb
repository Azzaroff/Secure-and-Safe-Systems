with rgb, Ada.Text_IO;

procedure test is
use rgb;

	procedure Plus is
	use rgb;
	col54, col240 : Color;

	begin
	Ada.Text_IO.Put_Line ("Procedure Plus");
	col54 	:= rgb.To_Color(54, 17, 27);
	col240  := rgb.To_Color(240, 63, 11);
	rgb.Put (col54);
	Ada.Text_IO.New_Line;
	rgb.Put (col240);
	Ada.Text_IO.New_Line;
	Ada.Text_IO.Put ("Result: ");
	Ada.Text_IO.New_Line;
	Put (col54 + col240);
	Ada.Text_IO.New_Line;
	end Plus;

	procedure Minus is
	use rgb;
	col1, col2 : Color;

	begin
	Ada.Text_IO.Put_Line ("Procedure Minus");
	col1 	:= rgb.To_Color(54, 17, 27);
	col2  	:= rgb.To_Color(240, 63, 11);
	rgb.Put (col1);
	Ada.Text_IO.New_Line;
	rgb.Put (col2);
	Ada.Text_IO.New_Line;
	Ada.Text_IO.Put ("Result: ");
	Ada.Text_IO.New_Line;
	Put (col1 - col2);
	Ada.Text_IO.New_Line;
	end Minus;

	procedure Dot is
	use rgb;
	col1, col2 : Color;

	begin
	Ada.Text_IO.Put_Line ("Procedure Dot");
	col1 	:= rgb.To_Color(54, 17, 27);
	col2  	:= rgb.To_Color(240, 63, 11);
	rgb.Put (col1);
	Ada.Text_IO.New_Line;
	rgb.Put (col2);
	Ada.Text_IO.New_Line;
	Ada.Text_IO.Put ("Result: ");
	Ada.Text_IO.New_Line;
	Put (col1 * col2);
	Ada.Text_IO.New_Line;
	end Dot;

begin
Plus;
Minus;
Dot;
end test;


