context with coffee_machine; 	use coffee_machine;
	with Text_IO;    	use Text_IO;

***** COFFEE_MACHINE start machine
define cm_state : 	State	:= 0;  
			Result 	: State;
test   Initialize(Result);
pass   Result = cm_state

***** COFFEE_MACHINE put in coin
define cm_state 	: 	State	:= 0;  
	act		:	Action	:= Ten_Cent;
	rea		:	Reaction;
	Result 		: 	State	:= 1;
test   X(cm_state, act, rea);
pass   Result = cm_state

***** COFFEE_MACHINE put in coin two
define cm_state 	: 	State	:= 1;  
	act		:	Action	:= Ten_Cent;
	rea		:	Reaction;
	Result 		: 	State	:= 2;
test   X(cm_state, act, rea);
pass   Result = cm_state

***** COFFEE_MACHINE put in coin with state
define cm_state 	: 	State	:= 1;  
	act		:	Action	:= Ten_Cent;
	rea		:	Reaction;
	Result 		: 	State	:= 2;
test	X(cm_state, act, rea);
pass	Result = cm_state

***** COFFEE_MACHINE put in coin and make coffee
define cm_state 	: 	State	:= 2;  
	act		:	Action	:= Twenty_Cent;
	rea		:	Reaction;
	Result 		: 	State	:= 0;
test	X(cm_state, act, rea);
pass	Result = cm_state

***** COFFEE_MACHINE put in coin and make two
define cm_state 	: 	State	:= 2;  
	act		:	Action	:= Twenty_Cent;
	rea		:	Reaction;
	Result 		: 	Reaction:= Coffee;
test	X(cm_state, act, rea);
pass	Result = rea

***** COFFEE_MACHINE put in coin and make three
define cm_state 	: 	State	:= 2;  
	act		:	Action	:= Ten_Cent;
	rea		:	Reaction;
	Result 		: 	Reaction:= Coffee;
test	X(cm_state, act, rea);
pass	Result = rea
