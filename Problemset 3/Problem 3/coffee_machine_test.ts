context with coffee_machine; 	use coffee_machine;
	with Text_IO;    	use Text_IO;

***** COFFEE_MACHINE start machine
define cm_state : 	State	:= 0;  
			Result 	: State;
test   Initialize(Result);
pass   Result = cm_state;
