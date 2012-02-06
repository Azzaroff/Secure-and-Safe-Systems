with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Task_Identification;

package body Mini_RC4 is

   Ragnaroek : Abort_Tasks;

   procedure Swap(Ctx : in out Context_Type; I, J : Integer) is
      T : Byte; 
   begin
      T := Ctx.S(I);
      Ctx.S(I) := Ctx.S(J);
      Ctx.S(J) := T;
   end Swap;
   
   procedure Key_Scheduler(Key : in Key_Type; Ctx : out Context_Type) is
      J : Byte := 0;
   begin
      for I in  Expanded_Key_Type'Range loop
	 Ctx.S(I) := Byte(I);
      end loop;
      
      for I  in  Expanded_Key_Type'Range loop
	 J := J +
	   Ctx.S(I) +
	   Key((I mod (Key_Type'Last+1)));
	 Swap(Ctx,I,Integer(J));
      end loop;
   end Key_Scheduler;  
   
   procedure Get_Keystream(Ctx : in out Context_Type; 
			   Keystream : out Byte_Array) is
      I : Byte := 0;
      J : Byte := 0;
   begin
      for K in Keystream'Range loop
	 I := I + 1;
	 J := J + Ctx.S(Integer(I));
	 Swap(Ctx, Integer(I), Integer(J));
	 Keystream(K) := Ctx.S( Integer( (Ctx.S(Integer(I)) 
					    + Ctx.S(Integer(J))) ));
      end loop;
   end Get_Keystream;

protected body Abort_Tasks is
  procedure Set_Done is
  begin
    Done := True;
  end Set_Done;

  function Is_Done return Boolean is
  begin
    return Done;
end Is_Done;

	
end Abort_Tasks;

   procedure Brute_Workers (Thread_Count : Positive; Keystream : Byte_Array) is
    task type Worker is
	entry Start(Name: Character;
		    Start, Offset: Natural);
    end Worker;

    task body Worker is
	My_Name : Character := '?';
	Val, Diff: Byte;
	expand : Context_Type;
        Brutestream : Byte_Array (Keystream'range) := (others => 0);
        K : Key_Type := (0 => 0, 1 => 0, 2 => 0, 3 => 0);
        This_Task : Ada.Task_Identification.Task_Id := Ada.Task_Identification.Current_Task;
	Command : Character;
	Available : Boolean;
	begin
	accept Start(Name: Character;
		    Start, Offset: Natural) do
		My_Name := Name;
		Val 	:= Byte'Val(Start);
		Diff 	:= Byte'Val(Offset);
	end Start;

	  for I in Byte range Val..Diff loop
            K(3) := I;
	    for J in Byte'range loop
	      K(2) := J;
	      for L in Byte'range loop
		K(1) := L;
		for M in Byte'range loop
		
		  K(0) := M;
		  Key_Scheduler(K, expand);
		  Get_Keystream(expand, Brutestream);

		    if Brutestream = Keystream then
		      Put_Line("Found it!");
		      Put("Key: ");
		      for I in Key_Type'range loop
			Ada.Integer_Text_IO.Put(Integer'Val(K(I)),2,16);
		      end loop;
		      Put_Line("");
                      Ragnaroek.Set_Done;
--                      for o in Brutestream'range loop
--			Ada.Integer_Text_IO.Put(Integer'Val(Brutestream(o)),2,10);
--		      end loop;
		    end if;

		    Ada.Text_IO.Get_Immediate (Command, Available);
		    if (Available and Command = 'q') or Ragnaroek.Is_Done then
		      Ragnaroek.Set_Done;
		    end if;
		    
		    if Ragnaroek.Is_Done then
		      Ada.Task_Identification.Abort_Task(This_Task);
		    end if;
		    
		end loop;
	      end loop;
	    end loop;
	  end loop;
    end Worker;
    begin
      declare
	  --workers : array (0..(Thread_Count-1)) of Worker;
          bla, bla2, bla3, bla4 : Worker;--,bla5, bla6, bla7, bla8 : Worker;
          offset : Natural := (Integer'Val(Byte'Last) + 1)/Thread_Count;
      begin --declare
	Put_Line("Offset: " & offset'img);
--	for I in workers'range loop
--	  Put("Starting Worker");
--	  Put_Line(I'Img);
--	  workers(I).start(I'Img(1),I,(Byte'Last));
--	end loop;

--	if Thread_Count > 3 then
	  bla.start('1',0,Offset-1);
	  bla2.start('2',1*(Offset),2*Offset - 1);
	  bla3.start('2',2*(Offset),3*Offset - 1);
	  bla4.start('2',3*(Offset),4*Offset - 1);
--	end if;
	
--	if Thread_Count = 8 then
--	  bla5.start('2',4*(Offset),5*Offset - 1);
--	  bla6.start('2',5*(Offset),6*Offset - 1);
--	  bla7.start('2',6*(Offset),7*Offset - 1);
--	  bla8.start('2',7*(Offset),8*Offset - 1);
--        end if;

-- Workers, y you no work when i put you in array?
      end; --declare
      Put_Line("Done");
   end Brute_Workers;

end  Mini_RC4;
