with Hofstadter_Parallel, Hofstadter, Ada.Text_IO;

package body Hofstadter_Parallel is

protected body Hofstadter_Array is
	procedure Get_Value(Index : in out Positive; success : out Boolean) is 
	Old_Index : Positive := Index;
	begin
		if List(Index) /= 0 then
			success := true;
			Index := List(Old_Index);
		else
			success := false;
		end if;
	end Get_Value;
	procedure Put_Value(Index, Value : Positive) is
	begin
		List(Index) := Value;
	end Put_Value;
end Hofstadter_Array;


procedure Mute_Workers (End_Value : Integer) is
	type List_Type is array(Positive range <>) of Integer;

	task type Worker is
		entry Start(Name: Character;
				Start, Offset, Counter : Positive);
	end Worker;

	task body Worker is
		My_Name : Character := '?';
		Val, Diff, Cnt: Positive;
		hof_array : Hofstadter_Array(Cnt);
		hof_val : Positive;
		hof_eval: Boolean;
		begin
		accept Start(Name: Character;
				Start, Offset, Counter : Positive) do
			My_Name := Name;
			Val 	:= Start;
			Diff 	:= Offset;
			Cnt	:= Counter;
		end Start;
		for I in 1 .. Cnt loop
			hof_val := I;
			hof_array.Get_Value(hof_val, hof_eval);
			if not hof_eval then
				hof_val := Hofstadter.Q(Val);
				hof_array.Put_Value(I, hof_val);
			end if;
			Ada.Text_IO.Put_Line(My_Name & " " & Val'Img & hof_val'Img);
			Val := Val + Diff;
		end loop;
	end Worker;

	O, Tw, Th, F : Worker;
begin
   O.Start('1', 1, 4, End_Value);
   Tw.Start('2', 2, 4, End_Value);
   Th.Start('3', 3, 4, End_Value);
   F.Start('4', 4, 4, End_Value);

end Mute_Workers;

end Hofstadter_Parallel;
