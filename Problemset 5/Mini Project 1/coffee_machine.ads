package coffee_machine is
   -- Simulation of a coin-driven coffee machine
   -- User: - One slot to insert coins (only, 10 or, 20 cents)
   --       - One button to press (''money back'')
   -- Machine: one slot to drop coins, the coffee output
   -- Given 30 cents or more, the coffee is produced immediately
   -- (Note that Overspending is Possible)
      
   type State is range 0..2;  
   type Action is(Ten_Cent, Twenty_Cent, Button);
   type Reaction is(Nothing, Drop_All_Coins, Coffee);

   -- pre conditions not necessary, because very possible input can occur
   -- no need for range checks because compiler checks that

   procedure Initialize( X : out State);
   --# derives X from ;

   --# post X = 0;
   

   procedure X(S     : in out State;
	       Act   : in Action;
	       React : out Reaction);
   --# derives 	S from *,Act &
   --#		React from S,Act;
   
end Coffee_Machine;
