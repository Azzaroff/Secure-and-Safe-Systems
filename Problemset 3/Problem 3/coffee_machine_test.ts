context with coffee_machine; 	use coffee_machine;
	with Text_IO;    	use Text_IO;

***** COFFEE_MACHINE put in coin
define cm_state 	: 	State;  
	act		:	Action	:= Ten_Cent;
	rea		:	Reaction;
	Result		:	Reaction := Nothing;
prepare initialize(cm_state);
test   X(cm_state, act, rea);
pass   Result = rea

***** COFFEE_MACHINE put in coin two
define cm_state 	: 	State;  
	act		:	Action	:= Twenty_Cent;
	rea		:	Reaction;
	Result 		: 	Reaction:= Nothing;
prepare initialize(cm_state);
test   X(cm_state, act, rea);
pass   Result = rea

***** COFFEE_MACHINE put in coin with state
define cm_state 	: 	State;  
	act10		:	Action	:= Ten_Cent;
	rea		:	Reaction;
	Result 		: 	Reaction:= Nothing;
prepare initialize(cm_state);
	X(cm_state, act10, rea); 
test	X(cm_state, act10, rea);
pass	Result = rea

***** COFFEE_MACHINE put in coin and make coffee
define cm_state 	: 	State;
	act10		:	Action	:= Ten_Cent;  
	act20		:	Action	:= Twenty_Cent;
	rea		:	Reaction;
	Result 		: 	Reaction := Coffee;
prepare initialize(cm_state);
	X(cm_state, act10, rea);
test	X(cm_state, act20, rea);
pass	Result = rea

***** COFFEE_MACHINE put in coin two and make coffee
define cm_state 	: 	State;
	act20		:	Action	:= Twenty_Cent;  
	act10		:	Action	:= Ten_Cent;
	rea		:	Reaction;
	Result 		: 	Reaction := Coffee;
prepare initialize(cm_state);
	X(cm_state, act20, rea);
test	X(cm_state, act10, rea);
pass	Result = rea

***** COFFEE_MACHINE put in coin with state
define cm_state 	: 	State;  
	act10		:	Action	:= Ten_Cent;
	rea		:	Reaction;
	Result 		: 	Reaction:= Coffee;
prepare initialize(cm_state);
	X(cm_state, act10, rea); 
	X(cm_state, act10, rea);
test	X(cm_state, act10, rea);
pass	Result = rea

***** COFFEE_MACHINE put in two twenty cent coin
define cm_state 	: 	State;  
	act20		:	Action	:= Twenty_Cent;
	rea		:	Reaction;
	Result 		: 	Reaction:= Coffee;
prepare initialize(cm_state);
	X(cm_state, act20, rea);
test	X(cm_state, act20, rea);
pass	Result = rea

***** COFFEE_MACHINE put in two ten cent and one twenty cent coin
define cm_state 	: 	State;  
	act10		:	Action	:= Ten_Cent;
	act20		:	Action	:= Twenty_Cent;
	rea		:	Reaction;
	Result 		: 	Reaction:= Coffee;
prepare initialize(cm_state);
	X(cm_state, act10, rea);
	X(cm_state, act10, rea);
test	X(cm_state, act20, rea);
pass	Result = rea

***** COFFEE_MACHINE return coin ten
define cm_state 	: 	State;  
	act10		:	Action	:= Ten_Cent;
	actbtn		:	Action	:= Button;
	rea		:	Reaction;
	Result 		: 	Reaction:= Drop_all_Coins;
prepare initialize(cm_state);
	X(cm_state, act10, rea);
test	X(cm_state, actbtn, rea);
pass	Result = rea

***** COFFEE_MACHINE return coin twenty
define cm_state 	: 	State;  
	act20		:	Action	:= Twenty_Cent;
	actbtn		:	Action	:= Button;
	rea		:	Reaction;
	Result 		: 	Reaction:= Drop_all_Coins;
prepare initialize(cm_state);
	X(cm_state, act20, rea);
test	X(cm_state, actbtn, rea);
pass	Result = rea

***** COFFEE_MACHINE return coin two ten cent coins
define cm_state 	: 	State;  
	act10		:	Action	:= Ten_Cent;
	actbtn		:	Action	:= Button;
	rea		:	Reaction;
	Result 		: 	Reaction:= Drop_all_Coins;
prepare initialize(cm_state);
	X(cm_state, act10, rea);
	X(cm_state, act10, rea);
test	X(cm_state, actbtn, rea);
pass	Result = rea

***** COFFEE_MACHINE return no coin
define cm_state 	: 	State;  
	actbtn		:	Action	:= Button;
	rea		:	Reaction;
	Result 		: 	Reaction:= Nothing;
prepare initialize(cm_state);
test	X(cm_state, actbtn, rea);
pass	Result = rea
