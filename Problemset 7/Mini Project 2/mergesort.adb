package body Mergesort is
 
   -----------
   -- Merge --
   -----------
 
   procedure Merge(Left, Right : in Collection_Type; Result : out Collection_Type) is
      Left_Index : Index_Type := Left'First;
      Right_Index : Index_Type := Right'First;
      Result_Index : Index_Type := Result'First;
   begin
      while Left_Index <= Left'Last and Right_Index <= Right'Last loop
         if Left(Left_Index) < Right(Right_Index) then
            Result(Result_Index) := Left(Left_Index);
            Left_Index := Index_Type'Succ(Left_Index); -- increment Left_Index
         else
            Result(Result_Index) := Right(Right_Index);
            Right_Index := Index_Type'Succ(Right_Index); -- increment Right_Index
         end if;
         Result_Index := Index_Type'Succ(Result_Index); -- increment Result_Index
      end loop;
      if Left_Index <= Left'Last then
         Result(Result_Index..Result'Last) := Left(Left_Index..Left'Last);
      end if;
      if Right_Index <= Right'Last then
         Result(Result_Index..Result'Last) := Right(Right_Index..Right'Last);
      end if;
   end Merge;
 
   ----------
   -- Sort --
   ----------
 
   procedure Sort (Item : in out Collection_Type)is
      Middle : Index_Type;
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
            Sort(Left);
            Sort(Right);
            Merge(Left, Right, Item);
         end;
      end if;
   end Sort;

   function Sort_with_Tasks (Item : Collection_Type) return Collection_Type is 

	task Left_Task is
		entry Sort_Left(Item : in out Collection_Type);
	end Left_Task;

	task Right_Task is
		entry Sort_Right(Item : in out Collection_Type);
	end Right_Task;

	task body Left_Task is
	begin
		accept Sort_Left(Item : in out Collection_Type) do
			Sort(Item);
		end Sort_Left;
	end Left_Task;

	task body Right_Task is
	begin
		accept Sort_Right(Item : in out Collection_Type) do
			Sort(Item);
		end Sort_Right;
	end Right_Task;

	Result : Collection_Type(Item'range);
      	Middle : Index_Type;

   begin
	if Item'Length <= 1 then
         return Item;
       else
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
            Left_Task.Sort_Left(Left);
            Right_Task.Sort_Right(Right);
            Merge(Left, Right, Result);
         end;
         return Result;
      end if;


   end Sort_with_Tasks;
 
end Mergesort;
