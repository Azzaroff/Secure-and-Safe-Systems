with Ada.Text_IO; 
with Ada.Real_Time;
with Ada.Calendar;
with Ada.Calendar.Formatting;

package body Mergesort is

-----------------
-- Shared Type --
-----------------


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

------------------
-- declaration ---
------------------
Ragnaroek : Abort_Tasks;
 
   -----------
   -- Merge --
   -----------
 
   procedure Merge(Left, Right : in Collection_Type; Result : out Collection_Type; Time_Out : Integer) is
      Left_Index : Index_Type := Left'First;
      Right_Index : Index_Type := Right'First;
      Result_Index : Index_Type := Result'First;
	  Command : Character;
	  Available : Boolean;
   begin
      while Left_Index <= Left'Last and Right_Index <= Right'Last loop
		Ada.Text_IO.Get_Immediate (Command, Available);
	    if ((Available and then Command = 'q') or Ragnaroek.Is_Timed_Out(Time_Out) or Ragnaroek.Is_Done) then
			exit;
		end if;
		if Left(Left_Index) < Right(Right_Index) then
            Result(Result_Index) := Left(Left_Index);
            Left_Index := Index_Type'Succ(Left_Index); -- increment Left_Index
         else
            Result(Result_Index) := Right(Right_Index);
            Right_Index := Index_Type'Succ(Right_Index); -- increment Right_Index
         end if;
         Result_Index := Index_Type'Succ(Result_Index); -- increment Result_Index
      end loop;
	  Ada.Text_IO.Get_Immediate (Command, Available);
      if not ((Available and then Command = 'q') or Ragnaroek.Is_Timed_Out(Time_Out) or Ragnaroek.Is_Done) then
			  if Left_Index <= Left'Last then
				 Result(Result_Index..Result'Last) := Left(Left_Index..Left'Last);
			  end if;
			  if Right_Index <= Right'Last then
				 Result(Result_Index..Result'Last) := Right(Right_Index..Right'Last);
			  end if;
		end if;
   end Merge;
 
   ----------
   -- Sort --
   ----------
 
   procedure Sort (Item : in out Collection_Type; Time_Out : Integer)is
      Middle : Index_Type;
      Command   : Character;
      Available : Boolean;

   begin
      if Item'Length > 1 then
         Middle := Index_Type'Val((Item'Length / 2) + Index_Type'Pos(Item'First));
         declare
            Left : Collection_Type(Item'First..Index_Type'Pred(Middle));
            Right : Collection_Type(Middle..Item'Last);
         begin
            for I in Left'range loop
               Left(I) := Item(I);
            end loop;
            for I in Right'range loop
               Right(I) := Item(I);
            end loop;
	    Ada.Text_IO.Get_Immediate (Command, Available);
	    if not ((Available and then Command = 'q') or Ragnaroek.Is_Timed_Out(Time_Out) or Ragnaroek.Is_Done) then
		    Sort(Left, Time_Out);
		    Sort(Right, Time_Out);
		    Merge(Left, Right, Item, Time_Out);
	    end if;
         end;
      end if;
   end Sort;

   function Sort_with_Tasks (Item : Collection_Type; Time_Out : Integer) return Collection_Type is 

	task Left_Task is
		entry Sort_Left(Item : in out Collection_Type);
	end Left_Task;

	task Right_Task is
		entry Sort_Right(Item : in out Collection_Type);
	end Right_Task;

	task body Left_Task is
	begin
		accept Sort_Left(Item : in out Collection_Type) do
			Sort(Item, Time_Out);
		end Sort_Left;
	end Left_Task;

	task body Right_Task is
	begin
		accept Sort_Right(Item : in out Collection_Type) do
			Sort(Item, Time_Out);
		end Sort_Right;
	end Right_Task;

	Result : Collection_Type(Item'range);
      	Middle : Index_Type;

   begin
	Ragnaroek.Start_Time_Counter;
	if Item'Length <= 1 then
         return Item;
       else
         Middle := Index_Type'Val((Item'Length / 2) + Index_Type'Pos(Item'First));
         declare
            Left : Collection_Type(Item'First..Index_Type'Pred(Middle));
            Right : Collection_Type(Middle..Item'Last);
         begin
			if Ragnaroek.Is_Timed_Out(Time_Out) or Ragnaroek.Is_Done then
				return Item;
			end if;				
            for I in Left'range loop
               Left(I) := Item(I);
            end loop;
            for I in Right'range loop
               Right(I) := Item(I);
            end loop;
			if Ragnaroek.Is_Timed_Out(Time_Out) then
				return Item;
			end if;	
            Left_Task.Sort_Left(Left);
            Right_Task.Sort_Right(Right);
			if Ragnaroek.Is_Timed_Out(Time_Out) or Ragnaroek.Is_Done then
				return Item;
			end if;	
            Merge(Left, Right, Result, Time_Out);
         end;
         return Result;
      end if;


   end Sort_with_Tasks;
 
end Mergesort;
