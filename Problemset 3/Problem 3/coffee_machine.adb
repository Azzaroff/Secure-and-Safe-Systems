package body coffee_machine is

procedure Initialize( X : out State) is
begin
X := 0; 
end Initialize;

-- there are three states:
-- 0: wait for money
-- 1: ten cent where given to the machine
-- 2: twenty cent whre given to the machine
procedure X(S     : in out State;
	       Act   : in Action;
	       React : out Reaction) is
begin

case Act  is
	when Ten_Cent =>
		if S = 0 then -- add the money to the credit
			S	:= 1;
			React	:= Nothing;
		elsif S = 1 then -- add the money to the credit
			S	:= 2;
			React	:= Nothing;
		else -- credit is enought to produce coffee
			S	:= 0;
			React	:= Coffee;
		end if;		
	when Twenty_Cent =>
		if S = 0 then -- add the money to the credit
			S	:= 2;
			React	:= Nothing;
		else -- es ist egal ob schon 10 oder 20ct drin waren, Kaffee gibts sowieso und der Rest vom Geld ist weg
			S	:= 0;
			React	:= Coffee;
		end if;
	when Button =>
		if S = 0 then -- no money was given
			S 	:= 0; -- evtl. weglassen
			React	:= Nothing;
		else -- some money was given to the machine
			S 	:= 0;
			React 	:= Drop_all_Coins;
		end if;
end case;
end X;

end coffee_machine;
