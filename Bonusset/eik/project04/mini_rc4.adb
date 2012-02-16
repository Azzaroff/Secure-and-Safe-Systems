-- see http://kuno-kohn.de/crypto/crypto/rc4.htm
package body Mini_RC4 is
	
	procedure Swap(Ctx: in out Context_Type; I, J: Integer) is
		T : Byte; 
	begin
		T := Ctx.S(I);
		Ctx.S(I) := Ctx.S(J);
		Ctx.S(J) := T;
	end Swap;
	
	procedure Key_Scheduler(Key: in Key_Type; Ctx: out Context_Type) is
		-- Initializes the context's S-Box.	
		J : Byte := 0;
	begin
		-- S-Box is filled up linearly: SBox[i] = i 
		for I in  Expanded_Key_Type'Range loop
			Ctx.S(I) := Byte(I);
		end loop;
		
		-- for i in 0 .. 255 loop
		-- 	j = (j + S[i] + K[i mod 256]) mod 256
		-- 	swap(S[i], S[j])
		-- end loop;
		for I  in  Expanded_Key_Type'Range loop
			J := J + Ctx.S(I) + Key((I mod (Key_Type'Last+1)));
			Swap(Ctx,I,Integer(J));
		end loop;
	end Key_Scheduler;  
	
	procedure Get_Keystream(Ctx: in out Context_Type; Keystream: out Byte_Array) is
		-- Generates the pseudo random keystream. The keystream is XORed with the
		-- plaintext to generate the cipher text.
		I : Byte := 0;
		J : Byte := 0;
	begin
		-- Erhöhe i um 1
    	-- Addiere S[i] zu j
    	-- Vertausche S[i] und S[j]
    	-- Setze die temporäre Variable t = S[i] + S[j]
    	-- Gib S[t] aus
		
		for K in Keystream'Range loop
			I := I + 1;
			J := J + Ctx.S(Integer(I));
			Swap(Ctx, Integer(I), Integer(J));
			Keystream(K) := Ctx.S(Integer((Ctx.S(Integer(I)) + Ctx.S(Integer(J)))));
		end loop;
	end Get_Keystream;
	
end  Mini_RC4;
