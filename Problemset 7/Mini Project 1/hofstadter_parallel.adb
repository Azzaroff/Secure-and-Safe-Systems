with Hofstadter_Parallel, Ada.Text_IO, Ada.Real_Time, Ada.Calendar, Ada.Calendar.Formatting;
with Armageddon;

package body Hofstadter_Parallel is

Ragnaroek : Abort_Tasks;

function Q(N: Positive) return Positive is
   begin
	  if Ragnaroek.Is_Done then
		  return 1;
	  end if;
      if N < 3 then
         return 1;
      else
         return Q(N - Q(N-1)) + Q(N - Q(N-2));
      end if;
   end Q;

protected body Hofstadter_Array is
	procedure Get_Value(Index : in out Positive; success : out Boolean) is 
	Old_Index : Positive := Index;
	begin
		if List(Index) > 0 then
			success := true;
			Index := List(Old_Index);
			--Ada.Text_IO.Put_Line(Old_Index'Img & Index'Img);
		else
			success := false;
		end if;
	end Get_Value;
	procedure Put_Value(Index, Value : Positive) is
	begin
		List(Index) := Value;
	end Put_Value;
	procedure Print is
	begin
	   Ada.Text_IO.Put_Line("print:");
	   for I in List'range loop
		if List(I) > 0 then
			Ada.Text_IO.Put_Line(I'Img & List(I)'Img);
		end if;
   	   end loop;
	end Print;
end Hofstadter_Array;

protected body One_Way_Counter is
	procedure Increment is
	begin
		if Threshold < N then
			Threshold := Threshold + 1;
		end if;
	end Increment;
	function Is_Done return Boolean is
	begin
		return (Threshold = N);
	end Is_Done;
end One_Way_Counter;

protected body Abort_Tasks is
	procedure Set_Done is
	begin
	    Done := True;
    end Set_Done;
	function Is_Done return Boolean is
	begin
		return Done;
	end Is_Done;
	procedure Start_Time_Counter is
	begin
		Start_Time := Ada.Real_Time.Clock;
	end Start_Time_Counter;
	function Is_Timed_Out(time_out : Integer) return Boolean is
	now : Ada.Real_Time.Time := Ada.Real_Time.Clock;
	difference : Ada.Real_Time.Time_Span;
	begin
		difference := Ada.Real_Time."-"(now, Start_Time);
		--Ada.Text_IO.Put_Line("time_out: "&time_out'Img);
		--Ada.Text_IO.Put_Line("Differenz: "& Ada.Calendar.Formatting.Image(Ada.Real_Time.To_Duration(difference)));
		--Ada.Text_IO.Put_Line("End Value: "& Ada.Calendar.Formatting.Image(Ada.Real_Time.To_Duration(Ada.Real_Time.Milliseconds(1000*time_out))));
		return (Ada.Real_Time.">"(difference, Ada.Real_Time.Milliseconds(1000*time_out)));
	end Is_Timed_Out;
	
end Abort_Tasks;


procedure Mute_Workers (End_Value : Integer; End_Time : Integer) is
	hof_array : Hofstadter_Array(End_Value);
	one_counter : One_Way_Counter(4);

	

	task type Worker is
		entry Start(Name: Character;
				Start, Offset, Counter : Positive;
				End_Time : Integer);
	end Worker;

    task body Worker is
		My_Name : Character := '?';
		Val, Diff, Cnt: Positive;
		Command : Character;
		Available : Boolean;
		E_T  : Integer;
		hof_val : Positive;
		hof_eval: Boolean;
		begin
		accept Start(Name: Character;
				Start, Offset, Counter : Positive;
				End_Time : Integer) do
			My_Name := Name;
			Val 	:= Start;
			Diff 	:= Offset;
			Cnt	:= Counter;
			E_T     := End_Time;
		end Start;
		while Val <= Cnt loop
			if Ragnaroek.Is_Timed_Out(E_T) then
				Ragnaroek.Set_Done;
			end if;
			Ada.Text_IO.Get_Immediate (Command, Available);
			if (Available and Command = 'q') or Ragnaroek.Is_Done then
                		Ragnaroek.Set_Done;  
                		exit;
            		end if;
			hof_val := Val;
			hof_array.Get_Value(hof_val, hof_eval);
			if not hof_eval then
				hof_val := Q(Val);
				if not Ragnaroek.Is_Done then
					hof_array.Put_Value(Val, hof_val);
				end if;
			end if;
			Ada.Text_IO.Put_Line(My_Name & " " & Val'Img & hof_val'Img);
			Val := Val + Diff;
		end loop;
		one_counter.Increment;
	end Worker;

begin

    declare
        O, Tw, Th, F: Worker;--, Fi, S, Se, E : Worker;
    begin --declare
		Ragnaroek.Start_Time_Counter;
		O.Start('1', 1, 4, End_Value, End_Time);
   		Tw.Start('2', 2, 4, End_Value, End_Time);
   		Th.Start('3', 3, 4, End_Value, End_Time);
   		F.Start('4', 4, 4, End_Value, End_Time);
--       Fi.Start('5', 5, 8, End_Value, End_Time);
--       S.Start('6', 6, 8, End_Value, End_Time);
--       Se.Start('7', 7, 8, End_Value, End_Time);
--       E.Start('8', 8, 8, End_Value, End_Time);		
    end; --declare


  -- while not one_counter.Is_Done loop
--	null;
 --  end loop;   
   hof_array.Print;

end Mute_Workers;

end Hofstadter_Parallel;
