package Correct_Ballot_Box 
--# own Remaining_Voters,Votes;
--# initializes Remaining_Voters,Votes;
is

   Number_Of_Options: constant Positive := 10;

-- parties / candidates to choose from

   Number_Of_Voters: constant Positive := 1000;

   subtype Options is Positive range 1 .. Number_Of_Options;
   subtype Voters  is Natural  range 0 .. Number_Of_Voters;
   type Votes_Array is array(Options) of Voters;

   Remaining_Voters: Voters := Voters'Last;
   -- number of people who did not yet vote

   Votes : Votes_Array := Votes_Array'(others => 0);


   function Is_Empty return Boolean;
   --# global in Remaining_Voters, Votes;
   --# return not((Remaining_Voters = Voters'Last) and then
   --# (for all I in Options range Votes'Range
   --# => (Votes(I) /= 0)));

   procedure Vote_For(Vote: Options);-- with
--     Pre  => Remaining_Voters > 0,
--     Post => (Remaining_Voters = Remaining_Voters'Old-1) and
--       (for all I in Options => (if I = Vote
--                                 then Votes(I) = Votes'Old(I) +1
--                                 else Votes(I) = Votes'Old(I)));
   --# global in out Remaining_Voters;
   --#                   in out Votes;
   --# derives Remaining_Voters from * &
   --#         Votes from *, Vote, Remaining_Voters;
   --# pre (Remaining_Voters > 0);
   --# post (Remaining_Voters = Remaining_Voters~-1) and then
   --# (for all I in Options range Votes'Range
   --# => ( (Votes(I) = Votes~(I) + 1) or (Votes(I) = Votes~(I)) ));

end Correct_Ballot_Box;
