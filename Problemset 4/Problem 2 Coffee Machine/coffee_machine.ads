package Coffee_Machine is
   -- Simulation of a coin-driven coffee machine
   -- User: - One slot to insert coins (only, 10 or, 20 cents)
   --       - One button to press (''money back'')
   -- Machine: one slot to drop coins, the coffee output
   -- Given 30 cents or more, the coffee is produced immediately
   -- (Note that Overspending is Possible)
      
   type State is private;
   type Action is(Ten_Cent, Twenty_Cent, Button);
   type Reaction is(Nothing, Drop_All_Coins, Coffee);

   -- pre conditions not necessary, because very possible input can occur
   -- no need for range checks because compiler checks that

   procedure Initialize( X : out State);
   post => (X = 0); 

   procedure X(S     : in out State;
	       Act   : in Action;
	       React : out Reaction);
   post => (if (S'old /= S) then (
             if Act = Ten_Cent then (
                 if S'Old = 0 then (
			React = Nothing;
			S = 1;
		)elsif S'Old = 1 then (
			React = Nothing;
			S = 2;
		)elsif S'Old = 2 then (
			React = Coffee;
			S = 0;
		)
             )elsif Act = Twenty_Cent then (
		if S'Old = 0 then (
			React = Nothing;
			S = 2;
		)elsif S'Old = 1 then (
			React = Coffee;
			S = 0;
		)elsif S'Old = 2 then (
			React = Coffee;
			S = 0;
		)
	     )elsif Act = Button then (
		if S'Old = 0 then (
			React = Nothing;
			S = 0;
		)elsif S'Old = 1 then (
			React = Drop_All_Coins;
			S = 0;
		)elsif S'Old = 2 then (
			React = Drop_All_Coins;
			S = 0;
		)
		)
           ); 
   
private
   type State is range 0..2;  
end Coffee_Machine;
