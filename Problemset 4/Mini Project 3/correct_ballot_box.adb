package body correct_ballot_box is

--VOTE FOR
procedure Vote_For(Vote: Options) is

begin
if Remaining_Voters > Voters'First then
	Remaining_Voters := Remaining_Voters - 1;
	Votes(Vote) := Votes(Vote) +1;
end if;

end Vote_For;

end correct_ballot_box;
