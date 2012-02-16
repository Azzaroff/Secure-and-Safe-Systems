-- with Armageddon; 
with Byte_Utils, Mini_RC4, Shared;
with Ada.Command_Line, Ada.Real_Time, Ada.Text_IO;

use Byte_Utils, Mini_RC4, Shared;
use Ada.Command_Line, Ada.Real_Time, Ada.Text_IO;

procedure Main is
	
	--------------------------------------------------------------
	-- Variables
	--------------------------------------------------------------
	
	Max_Num_Seconds_For_Computation: Duration := 60.0;
	-- Number of tasks
	Num_Tasks_For_Computation:constant Positive := 8;
	
	Input_Stream:Byte_Array(0..255);
	Properties: Mini_RC4_Properties;
	
	--------------------------------------------------------------
	-- Worker Task
	--------------------------------------------------------------
	
	task type Worker_Task_Type is
		entry Attack_Mini_RC4;
	end Worker_Task_Type;
	
	task body Worker_Task_Type is
		Context: Context_Type;
		Key_Candidate: Key_Type;
		Short_Key_Stream: Byte_Array(0 .. 3);
		Key_Stream: Byte_Array(0 .. Input_Stream'Length - 1);
		Overflow: Boolean := False;
	begin
		accept Attack_Mini_RC4 do
			null;
		end Attack_Mini_RC4;
		
		loop
			Properties.Get_Incremented_Key_Candidate(Key_Candidate, Overflow);
			
			exit when Overflow or else Properties.Is_Done;
			
			Key_Scheduler(Key_Candidate, Context);
			Get_Keystream(Context, Short_Key_Stream);
			
			if Is_Subset(Short_Key_Stream, Input_Stream) then
				Key_Scheduler(Key_Candidate, Context);
				Get_Keystream(Context, Key_Stream);
				
				if Equal(Key_Stream, Input_Stream) then
					Properties.Set_Correct_Candidate(Key_Candidate);
					Properties.Interrupt;
					exit;
				end if;
			end if;
		end loop;
	end Worker_Task_Type;
	
	--------------------------------------------------------------
	-- Store the working tasks in an array
	--------------------------------------------------------------
	
	type Worker_Task_Pointer is access Worker_Task_Type;
	Workers_Array:array (1 .. Num_Tasks_For_Computation) of Worker_Task_Pointer; 
	
    --------------------------------------------------------------
    -- Observer Task
    --------------------------------------------------------------
	
    task type Observer_Task_Type is
		entry Start(Time: Duration);
    end Observer_Task_Type;
	
    task body Observer_Task_Type is
		Start_Time: Time;
		Max_Time, Current_Time: Duration;
		Keys_Per_Second: Natural;
    begin
		accept Start(Time: Duration) do
		    Start_Time := Clock;
		    Max_Time := Time;
		    Current_Time := 0.0;
		end Start;
		
		Put_Line("Observer started.");
		Put_Line("I have" & Integer(Max_Num_Seconds_For_Computation)'Img & " seconds for your computation."); 
		
		Timeout: -- checks once in a second (to save CPU time), if time is over
		while Current_Time < Max_Time loop
		    if Properties.Is_Done then
				Put_Line("All tasks finished..." & Properties.Is_Done'Img);
				exit Timeout;
	    	end if;
	    	
		    delay 1.0;
		    Current_Time := To_Duration(Clock - Start_Time);
		    
			Put(Integer(Current_Time)'Img & "/" & Integer(Max_Time)'Img & " seconds elapsed.");
			Put(Properties.Get_Key_Index'Img & " keys tested."); 
			
			if Integer(Current_Time) > 0 then
				Keys_Per_Second := Properties.Get_Key_Index / Integer(Current_Time);
				Put(Keys_Per_Second'Img & " keys/second.");
			end if;
			
			Put(" Current Key: ");	
			Put_Line(Properties.Get_Key_Candidate);
		end loop Timeout;
		
		if not Properties.Is_Done then
		    Properties.Interrupt;
		    Put_Line("Sorry, time is over...");
		    Put_Line("Current Key is ");
		    Put_Line(Properties.Get_Key_Candidate);
		end if;
    end Observer_Task_Type;
	
	Observer: access Observer_Task_Type;
	
	--------------------------------------------------------------
	-- Procedures and functions
	--------------------------------------------------------------
	
	procedure Read_Keystream_From_Command_Line(Keystream: out Byte_Array) is
		Input: constant String := Argument(1);
	begin
		if Argument_Count > 1 then
			Max_Num_Seconds_For_Computation := Duration'Value(Argument(2));
		end if;
		
		Keystream := To_Byte_Array(Input);
	end Read_Keystream_From_Command_Line;
	
	procedure Stop_Attack is
	begin
		Put_Line("Stopping tasks.");
		
		for I in Workers_Array'Range loop
			abort Workers_Array(I).all;
		end loop;
	end Stop_Attack;
	
 	function User_Has_Interrupted return Boolean is
		Command:Character;
		Available:Boolean := False;
	begin
		Ada.Text_IO.Get_Immediate(Command, Available);
		return Available and (Command = 'q' or Command = 'Q');
	end User_Has_Interrupted;
	
begin
	
	Read_Keystream_From_Command_Line(Input_Stream);
	Observer := new Observer_Task_Type;
	Observer.all.Start(Max_Num_Seconds_For_Computation);
	Put_Line("Starting attack with" & Num_Tasks_For_Computation'Img & " Task(s).");
	
	for I in Workers_Array'Range loop
		Workers_Array(I) := new Worker_Task_Type;
		Workers_Array(I).Attack_Mini_RC4;
	end loop;
	
	loop
		if User_Has_Interrupted then
			Properties.Interrupt;
			Put_Line("Abort by user.");
			exit;
		elsif Properties.Is_Done then
			Put_Line("Success! Found key candidate: ");
			Put_Line(Properties.Get_Correct_Candidate);
			Put_Line("For input ");
			Put_Line(Input_Stream);
			exit;
	    end if;
	end loop;
	
	Stop_Attack;
	abort Observer.all;
	
end Main;
