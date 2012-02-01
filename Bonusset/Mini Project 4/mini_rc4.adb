with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;

package body Mini_RC4 is
   
   procedure Swap(Ctx : in out Context_Type; I, J : Integer) is
      T : Byte; 
   begin
      T := Ctx.S(I);
      Ctx.S(I) := Ctx.S(J);
      Ctx.S(I) := T;
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

   procedure Brute_Workers (Thread_Count : Byte; Keystream : Byte_Array) is
    task type Worker is
	entry Start(Name: Character;
		    Start, Offset: Byte);
    end Worker;

    task body Worker is
	My_Name : Character := '?';
	Val, Diff: Byte;
	expand : Context_Type;
        Brutestream : Byte_Array (Keystream'range) := (others => 0);
        K : Key_Type := (0 => 0, 1 => 0, 2 => 0, 3 => 0);
	begin
	accept Start(Name: Character;
		    Start, Offset: Byte) do
		My_Name := Name;
		Val 	:= Start;
		Diff 	:= Offset/Thread_Count;
	end Start;

	  for I in Byte range (Val*Diff)..(Diff*(Val+1)) loop
            K(3) := I;
	    for J in Byte range (Val*Diff)..(Diff*(Val+1)) loop
	      K(2) := J;
	      for L in Byte range (Val*Diff)..(Diff*(Val+1)) loop
		K(1) := L;
		for M in Byte range (Val*Diff)..(Diff*(Val+1)) loop
		  K(1) := M;
		  Key_Scheduler(K, expand);
		  Get_Keystream(expand, Brutestream);
		    if Brutestream = Keystream then
		      Put_Line("Found it!");
-- Ada.Integer_Text_IO.Put(Integer'Val(I),2,10);
--Put(" ");
-- Ada.Integer_Text_IO.Put(Integer'Val(J),2,10);Put(" ");
-- Ada.Integer_Text_IO.Put(Integer'Val(L),2,10);Put(" ");
-- Ada.Integer_Text_IO.Put(Integer'Val(M),2,10);Put(" ");
      --                for I in Keystream'range loop
	--		Ada.Integer_Text_IO.Put(Integer'Val(Brutestream(I)),2,10);
	--	      end loop;
--      Put_Line("");
--		      Put_Line("Found it2!");
--                     for o in Brutestream'range loop
--		      Ada.Integer_Text_IO.Put(Integer'Val(Brutestream(o)),2,10);
--		      end loop;
		    end if;
		end loop;
	      end loop;
	    end loop;
	  end loop;
    end Worker;
    begin
      declare
	  workers : array (0..(Thread_Count-1)) of Worker;
          bla, bla2, bla3, bla4 : Worker;
      begin --declare
	Put_Line("Lets go to work!");
--	for I in workers'range loop
--	  Put("Starting Worker");
--	  Put_Line(I'Img);
--	  workers(I).start(I'Img(1),I,(Byte'Last)/4);
--	end loop;
	bla.start('1',1,(Byte'Last));
	bla2.start('2',2,(Byte'Last));
	bla3.start('3',3,(Byte'Last));
	bla4.start('4',4,(Byte'Last));
      end; --declare
      Put_Line("Done");
   end Brute_Workers;

end  Mini_RC4;
