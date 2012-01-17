package Hofstadter_Parallel is
    type List_Type is array(Positive range <>) of Integer;

    function Q(N: Positive) return Positive;
    procedure Mute_Workers(End_Value : Integer; End_Time : Duration);
    protected type Hofstadter_Array(S : Integer) is       
        procedure Get_Value(Index : in out Positive; success : out Boolean); -- return on Index the value or Index, if the value was not recently calculated
        procedure Put_Value(Index, Value : Positive);
        procedure Print;
        private
		List : List_Type(1 .. S) := (others => 0);
    end Hofstadter_Array;
    protected type One_Way_Counter(N: Positive) is
	procedure Increment;
	function Is_Done return Boolean;
	private
		Threshold : Natural := 0;
    end One_Way_Counter;
end Hofstadter_Parallel;
