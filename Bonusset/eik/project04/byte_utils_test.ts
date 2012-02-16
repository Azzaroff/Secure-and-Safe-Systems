context with Ada.Text_IO; use Ada.Text_IO;
		with Byte_Utils; use Byte_Utils;
		with Mini_RC4; use Mini_RC4;
		with Ada.Numerics.Discrete_Random;

***** Test Increment First
define	Key: Byte_Array(0 .. 3);
		Overflow: Boolean := False;
prepare	Key := (0, 0, 0, 0);
test	Increment(Key, Overflow);
		Put_Line(Key);
pass	Key(0) = 0 and Key(1) = 0 and Key(2) = 0 and Key(3) = 1 and Overflow = False 

***** Test Increment Middle
define	Key: Byte_Array(0 .. 3);
		Overflow: Boolean := False;
prepare	Key := (27, 28, 29, 255);
test	Increment(Key, Overflow);
		Put_Line(Key);
pass	Key(0) = 27 and Key(1) = 28 and Key(2) = 30 and Key(3) = 0 and Overflow = False 

***** Test Increment End
define	Key: Byte_Array(0 .. 3);
		Overflow: Boolean := False;
prepare	Key := (255, 255, 255, 255);
test	Increment(Key, Overflow);
		Put_Line(Key);
pass	Key(0) = 0 and Key(1) = 0 and Key(2) = 0 and Key(3) = 0 and Overflow = True 

***** Test Get_Key
define	Key: Key_Type;
		Ctx: Context_Type;
		Keystream: Byte_Array(0 .. 255);
		
		package Random_Byte is new Ada.Numerics.Discrete_Random(Byte);
    	Seed:Random_Byte.Generator;
prepare Random_Byte.Reset(Seed);
		
		for I in Keystream'Range loop
			Key := (Random_Byte.Random(Seed), Random_Byte.Random(Seed), Random_Byte.Random(Seed), Random_Byte.Random(Seed));
			
			-- Put("Key:       ");
			-- Put_Line(Key); 
			
			Key_Scheduler(Key, Ctx);
			
			-- Put("S-Box:     ");
			-- Put_Line(Ctx.S);
			Get_Keystream(Ctx, Keystream);
			
			-- Put("Keystream: ");
			-- Put_Line(Keystream);
		end loop;
test	null;
pass	True

***** Test is Subset
define	Short: Byte_Array(0 .. 1) := (7, 8);
		Long: Byte_Array(0 .. 7) := (7, 8, 9, 10,  11, 12, 13, 14);
		Result: Boolean := False;
test	Result := Is_Subset(Short, Long);
pass	Result

***** Test is not a Subset
define	Short: Byte_Array(0 .. 3) := (7, 8, 9, 11);
		Long: Byte_Array(0 .. 7) := (7, 8, 9, 10,  11, 12, 13, 14);
		Result: Boolean := False;
test	Result := Is_Subset(Short, Long);
pass	Result = False

***** Test is not even close a Subset
define	Short: Byte_Array(0 .. 1) := (8, 10);
		Long: Byte_Array(0 .. 7) := (7, 8, 9, 10,  11, 12, 13, 14);
		Result: Boolean := False;
test	Result := Is_Subset(Short, Long);
pass	Result = False

***** Test is not a subset as it is longer 
define	Short: Byte_Array(0 .. 8) := (7, 8, 9, 10,  11, 12, 13, 14,  15);
		Long: Byte_Array(0 .. 7) := (7, 8, 9, 10,  11, 12, 13, 14);
		Result: Boolean := False;
test	Result := Is_Subset(Short, Long);
pass	Result = False

***** Test is a subset as it is equal
define	Short: Byte_Array(0 .. 7) := (7, 8, 9, 10,  11, 12, 13, 14);
		Long: Byte_Array(0 .. 7) := (7, 8, 9, 10,  11, 12, 13, 14);
		Result: Boolean := False;
test	Result := Is_Subset(Short, Long);
pass	Result

***** Test Create a Keystream
define	Key: Key_Type := (01, 02, 03, 04);
		Ctx: Context_Type;
		Keystream: Byte_Array(0 .. 255);
prepare Key_Scheduler(Key, Ctx);
		Get_Keystream(Ctx, Keystream);
		
		Put("Keystream: ");
		Put_Line(Keystream);
test	null;
pass	True

















