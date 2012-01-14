package Hofstadter_Parallel is
    type List_Type is array(Positive range <>) of Integer;

    procedure Mute_Workers(End_Value : Integer);
    protected type Hofstadter_Array(S : Integer) is       
	procedure Get_Value(Index : in out Positive; success : out Boolean); -- return on Index the value or Index, if the value was not recently calculated
	procedure Put_Value(Index, Value : Positive);
        private
		List : List_Type(1 .. S);
    end Hofstadter_Array;
end Hofstadter_Parallel;
