package body correct_ballot_box is

--IS EMPTY
function Is_Empty return Boolean is
Result : Boolean := True;
begin
	if Remaining_Voters = Voters'Last then
		for I in Options range Options'First .. Options'Last loop
			if Votes(I) /= Votes'First then
				Result := False;
			end if;
		end loop;
	end if;
      return Result;
end Is_Empty;

--VOTE FOR
procedure Vote_For(Vote: Options) is

begin
if Remaining_Voters > Voters'First then
	Remaining_Voters := Remaining_Voters - 1;
	Votes(Vote) := Votes(Vote) +1;
end if;

end Vote_For;

end correct_ballot_box;
