with Ada.Real_Time;
generic
   type Element_Type is private;
   type Index_Type is (<>);
   type Collection_Type is array(Index_Type range <>) of Element_Type;
   with function "<"(Left, Right : Element_Type) return Boolean is <>;
 
package Mergesort is
	protected type Abort_Tasks is
	procedure Set_Done;
	function Is_Done return Boolean;
	procedure Start_Time_Counter;
	function Is_Timed_Out(time_out : Integer) return Boolean;
	    private
		    Done : Boolean := false;
			Start_Time:Ada.Real_Time.Time;
    end Abort_Tasks;
   procedure Merge(Left, Right : in Collection_Type; Result : out Collection_Type; Time_Out : Integer);
   procedure Sort (Item : in out Collection_Type; Time_Out : Integer);
   function Sort_with_Tasks (Item : Collection_Type; Time_Out : Integer) return Collection_Type;
end MergeSort;
