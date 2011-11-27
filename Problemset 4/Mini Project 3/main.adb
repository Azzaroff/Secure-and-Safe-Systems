with Correct_Ballot_Box;
with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

-- this is only for testing the functionality of ballot box
-- don't care about spark correctness here :-P

procedure main is
package Rand_Int is new Ada.Numerics.Discrete_Random(Correct_Ballot_Box.Options);
seed : Rand_Int.Generator;
Num : Correct_Ballot_Box.Options;
begin
    Rand_Int.Reset(seed);
    if Correct_Ballot_Box.Is_Empty then
    
    for I in Correct_Ballot_Box.Voters loop
        Num := Rand_Int.Random(seed);
--      Put(Num'Image);
        Correct_Ballot_Box.Vote_For(Num);
    end loop;
    end if;


    if Correct_Ballot_Box.Remaining_Voters = 0 then
        Put("All votes submitted!");
    end if;

end main;
