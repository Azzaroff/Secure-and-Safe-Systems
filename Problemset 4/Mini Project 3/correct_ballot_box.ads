package Correct_Ballot_Box is

   Number_Of_Options: constant Positive := 10;
   -- parties / candidates to choose from

   Number_Of_Voters: constant Positive := 1000;

   subtype Options is Positive range 1 .. Number_Of_Options;
   subtype Voters  is Natural  range 0 .. Number_Of_Voters;

   Remaining_Voters: Voters := Voters'Last;
   -- number of people who did not yet vote

   Votes: array(Options) of Voters := (others => 0);

   function Is_Empty return Boolean is
      ((Remaining_Voters = Voters'Last)
       and (for all I in Options => Votes(I) = 0));

   procedure Vote_For(Vote: Options) with
     Pre  => Remaining_Voters > 0,
     Post => (Remaining_Voters = Remaining_Voters'Old-1) and
       (for all I in Options => (if I = Vote
                                 then Votes(I) = Votes'Old(I) +1
                                 else Votes(I) = Votes'Old(I)));

end Correct_Ballot_Box;